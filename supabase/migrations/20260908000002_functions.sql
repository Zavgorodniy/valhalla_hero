-- Valhalla Hero: server-side economy. All crediting happens here.
set search_path = public;

-- ---------- helpers ----------
create or replace function role_of(p_user uuid) returns user_role
language sql stable security definer set search_path = public as $$
  select role from profiles where id = p_user
$$;

create or replace function is_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select coalesce(role_of(auth.uid()) = 'admin', false)
$$;

create or replace function is_staff() returns boolean
language sql stable security definer set search_path = public as $$
  select coalesce(role_of(auth.uid()) in ('staff', 'manager', 'admin'), false)
$$;

create or replace function is_manager() returns boolean
language sql stable security definer set search_path = public as $$
  select coalesce(role_of(auth.uid()) in ('manager', 'admin'), false)
$$;

create or replace function manages_venue(p_venue uuid) returns boolean
language sql stable security definer set search_path = public as $$
  select is_admin() or exists (
    select 1 from venue_staff where user_id = auth.uid() and venue_id = p_venue)
$$;

create or replace function berlin_week(ts timestamptz) returns date
language sql immutable as $$
  select (date_trunc('week', ts at time zone 'Europe/Berlin'))::date
$$;

create or replace function level_for_xp(p_xp int) returns int
language sql stable set search_path = public as $$
  select coalesce(max(level), 1) from levels where xp_threshold <= p_xp
$$;

create or replace function notify(
  p_user uuid, p_type text, p_title_de text, p_title_en text,
  p_body_de text default null, p_body_en text default null, p_data jsonb default '{}'
) returns void language sql security definer set search_path = public as $$
  insert into notifications (user_id, type, title_de, title_en, body_de, body_en, data)
  values (p_user, p_type, p_title_de, p_title_en, p_body_de, p_body_en, p_data)
$$;

-- ---------- new user -> profile ----------
create or replace function handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_nick text := coalesce(new.raw_user_meta_data->>'nickname', 'viking_' || left(replace(new.id::text, '-', ''), 6));
  v_birth date := coalesce((new.raw_user_meta_data->>'birth_date')::date, null);
begin
  if v_birth is null then
    -- social sign-ups complete onboarding later; block until DOB is set via complete_onboarding()
    return new;
  end if;
  insert into profiles (id, nickname, birth_date, locale)
  values (new.id, v_nick, v_birth, coalesce(new.raw_user_meta_data->>'locale', 'de'))
  on conflict (id) do nothing;
  return new;
end $$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created after insert on auth.users
  for each row execute function handle_new_user();

-- Called by the client after social login when no profile exists yet.
create or replace function complete_onboarding(p_nickname text, p_birth_date date, p_locale text default 'de')
returns profiles language plpgsql security definer set search_path = public as $$
declare v profiles;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  if p_birth_date > current_date - interval '18 years' then
    raise exception 'AGE_RESTRICTED' using errcode = 'P0001';
  end if;
  insert into profiles (id, nickname, birth_date, locale)
  values (auth.uid(), p_nickname, p_birth_date, p_locale)
  on conflict (id) do update set nickname = excluded.nickname
  returning * into v;
  return v;
end $$;

-- ---------- XP ----------
create or replace function add_xp(p_user uuid, p_amount int, p_reason xp_reason, p_ref text default null)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_old_level int; v_new_level int; v_xp int; v_name text; r record;
begin
  if p_amount = 0 then return; end if;
  insert into xp_ledger (user_id, amount, reason, ref_id) values (p_user, p_amount, p_reason, p_ref);
  update profiles set xp = xp + p_amount where id = p_user returning xp, level into v_xp, v_old_level;
  v_new_level := level_for_xp(v_xp);
  if v_new_level > v_old_level then
    update profiles set level = v_new_level where id = p_user;
    select name into v_name from levels where level = v_new_level;
    for r in select id from items where source = 'level' and is_active and unlock_level > v_old_level and unlock_level <= v_new_level loop
      insert into user_items (user_id, item_id, source) values (p_user, r.id, 'level') on conflict do nothing;
    end loop;
    perform notify(p_user, 'level_up',
      'Neue Stufe: ' || v_name, 'New level: ' || v_name,
      'Du bist jetzt ' || v_name || '. Skål!', 'You are now ' || v_name || '. Skål!',
      jsonb_build_object('level', v_new_level));
  end if;
