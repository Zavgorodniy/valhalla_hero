-- Valhalla Hero test players for the Hall of Fame: eight guests with visit history,
-- levels and gear. Random unknown passwords – nobody can sign in as them, so this is
-- safe for a shared test project (run once):
--   supabase db query --linked -f supabase/seeds/demo_players.sql
-- Locally, demo_users.sql (runs after this) gives them the shared demo password.
set search_path = public;

create or replace function seed_player(p_id uuid, p_email text, p_nick text, p_birth date) returns void
language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token, email_change, email_change_token_new)
  values ('00000000-0000-0000-0000-000000000000', p_id, 'authenticated', 'authenticated', p_email,
    extensions.crypt(encode(extensions.gen_random_bytes(24), 'base64'), extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}', jsonb_build_object('nickname', p_nick, 'birth_date', p_birth::text),
    now(), now(), '', '', '', '');
  insert into auth.identities (id, user_id, provider_id, provider, identity_data, last_sign_in_at, created_at, updated_at)
  values (gen_random_uuid(), p_id, p_id::text, 'email', jsonb_build_object('sub', p_id::text, 'email', p_email), now(), now(), now());
end $$;

select seed_player('a0000000-0000-0000-0000-000000000003', 'guest@valhalla.demo', 'Ragnar', '1996-11-22');
select seed_player('a0000000-0000-0000-0000-000000000004', 'lagertha@valhalla.demo', 'Lagertha', '1994-05-05');
select seed_player('a0000000-0000-0000-0000-000000000005', 'bjorn@valhalla.demo', 'Bjorn', '1990-01-30');
select seed_player('a0000000-0000-0000-0000-000000000006', 'floki@valhalla.demo', 'Floki', '1988-09-09');
select seed_player('a0000000-0000-0000-0000-000000000007', 'ivar@valhalla.demo', 'Ivar', '1999-12-12');
select seed_player('a0000000-0000-0000-0000-000000000008', 'astrid@valhalla.demo', 'Astrid', '1997-04-18');
select seed_player('a0000000-0000-0000-0000-000000000009', 'ubbe@valhalla.demo', 'Ubbe', '1993-08-08');
select seed_player('a0000000-0000-0000-0000-000000000010', 'torvi@valhalla.demo', 'Torvi', '1995-02-02');
update profiles set hero_form = 'heroine' where nickname in ('Lagertha', 'Astrid', 'Torvi');
drop function seed_player(uuid, text, text, date);

-- visit history: spread across past weeks so streaks/levels differ
create or replace function seed_visits(p_user uuid, p_weeks int, p_per_week int, p_amount int) returns void
language plpgsql as $$
declare w int; i int;
begin
  for w in reverse (p_weeks - 1)..0 loop
    for i in 1..p_per_week loop
      perform record_visit(p_user, '11111111-1111-1111-1111-111111111111', p_amount + (i * 350), 'manual', null, null,
        now() - make_interval(weeks => w, days => (i * 2) % 6, hours => 20));
    end loop;
  end loop;
end $$;

select seed_visits('a0000000-0000-0000-0000-000000000005', 40, 2, 2800);  -- Bjorn: top
select seed_visits('a0000000-0000-0000-0000-000000000004', 30, 2, 2200);  -- Lagertha
select seed_visits('a0000000-0000-0000-0000-000000000006', 20, 1, 3500);  -- Floki
select seed_visits('a0000000-0000-0000-0000-000000000009', 12, 1, 1800);  -- Ubbe
select seed_visits('a0000000-0000-0000-0000-000000000010', 8, 1, 2500);   -- Torvi
select seed_visits('a0000000-0000-0000-0000-000000000003', 6, 1, 2400);   -- Ragnar (demo guest)
select seed_visits('a0000000-0000-0000-0000-000000000007', 3, 1, 1500);   -- Ivar
-- Astrid: was active, then left the ship
select record_visit('a0000000-0000-0000-0000-000000000008', '11111111-1111-1111-1111-111111111111', 3200, 'manual', null, null, now() - interval '70 days');
select record_visit('a0000000-0000-0000-0000-000000000008', '11111111-1111-1111-1111-111111111111', 2100, 'manual', null, null, now() - interval '63 days');
drop function seed_visits(uuid, int, int, int);

-- equipment for the leaderboard
insert into equipment (user_id, slot, item_id)
select 'a0000000-0000-0000-0000-000000000005', slot, id from items where asset_key in ('headgear_crown', 'cape_fur', 'companion_wolf', 'frame_iron', 'hand_horn')
on conflict do nothing;
insert into equipment (user_id, slot, item_id)
select 'a0000000-0000-0000-0000-000000000004', slot, id from items where asset_key in ('headgear_leather_cap', 'hand_horn', 'frame_iron')
on conflict do nothing;

-- app likes from the test players (instagram events keep exactly their instagram likes)
insert into post_likes (post_id, user_id)
select p.id, u.id from posts p cross join (select id from profiles where id::text like 'a0000000-%') u
where p.published_at is not null and random() < 0.6
  and coalesce(p.image_url, '') not like 'events/%'
on conflict do nothing;
update posts set like_count = like_count + (select count(*) from post_likes l where l.post_id = posts.id and l.user_id::text like 'a0000000-%');
