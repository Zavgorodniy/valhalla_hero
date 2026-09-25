-- Community: receipt scan, photo check-ins with moderation and likes,
-- event categories, bug reports.

-- ---------- config ----------
alter table economy_config
  add column checkin_xp int not null default 30,
  add column checkin_coins int not null default 50,
  add column checkin_daily_rewarded int not null default 1,   -- rewarded check-ins per day
  add column receipt_max_age_hours int not null default 48,  -- 0 = no age check (demo)
  add column receipt_daily_limit int not null default 1;     -- receipts credited per user, venue and day

alter type xp_reason add value if not exists 'checkin';
alter type coin_reason add value if not exists 'checkin';

-- ---------- events ----------
create type event_category as enum ('match', 'live', 'quiz', 'party', 'special');
alter table posts add column category event_category, add column ends_at timestamptz;

-- ---------- receipts ----------
-- POS terminals of each bar, keyed by the register serial printed in the
-- DSFinV-K / TSE QR code ("Kassen-Seriennummer").
create table venue_registers (
  serial text primary key,
  venue_id uuid not null references venues(id) on delete cascade,
  label text,
  created_at timestamptz not null default now()
);

-- One-time codes for receipts without a TSE QR (printed by the POS or handed out by staff).
create table receipt_codes (
  code text primary key,
  venue_id uuid not null references venues(id) on delete cascade,
  amount_cents int not null check (amount_cents > 0 and amount_cents <= 100000),
  expires_at timestamptz,
  used_by uuid references profiles(id) on delete set null,
  used_at timestamptz,
  created_by uuid references profiles(id),
  created_at timestamptz not null default now()
);

-- Every redeemed receipt, so one receipt can never count twice.
create table receipts (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  venue_id uuid not null references venues(id),
  kind text not null check (kind in ('tse', 'code')),
  register_serial text,
  transaction_no text not null,
  amount_cents int not null,
  receipt_at timestamptz,
  visit_id uuid references visits(id) on delete set null,
  created_at timestamptz not null default now(),
  unique (kind, register_serial, transaction_no)
);
create index receipts_user_idx on receipts (user_id, created_at desc);

-- ---------- photo check-ins ----------
create type checkin_status as enum ('pending', 'approved', 'rejected');

create table checkins (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  venue_id uuid references venues(id),
  event_id uuid references posts(id) on delete set null,
  photo_path text not null,
  caption text check (caption is null or char_length(caption) <= 200),
  status checkin_status not null default 'pending',
  reject_reason text,
  reviewed_by uuid references profiles(id),
  reviewed_at timestamptz,
  rewarded boolean not null default false,
  like_count int not null default 0,
  created_at timestamptz not null default now()
);
-- only one check-in may wait for moderation at a time
create unique index checkins_one_pending on checkins (user_id) where status = 'pending';
create index checkins_feed_idx on checkins (created_at desc) where status = 'approved';

create table checkin_likes (
  checkin_id uuid references checkins(id) on delete cascade,
  user_id uuid references profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (checkin_id, user_id)
);

-- ---------- bug reports ----------
create table feedback (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references profiles(id) on delete set null,
  message text not null check (char_length(message) between 1 and 4000),
  context jsonb not null default '{}',
  status text not null default 'new' check (status in ('new', 'seen', 'done')),
  created_at timestamptz not null default now()
);

-- ---------- storage ----------
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('checkins', 'checkins', true, 6291456, array['image/jpeg', 'image/png', 'image/webp', 'image/heic'])
on conflict (id) do nothing;

create policy checkins_upload_own on storage.objects for insert to authenticated
  with check (bucket_id = 'checkins' and (storage.foldername(name))[1] = auth.uid()::text);
create policy checkins_delete_own on storage.objects for delete to authenticated
  using (bucket_id = 'checkins' and ((storage.foldername(name))[1] = auth.uid()::text or is_manager()));

-- ---------- RLS ----------
alter table venue_registers enable row level security;
alter table receipt_codes enable row level security;
alter table receipts enable row level security;
alter table checkins enable row level security;
alter table checkin_likes enable row level security;
alter table feedback enable row level security;

create policy registers_admin on venue_registers for all to authenticated using (is_admin()) with check (is_admin());
create policy registers_staff_read on venue_registers for select to authenticated using (is_staff());
create policy receipt_codes_staff on receipt_codes for all to authenticated using (is_manager()) with check (is_manager());
create policy receipts_own on receipts for select to authenticated using (user_id = auth.uid() or is_staff());

create policy checkins_read on checkins for select to authenticated
  using (status = 'approved' or user_id = auth.uid() or is_staff());