end $$;

-- ---------- coins ----------
create or replace function add_coins(p_user uuid, p_amount int, p_reason coin_reason, p_ref text default null)
returns void language plpgsql security definer set search_path = public as $$
declare v_months int;
begin
  if p_amount <= 0 then return; end if;
  select coin_expiry_months into v_months from economy_config where id = 1;
  insert into coin_ledger (user_id, amount, remaining, reason, ref_id, expires_at)
  values (p_user, p_amount, p_amount, p_reason, p_ref, now() + make_interval(months => v_months));
  update profiles set coin_balance = coin_balance + p_amount where id = p_user;
end $$;

create or replace function spend_coins(p_user uuid, p_amount int, p_reason coin_reason, p_ref text default null)
returns void language plpgsql security definer set search_path = public as $$
declare v_balance int; v_left int := p_amount; r record; v_take int;
begin
  if p_amount <= 0 then raise exception 'invalid amount'; end if;
  select coin_balance into v_balance from profiles where id = p_user for update;
  if v_balance < p_amount then raise exception 'INSUFFICIENT_COINS' using errcode = 'P0001'; end if;
  for r in select id, remaining from coin_ledger
           where user_id = p_user and remaining > 0
           order by expires_at asc nulls last, created_at asc
           for update loop
    exit when v_left = 0;
    v_take := least(r.remaining, v_left);
    update coin_ledger set remaining = remaining - v_take where id = r.id;
    v_left := v_left - v_take;
  end loop;
  insert into coin_ledger (user_id, amount, remaining, reason, ref_id) values (p_user, -p_amount, 0, p_reason, p_ref);
  update profiles set coin_balance = coin_balance - p_amount where id = p_user;
end $$;

create or replace function expire_coins() returns int
language plpgsql security definer set search_path = public as $$
declare r record; n int := 0;
begin
  for r in select id, user_id, remaining from coin_ledger
           where remaining > 0 and expires_at is not null and expires_at < now() for update loop
    update coin_ledger set remaining = 0 where id = r.id;
    insert into coin_ledger (user_id, amount, remaining, reason, ref_id) values (r.user_id, -r.remaining, 0, 'expiry', r.id::text);
    update profiles set coin_balance = coin_balance - r.remaining where id = r.user_id;
    n := n + 1;
  end loop;
  return n;
end $$;

create or replace function notify_expiring_coins() returns int
language plpgsql security definer set search_path = public as $$
declare r record; n int := 0;
begin
  for r in select user_id, sum(remaining) as total, min(expires_at) as first_exp
           from coin_ledger
           where remaining > 0 and expires_at between now() and now() + interval '30 days'
           group by user_id loop
    if not exists (select 1 from notifications where user_id = r.user_id and type = 'coins_expiring' and created_at > now() - interval '30 days') then
      perform notify(r.user_id, 'coins_expiring',
        'Münzen laufen bald ab', 'Coins expiring soon',
        r.total || ' Münzen verfallen ab dem ' || to_char(r.first_exp at time zone 'Europe/Berlin', 'DD.MM.YYYY') || '. Löse sie ein!',
        r.total || ' coins expire from ' || to_char(r.first_exp at time zone 'Europe/Berlin', 'DD.MM.YYYY') || '. Redeem them!',
        jsonb_build_object('amount', r.total, 'expires_at', r.first_exp));
      n := n + 1;
    end if;
  end loop;
  return n;
end $$;

-- ---------- achievements ----------
create or replace function grant_achievement(p_user uuid, p_key text) returns boolean
language plpgsql security definer set search_path = public as $$
declare a achievements; r record;
begin
  if exists (select 1 from user_achievements where user_id = p_user and achievement_key = p_key) then return false; end if;
  select * into a from achievements where key = p_key;
  if a.key is null then return false; end if;
  insert into user_achievements (user_id, achievement_key) values (p_user, p_key);
  perform add_xp(p_user, a.xp_reward, 'achievement', p_key);
  perform add_coins(p_user, a.coin_reward, 'achievement', p_key);
  for r in select id from items where source = 'achievement' and is_active and unlock_achievement_key = p_key loop
    insert into user_items (user_id, item_id, source) values (p_user, r.id, 'achievement') on conflict do nothing;
  end loop;
  perform notify(p_user, 'achievement', 'Erfolg: ' || a.name_de, 'Achievement: ' || a.name_en,
    a.description_de, a.description_en, jsonb_build_object('key', p_key));
  return true;
