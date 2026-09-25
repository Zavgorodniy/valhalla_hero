-- Hero form (Held / Heldin): cosmetic choice of the base hero art and level names.
-- Progress, items and economy are shared; only the base illustration and the
-- displayed level name differ.

create type hero_form as enum ('hero', 'heroine');

alter table profiles add column hero_form hero_form not null default 'hero';
alter table levels add column name_female text;

-- existing databases (fresh resets get these values from seed.sql)
update levels set name_female = v.name
from (values (1, 'Thrallin'), (2, 'Karlin'), (3, 'Drengrin'), (4, 'Huskarlin'),
             (5, 'Berserkerin'), (6, 'Jarlin'), (7, 'Konungrin'), (8, 'Valkyrja')) as v(level, name)
where levels.level = v.level;

-- sign-up metadata may carry the chosen form
create or replace function handle_new_user() returns trigger
language plpgsql security definer set search_path = public as $$
declare
  v_nick text := coalesce(new.raw_user_meta_data->>'nickname', 'viking_' || left(replace(new.id::text, '-', ''), 6));
  v_birth date := coalesce((new.raw_user_meta_data->>'birth_date')::date, null);
  v_form hero_form := coalesce(nullif(new.raw_user_meta_data->>'hero_form', '')::hero_form, 'hero');
begin
  if v_birth is null then
    -- social sign-ups complete onboarding later; block until DOB is set via complete_onboarding()
    return new;
  end if;
  insert into profiles (id, nickname, birth_date, locale, hero_form)
  values (new.id, v_nick, v_birth, coalesce(new.raw_user_meta_data->>'locale', 'de'), v_form)
  on conflict (id) do nothing;
  return new;
end $$;

drop function if exists complete_onboarding(text, date, text);
create or replace function complete_onboarding(p_nickname text, p_birth_date date, p_locale text default 'de', p_hero_form hero_form default 'hero')
returns profiles language plpgsql security definer set search_path = public as $$
declare v profiles;
begin
  if auth.uid() is null then raise exception 'not authenticated'; end if;
  if p_birth_date > current_date - interval '18 years' then
    raise exception 'AGE_RESTRICTED' using errcode = 'P0001';
  end if;
  insert into profiles (id, nickname, birth_date, locale, hero_form)
  values (auth.uid(), p_nickname, p_birth_date, p_locale, p_hero_form)
  on conflict (id) do update set nickname = excluded.nickname, hero_form = excluded.hero_form
  returning * into v;
  return v;
end $$;

-- leaderboard shows the chosen form (new column appended at the end)
create or replace view public_profiles as
select
  p.id, p.nickname, p.xp, p.level, p.visit_count, p.current_streak_weeks,
  (p.last_visit_at is not null and p.last_visit_at > now() - make_interval(days => (select onboard_window_days from economy_config where id = 1))) as on_board,
  (select coalesce(jsonb_object_agg(e.slot, i.asset_key), '{}')
     from equipment e join items i on i.id = e.item_id where e.user_id = p.id) as equipped,
  rank() over (order by p.xp desc, p.created_at asc) as rank,
  p.hero_form
from profiles p
where p.leaderboard_visible;

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
    'user', jsonb_build_object('nickname', p.nickname, 'level', p.level, 'hero_form', p.hero_form));
end $$;

-- copy aligned with the redesign: no alcohol-flavoured taglines or names
update levels set tagline_de = 'Frei und ungebunden.', tagline_en = 'Free and unbound.' where level = 2;
update levels set tagline_de = 'Furchtlos. Unaufhaltsam.', tagline_en = 'Fearless. Unstoppable.' where level = 5;
update levels set tagline_de = 'Herr über Halle und Hof.', tagline_en = 'Lord of hall and court.' where level = 6;
update achievements set name_de = 'Erste Einkehr', name_en = 'First Stop' where key = 'first_visit';
update rewards set name_de = 'Getränk aufs Haus', name_en = 'Drink on the House',
  description_de = 'Ein Getränk deiner Wahl von der Karte.', description_en = 'One drink of your choice from the menu.'
  where name_de = 'Ein Bier aufs Haus';

-- level-up notification: form-aware level name, no drinking toast
create or replace function add_xp(p_user uuid, p_amount int, p_reason xp_reason, p_ref text default null)
returns void language plpgsql security definer set search_path = public as $$
declare
  v_old_level int; v_new_level int; v_xp int; v_name text; v_form hero_form; r record;
begin
  if p_amount = 0 then return; end if;
  insert into xp_ledger (user_id, amount, reason, ref_id) values (p_user, p_amount, p_reason, p_ref);
  update profiles set xp = xp + p_amount where id = p_user returning xp, level, hero_form into v_xp, v_old_level, v_form;
  v_new_level := level_for_xp(v_xp);
  if v_new_level > v_old_level then
    update profiles set level = v_new_level where id = p_user;
    select case when v_form = 'heroine' then coalesce(name_female, name) else name end into v_name from levels where level = v_new_level;
    for r in select id from items where source = 'level' and is_active and unlock_level > v_old_level and unlock_level <= v_new_level loop
      insert into user_items (user_id, item_id, source) values (p_user, r.id, 'level') on conflict do nothing;
    end loop;
    perform notify(p_user, 'level_up',
      'Neue Stufe: ' || v_name, 'New level: ' || v_name,
      'Du bist jetzt ' || v_name || '. Die Halle ehrt dich!', 'You are now ' || v_name || '. The hall honours you!',
      jsonb_build_object('level', v_new_level));
  end if;
end $$;