create policy checkin_likes_read on checkin_likes for select to authenticated using (true);

create policy feedback_insert on feedback for insert to authenticated with check (user_id = auth.uid());
create policy feedback_read on feedback for select to authenticated using (user_id = auth.uid() or is_manager());
create policy feedback_update on feedback for update to authenticated using (is_manager()) with check (is_manager());

-- Public feed with author info (profiles themselves stay private).
create or replace view checkin_feed as
select c.id, c.user_id, c.venue_id, c.event_id, c.photo_path, c.caption, c.like_count, c.created_at,
       p.nickname, p.level, p.hero_form,
       e.title as event_title,
       exists (select 1 from checkin_likes l where l.checkin_id = c.id and l.user_id = auth.uid()) as liked_by_me
from checkins c
join profiles p on p.id = c.user_id
left join posts e on e.id = c.event_id
where c.status = 'approved';
grant select on checkin_feed to authenticated;

-- Moderation queue for staff, with author info.
create or replace view checkin_queue as
select c.id, c.user_id, c.venue_id, c.event_id, c.photo_path, c.caption, c.created_at,
       p.nickname, p.level, p.hero_form, p.visit_count,
       e.title as event_title
from checkins c
join profiles p on p.id = c.user_id
left join posts e on e.id = c.event_id
where c.status = 'pending' and is_staff();
grant select on checkin_queue to authenticated;