end $$;

create or replace function check_achievements(p_user uuid) returns void
language plpgsql security definer set search_path = public as $$
declare p profiles; v_visits int; v_events int; v_likes int; v_vouchers int; v_shop_items int; v_venues int; v_active_venues int;
begin
  select * into p from profiles where id = p_user;
  v_visits := p.visit_count;
  if v_visits >= 1 then perform grant_achievement(p_user, 'first_visit'); end if;
  if v_visits >= 5 then perform grant_achievement(p_user, 'visits_5'); end if;
  if v_visits >= 25 then perform grant_achievement(p_user, 'visits_25'); end if;
  if v_visits >= 50 then perform grant_achievement(p_user, 'visits_50'); end if;
  if v_visits >= 100 then perform grant_achievement(p_user, 'visits_100'); end if;
  if p.longest_streak_weeks >= 4 then perform grant_achievement(p_user, 'streak_4w'); end if;
  if p.longest_streak_weeks >= 12 then perform grant_achievement(p_user, 'streak_12w'); end if;
  select count(*) into v_events from vouchers v join rewards r on r.id = v.reward_id
    where v.user_id = p_user and v.status = 'redeemed' and r.type = 'event_access';
  if v_events >= 3 then perform grant_achievement(p_user, 'events_3'); end if;
  if v_events >= 10 then perform grant_achievement(p_user, 'events_10'); end if;
  select count(*) into v_likes from post_likes where user_id = p_user;
  if v_likes >= 10 then perform grant_achievement(p_user, 'liked_10'); end if;
  select count(*) into v_vouchers from vouchers where user_id = p_user;
  if v_vouchers >= 1 then perform grant_achievement(p_user, 'first_reward'); end if;
  if v_vouchers >= 5 then perform grant_achievement(p_user, 'rewards_5'); end if;
  select count(*) into v_shop_items from user_items where user_id = p_user and source = 'shop';
  if v_shop_items >= 1 then perform grant_achievement(p_user, 'first_item'); end if;
  if p.level >= 4 then perform grant_achievement(p_user, 'level_4'); end if;
  if p.level >= 8 then perform grant_achievement(p_user, 'level_8'); end if;
  select count(distinct venue_id) into v_venues from visits where user_id = p_user;
  select count(*) into v_active_venues from venues where is_active;
  if v_active_venues >= 2 and v_venues >= v_active_venues then perform grant_achievement(p_user, 'venues_all'); end if;
end $$;

-- ---------- visits ----------
create or replace function record_visit(
  p_user uuid, p_venue uuid, p_amount_cents int, p_source visit_source,
  p_claim_id uuid default null, p_actor uuid default null, p_visited_at timestamptz default now()
) returns uuid language plpgsql security definer set search_path = public as $$
declare
  cfg economy_config; p profiles; v_visit_id uuid;
  v_this_week date; v_last_week date; v_streak int; v_extended boolean := false;
  v_mult numeric; v_coins int; v_today int; v_xp int;
begin
  select * into cfg from economy_config where id = 1;
  select * into p from profiles where id = p_user for update;
  if p.id is null then raise exception 'unknown user'; end if;

  insert into visits (user_id, venue_id, claim_id, amount_cents, source, visited_at, created_by)
  values (p_user, p_venue, p_claim_id, p_amount_cents, p_source, p_visited_at, p_actor)
  returning id into v_visit_id;

  -- weekly streak (Europe/Berlin, weeks start Monday)
  v_this_week := berlin_week(p_visited_at);
  v_streak := p.current_streak_weeks;
  if p.last_visit_at is null then
    v_streak := 1; v_extended := false;
  else
    v_last_week := berlin_week(p.last_visit_at);
    if v_last_week = v_this_week then
      null; -- same week, streak unchanged
    elsif v_last_week = v_this_week - 7 then
      v_streak := v_streak + 1; v_extended := true;
    elsif v_this_week > v_last_week then
      v_streak := 1;
    end if;
  end if;

  update profiles set
    visit_count = visit_count + 1,
    last_visit_at = greatest(coalesce(last_visit_at, p_visited_at), p_visited_at),
    current_streak_weeks = v_streak,
    longest_streak_weeks = greatest(longest_streak_weeks, v_streak)
  where id = p_user;

  -- XP: fixed per visit (never proportional to the bill) + streak bonus
  v_xp := cfg.xp_per_visit;
  perform add_xp(p_user, v_xp, 'visit', v_visit_id::text);
  if v_extended then perform add_xp(p_user, cfg.streak_bonus_xp * least(v_streak, 4), 'streak', v_visit_id::text); end if;

  -- coins: per euro × level multiplier, daily cap
  select coin_multiplier into v_mult from levels where level = p.level;
  v_coins := floor(cfg.coins_per_euro * (p_amount_cents / 100.0) * coalesce(v_mult, 1));
  -- daily cap is per visit day (Europe/Berlin), so back-dated credits count towards their own day
  select coalesce(sum(cl.amount), 0) into v_today
    from coin_ledger cl join visits vi on vi.id::text = cl.ref_id
    where cl.user_id = p_user and cl.reason = 'visit' and cl.amount > 0
      and (vi.visited_at at time zone 'Europe/Berlin')::date = (p_visited_at at time zone 'Europe/Berlin')::date;
  v_coins := least(v_coins, greatest(cfg.daily_coin_cap - v_today, 0));
  perform add_coins(p_user, v_coins, 'visit', v_visit_id::text);

  perform notify(p_user, 'visit_credited', 'Besuch gutgeschrieben', 'Visit credited',
    '+' || v_xp || ' XP, +' || v_coins || ' Münzen', '+' || v_xp || ' XP, +' || v_coins || ' coins',
    jsonb_build_object('visit_id', v_visit_id, 'xp', v_xp, 'coins', v_coins));

  perform check_achievements(p_user);
  return v_visit_id;
end $$;

create or replace function submit_visit_claim(p_venue uuid, p_amount_cents int, p_note text default null)
returns visit_claims language plpgsql security definer set search_path = public as $$
declare c visit_claims;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  if (select count(*) from visit_claims where user_id = auth.uid() and status = 'pending') >= 10 then
    raise exception 'TOO_MANY_PENDING' using errcode = 'P0001';
  end if;
  insert into visit_claims (user_id, venue_id, amount_cents, note)
  values (auth.uid(), p_venue, p_amount_cents, p_note) returning * into c;
  return c;
end $$;

create or replace function review_visit_claim(p_claim uuid, p_approve boolean, p_reason text default null)
returns visit_claims language plpgsql security definer set search_path = public as $$
declare c visit_claims;
begin
  if not is_staff() then raise exception 'FORBIDDEN' using errcode = 'P0001'; end if;
  select * into c from visit_claims where id = p_claim for update;
  if c.id is null then raise exception 'not found'; end if;
  if c.status <> 'pending' then raise exception 'ALREADY_REVIEWED' using errcode = 'P0001'; end if;
  update visit_claims set
    status = case when p_approve then 'approved'::claim_status else 'rejected'::claim_status end,
    reviewed_by = auth.uid(), reviewed_at = now(), reject_reason = case when p_approve then null else p_reason end
  where id = p_claim returning * into c;
  if p_approve then
    perform record_visit(c.user_id, c.venue_id, c.amount_cents, 'claim', c.id, auth.uid(), c.created_at);
  else
    perform notify(c.user_id, 'claim_rejected', 'Besuch abgelehnt', 'Visit rejected',
      coalesce(p_reason, 'Bitte wende dich an das Team.'), coalesce(p_reason, 'Please contact the team.'),
      jsonb_build_object('claim_id', c.id));
  end if;
  return c;
end $$;

create or replace function admin_credit_visit(p_user uuid, p_venue uuid, p_amount_cents int)
returns uuid language plpgsql security definer set search_path = public as $$
begin
  if not is_manager() then raise exception 'FORBIDDEN' using errcode = 'P0001'; end if;
  return record_visit(p_user, p_venue, p_amount_cents, 'manual', null, auth.uid());