-- ---------- receipts: redeem ----------
-- Accepts either a DSFinV-K receipt QR ("V0;serial;type;data;tx;counter;start;end;alg;fmt;sig;pubkey")
-- or a one-time receipt code. Credits the visit immediately.
-- NOTE: the TSE signature is not verified yet (the bar's POS is not chosen);
-- protection comes from the register whitelist, one-time transaction numbers,
-- the age window and the daily limit.
create or replace function redeem_receipt(p_payload text)
returns jsonb language plpgsql security definer set search_path = public as $$
declare
  cfg economy_config; v_uid uuid := auth.uid(); v_parts text[]; v_serial text; v_tx text; v_data text;
  v_amounts text; v_amount numeric := 0; v_part text; v_at timestamptz; v_venue uuid; v_cents int;
  v_code receipt_codes; v_kind text; v_today int; v_visit uuid; p profiles; q profiles;
begin
  if v_uid is null then raise exception 'not authenticated'; end if;
  select * into cfg from economy_config where id = 1;
  p_payload := trim(coalesce(p_payload, ''));
  if p_payload = '' then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;

  if p_payload like 'V0;%' then
    v_kind := 'tse';
    v_parts := string_to_array(p_payload, ';');
    if array_length(v_parts, 1) < 8 then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    v_serial := v_parts[2];
    v_data := v_parts[4];
    v_tx := v_parts[5];
    begin
      v_at := v_parts[7]::timestamptz;
    exception when others then
      raise exception 'RECEIPT_INVALID' using errcode = 'P0001';
    end;
    -- processData "Beleg^<gross per VAT rate, _-separated>^<payments>"
    v_amounts := split_part(v_data, '^', 2);
    if v_amounts = '' then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    foreach v_part in array string_to_array(v_amounts, '_') loop
      if v_part ~ '^-?[0-9]+(\.[0-9]+)?$' then v_amount := v_amount + v_part::numeric; end if;
    end loop;
    v_cents := round(v_amount * 100);
    select venue_id into v_venue from venue_registers where serial = v_serial;
    if v_venue is null then raise exception 'RECEIPT_UNKNOWN_VENUE' using errcode = 'P0001'; end if;
    if v_at > now() + interval '10 minutes' then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    if cfg.receipt_max_age_hours > 0 and v_at < now() - make_interval(hours => cfg.receipt_max_age_hours) then
      raise exception 'RECEIPT_TOO_OLD' using errcode = 'P0001';
    end if;
  else
    v_kind := 'code';
    v_tx := upper(regexp_replace(p_payload, '^(VH:|vh:)', ''));
    v_tx := regexp_replace(v_tx, '[^A-Z0-9-]', '', 'g');
    select * into v_code from receipt_codes where code = v_tx for update;
    if v_code.code is null then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
    if v_code.used_at is not null then raise exception 'RECEIPT_USED' using errcode = 'P0001'; end if;
    if v_code.expires_at is not null and v_code.expires_at < now() then raise exception 'RECEIPT_TOO_OLD' using errcode = 'P0001'; end if;
    v_venue := v_code.venue_id;
    v_cents := v_code.amount_cents;
    v_at := now();
  end if;

  if v_cents <= 0 or v_cents > 100000 then raise exception 'RECEIPT_INVALID' using errcode = 'P0001'; end if;
  if exists (select 1 from receipts where kind = v_kind and register_serial is not distinct from v_serial and transaction_no = v_tx) then
    raise exception 'RECEIPT_USED' using errcode = 'P0001';
  end if;
  select count(*) into v_today from receipts
    where user_id = v_uid and venue_id = v_venue
      and (created_at at time zone 'Europe/Berlin')::date = (now() at time zone 'Europe/Berlin')::date;
  if v_today >= cfg.receipt_daily_limit then raise exception 'RECEIPT_DAILY_LIMIT' using errcode = 'P0001'; end if;

  select * into p from profiles where id = v_uid;
  v_visit := record_visit(v_uid, v_venue, v_cents, 'receipt', null, v_uid, least(v_at, now()));
  insert into receipts (user_id, venue_id, kind, register_serial, transaction_no, amount_cents, receipt_at, visit_id)
  values (v_uid, v_venue, v_kind, v_serial, v_tx, v_cents, v_at, v_visit);
  if v_kind = 'code' then update receipt_codes set used_by = v_uid, used_at = now() where code = v_tx; end if;
  select * into q from profiles where id = v_uid;

  return jsonb_build_object(
    'visit_id', v_visit, 'venue_id', v_venue, 'amount_cents', v_cents,
    'xp_gained', q.xp - p.xp, 'coins_gained', q.coin_balance - p.coin_balance,
    'level_before', p.level, 'level_after', q.level, 'streak_weeks', q.current_streak_weeks,
    -- unlocked by this very transaction
    'achievements', (select coalesce(jsonb_agg(achievement_key), '[]'::jsonb) from user_achievements
                     where user_id = v_uid and unlocked_at = now()));
end $$;

-- ---------- check-ins ----------
create or replace function submit_checkin(p_photo_path text, p_caption text default null, p_event uuid default null, p_venue uuid default null)
returns checkins language plpgsql security definer set search_path = public as $$
declare c checkins; v_uid uuid := auth.uid();
begin
  if v_uid is null then raise exception 'not authenticated'; end if;
  if p_photo_path is null or split_part(p_photo_path, '/', 1) <> v_uid::text then
    raise exception 'CHECKIN_INVALID' using errcode = 'P0001';
  end if;
  if exists (select 1 from checkins where user_id = v_uid and status = 'pending') then
    raise exception 'CHECKIN_PENDING' using errcode = 'P0001';
  end if;
  insert into checkins (user_id, venue_id, event_id, photo_path, caption)
  values (v_uid, coalesce(p_venue, (select id from venues where is_active order by name limit 1)), p_event, p_photo_path, nullif(trim(p_caption), ''))
  returning * into c;
  return c;
end $$;

create or replace function withdraw_checkin(p_checkin uuid) returns void
language plpgsql security definer set search_path = public as $$
begin
  delete from checkins where id = p_checkin and user_id = auth.uid() and status in ('pending', 'rejected');
end $$;

create or replace function review_checkin(p_checkin uuid, p_approve boolean, p_reason text default null)
returns checkins language plpgsql security definer set search_path = public as $$
declare c checkins; cfg economy_config; v_rewarded int; v_reward boolean := false;
begin
  if not is_staff() then raise exception 'FORBIDDEN' using errcode = 'P0001'; end if;
  select * into cfg from economy_config where id = 1;
  select * into c from checkins where id = p_checkin for update;
  if c.id is null then raise exception 'not found'; end if;
  if c.status <> 'pending' then raise exception 'ALREADY_REVIEWED' using errcode = 'P0001'; end if;
  if p_approve then
    select count(*) into v_rewarded from checkins
      where user_id = c.user_id and rewarded
        and (reviewed_at at time zone 'Europe/Berlin')::date = (now() at time zone 'Europe/Berlin')::date;
    v_reward := v_rewarded < cfg.checkin_daily_rewarded;
  end if;
  update checkins set
    status = case when p_approve then 'approved'::checkin_status else 'rejected'::checkin_status end,
    reviewed_by = auth.uid(), reviewed_at = now(), rewarded = v_reward,
    reject_reason = case when p_approve then null else p_reason end
  where id = p_checkin returning * into c;
  if p_approve then
    if v_reward then
      perform add_xp(c.user_id, cfg.checkin_xp, 'checkin', c.id::text);
      perform add_coins(c.user_id, cfg.checkin_coins, 'checkin', c.id::text);
    end if;
    perform notify(c.user_id, 'checkin_approved', 'Foto freigegeben', 'Photo approved',
      case when v_reward then '+' || cfg.checkin_xp || ' XP, +' || cfg.checkin_coins || ' Münzen – dein Foto ist in der Saga.' else 'Dein Foto ist jetzt in der Saga.' end,
      case when v_reward then '+' || cfg.checkin_xp || ' XP, +' || cfg.checkin_coins || ' coins – your photo is in the saga.' else 'Your photo is now in the saga.' end,
      jsonb_build_object('checkin_id', c.id, 'rewarded', v_reward));
    perform check_checkin_achievements(c.user_id);
  else
    perform notify(c.user_id, 'checkin_rejected', 'Foto nicht freigegeben', 'Photo not approved',
      coalesce(p_reason, 'Nur Fotos aus der Halle oder mit Valhalla-Merch.'), coalesce(p_reason, 'Only photos from the hall or with Valhalla merch.'),
      jsonb_build_object('checkin_id', c.id));
  end if;
  return c;
end $$;

create or replace function toggle_checkin_like(p_checkin uuid) returns boolean
language plpgsql security definer set search_path = public as $$
declare v_uid uuid := auth.uid(); v_liked boolean;
begin
  if v_uid is null then raise exception 'not authenticated'; end if;
  if not exists (select 1 from checkins where id = p_checkin and status = 'approved') then raise exception 'not found'; end if;
  if exists (select 1 from checkin_likes where checkin_id = p_checkin and user_id = v_uid) then
    delete from checkin_likes where checkin_id = p_checkin and user_id = v_uid;
    update checkins set like_count = greatest(like_count - 1, 0) where id = p_checkin;
    v_liked := false;
  else
    insert into checkin_likes (checkin_id, user_id) values (p_checkin, v_uid);
    update checkins set like_count = like_count + 1 where id = p_checkin;
    v_liked := true;
  end if;
  return v_liked;
end $$;

create or replace function check_checkin_achievements(p_user uuid) returns void
language plpgsql security definer set search_path = public as $$
declare v_count int;
begin
  select count(*) into v_count from checkins where user_id = p_user and status = 'approved';
  if v_count >= 1 then perform grant_achievement(p_user, 'first_checkin'); end if;
  if v_count >= 10 then perform grant_achievement(p_user, 'checkins_10'); end if;
end $$;

insert into achievements (key, name_de, name_en, description_de, description_en, icon, xp_reward, coin_reward, sort) values
  ('first_checkin', 'Erster Schnappschuss', 'First Snapshot', 'Erstes Foto in der Saga.', 'First photo in the saga.', 'rune', 20, 30, 17),
  ('checkins_10', 'Chronist der Halle', 'Chronicler of the Hall', '10 Fotos in der Saga.', '10 photos in the saga.', 'drum', 120, 150, 18)
on conflict (key) do nothing;

-- ---------- GDPR export includes the new data ----------
create or replace function export_my_data() returns jsonb
language sql security definer set search_path = public as $$
  select jsonb_build_object(
    'profile', (select to_jsonb(p) from profiles p where id = auth.uid()),
    'visits', (select coalesce(jsonb_agg(to_jsonb(v)), '[]') from visits v where user_id = auth.uid()),
    'visit_claims', (select coalesce(jsonb_agg(to_jsonb(c)), '[]') from visit_claims c where user_id = auth.uid()),
    'receipts', (select coalesce(jsonb_agg(to_jsonb(r)), '[]') from receipts r where user_id = auth.uid()),
    'checkins', (select coalesce(jsonb_agg(to_jsonb(c)), '[]') from checkins c where user_id = auth.uid()),
    'checkin_likes', (select coalesce(jsonb_agg(to_jsonb(l)), '[]') from checkin_likes l where user_id = auth.uid()),
    'xp_ledger', (select coalesce(jsonb_agg(to_jsonb(x)), '[]') from xp_ledger x where user_id = auth.uid()),
    'coin_ledger', (select coalesce(jsonb_agg(to_jsonb(c)), '[]') from coin_ledger c where user_id = auth.uid()),
    'vouchers', (select coalesce(jsonb_agg(to_jsonb(v)), '[]') from vouchers v where user_id = auth.uid()),
    'items', (select coalesce(jsonb_agg(to_jsonb(i)), '[]') from user_items i where user_id = auth.uid()),
    'achievements', (select coalesce(jsonb_agg(to_jsonb(a)), '[]') from user_achievements a where user_id = auth.uid()),
    'likes', (select coalesce(jsonb_agg(to_jsonb(l)), '[]') from post_likes l where user_id = auth.uid()),
    'feedback', (select coalesce(jsonb_agg(to_jsonb(f)), '[]') from feedback f where user_id = auth.uid()),
    'exported_at', now())
$$;