end $$;

-- ---------- rewards & vouchers ----------
create or replace function gen_voucher_code() returns text
language plpgsql as $$
declare alphabet text := 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; v_code text; i int;
begin
  loop
    v_code := '';
    for i in 1..6 loop v_code := v_code || substr(alphabet, 1 + floor(random() * 32)::int, 1); end loop;
    exit when not exists (select 1 from vouchers where vouchers.code = v_code);
  end loop;
  return v_code;
end $$;

create or replace function redeem_reward(p_reward uuid) returns vouchers
language plpgsql security definer set search_path = public as $$
declare r rewards; v vouchers;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  select * into r from rewards where id = p_reward for update;
  if r.id is null or not r.is_active then raise exception 'REWARD_UNAVAILABLE' using errcode = 'P0001'; end if;
  if r.stock is not null and r.stock <= 0 then raise exception 'OUT_OF_STOCK' using errcode = 'P0001'; end if;
  perform spend_coins(auth.uid(), r.price_coins, 'reward', r.id::text);
  if r.stock is not null then update rewards set stock = stock - 1 where id = r.id; end if;
  insert into vouchers (user_id, reward_id, code, price_paid, expires_at)
  values (auth.uid(), r.id, gen_voucher_code(), r.price_coins, now() + make_interval(days => r.validity_days))
  returning * into v;
  perform check_achievements(auth.uid());
  return v;
end $$;

create or replace function lookup_voucher(p_code text) returns jsonb
language plpgsql security definer set search_path = public as $$
declare v vouchers; r rewards; p profiles;
begin
  if not is_staff() then raise exception 'FORBIDDEN' using errcode = 'P0001'; end if;
  select * into v from vouchers where code = upper(trim(p_code));
  if v.id is null then return null; end if;
  select * into r from rewards where id = v.reward_id;
  select * into p from profiles where id = v.user_id;
  return jsonb_build_object(
    'voucher', to_jsonb(v), 'reward', to_jsonb(r),
    'user', jsonb_build_object('nickname', p.nickname, 'level', p.level));
end $$;

create or replace function confirm_voucher(p_code text, p_venue uuid default null) returns vouchers
language plpgsql security definer set search_path = public as $$
declare v vouchers;
begin
  if not is_staff() then raise exception 'FORBIDDEN' using errcode = 'P0001'; end if;
  select * into v from vouchers where code = upper(trim(p_code)) for update;
  if v.id is null then raise exception 'NOT_FOUND' using errcode = 'P0001'; end if;
  if v.status <> 'active' then raise exception 'VOUCHER_NOT_ACTIVE' using errcode = 'P0001'; end if;
  if v.expires_at < now() then
    update vouchers set status = 'expired' where id = v.id;
    raise exception 'VOUCHER_EXPIRED' using errcode = 'P0001';
  end if;
  update vouchers set status = 'redeemed', redeemed_at = now(), redeemed_by = auth.uid(), redeemed_at_venue = p_venue
  where id = v.id returning * into v;
  perform check_achievements(v.user_id);
  return v;
end $$;

-- ---------- cosmetic items ----------
create or replace function purchase_item(p_item uuid) returns void
language plpgsql security definer set search_path = public as $$
declare it items;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  select * into it from items where id = p_item;
  if it.id is null or not it.is_active or it.source <> 'shop' or it.price_coins is null then
    raise exception 'ITEM_UNAVAILABLE' using errcode = 'P0001';
  end if;
  if exists (select 1 from user_items where user_id = auth.uid() and item_id = p_item) then
    raise exception 'ALREADY_OWNED' using errcode = 'P0001';
  end if;
  perform spend_coins(auth.uid(), it.price_coins, 'item', it.id::text);
  insert into user_items (user_id, item_id, source) values (auth.uid(), it.id, 'shop');
  perform check_achievements(auth.uid());
end $$;

create or replace function equip_item(p_item uuid) returns void
language plpgsql security definer set search_path = public as $$
declare it items;
begin
  select * into it from items where id = p_item;
  if not exists (select 1 from user_items where user_id = auth.uid() and item_id = p_item) then
    raise exception 'NOT_OWNED' using errcode = 'P0001';
  end if;
  insert into equipment (user_id, slot, item_id) values (auth.uid(), it.slot, it.id)
  on conflict (user_id, slot) do update set item_id = excluded.item_id;
end $$;

create or replace function unequip_slot(p_slot item_slot) returns void
language sql security definer set search_path = public as $$
  delete from equipment where user_id = auth.uid() and slot = p_slot
$$;

-- ---------- feed ----------
create or replace function toggle_post_like(p_post uuid) returns boolean
language plpgsql security definer set search_path = public as $$
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  if exists (select 1 from post_likes where post_id = p_post and user_id = auth.uid()) then
    delete from post_likes where post_id = p_post and user_id = auth.uid();
    update posts set like_count = greatest(like_count - 1, 0) where id = p_post;
    return false;
  else
    insert into post_likes (post_id, user_id) values (p_post, auth.uid());
    update posts set like_count = like_count + 1 where id = p_post;
    perform check_achievements(auth.uid());
    return true;
  end if;
end $$;

-- ---------- GDPR ----------
create or replace function export_my_data() returns jsonb
language sql security definer set search_path = public as $$
  select jsonb_build_object(
    'profile', (select to_jsonb(p) from profiles p where id = auth.uid()),
    'visits', (select coalesce(jsonb_agg(to_jsonb(v)), '[]') from visits v where user_id = auth.uid()),
    'visit_claims', (select coalesce(jsonb_agg(to_jsonb(c)), '[]') from visit_claims c where user_id = auth.uid()),
    'xp_ledger', (select coalesce(jsonb_agg(to_jsonb(x)), '[]') from xp_ledger x where user_id = auth.uid()),
    'coin_ledger', (select coalesce(jsonb_agg(to_jsonb(c)), '[]') from coin_ledger c where user_id = auth.uid()),
    'vouchers', (select coalesce(jsonb_agg(to_jsonb(v)), '[]') from vouchers v where user_id = auth.uid()),
    'items', (select coalesce(jsonb_agg(to_jsonb(i)), '[]') from user_items i where user_id = auth.uid()),
    'achievements', (select coalesce(jsonb_agg(to_jsonb(a)), '[]') from user_achievements a where user_id = auth.uid()),
    'likes', (select coalesce(jsonb_agg(to_jsonb(l)), '[]') from post_likes l where user_id = auth.uid()),
    'exported_at', now())
$$;

create or replace function delete_my_account() returns void
language plpgsql security definer set search_path = public, auth as $$
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  delete from auth.users where id = auth.uid();
end $$;

-- ---------- leaderboard / public profile view ----------
create or replace view public_profiles as
select
  p.id, p.nickname, p.xp, p.level, p.visit_count, p.current_streak_weeks,
  (p.last_visit_at is not null and p.last_visit_at > now() - make_interval(days => (select onboard_window_days from economy_config where id = 1))) as on_board,
  (select coalesce(jsonb_object_agg(e.slot, i.asset_key), '{}')
     from equipment e join items i on i.id = e.item_id where e.user_id = p.id) as equipped,
  rank() over (order by p.xp desc, p.created_at asc) as rank
from profiles p
where p.leaderboard_visible;

-- ---------- admin dashboard stats ----------
create or replace function admin_stats() returns jsonb
language sql security definer set search_path = public as $$
  select case when is_manager() then jsonb_build_object(
    'users', (select count(*) from profiles),
    'users_on_board', (select count(*) from public_profiles where on_board),
    'visits_30d', (select count(*) from visits where visited_at > now() - interval '30 days'),
    'revenue_30d_cents', (select coalesce(sum(amount_cents), 0) from visits where visited_at > now() - interval '30 days'),
    'pending_claims', (select count(*) from visit_claims where status = 'pending'),
    'coins_outstanding', (select coalesce(sum(coin_balance), 0) from profiles),
    'vouchers_active', (select count(*) from vouchers where status = 'active'),
    'vouchers_redeemed_30d', (select count(*) from vouchers where redeemed_at > now() - interval '30 days')
  ) else null end
$$;
