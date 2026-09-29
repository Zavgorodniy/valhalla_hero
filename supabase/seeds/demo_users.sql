-- Valhalla Hero local demo accounts: admin Odin, staff Heimdall and the shared password
-- Valhalla123! for every *@valhalla.demo account. Local stack only – never run on a
-- shared project. Runs after content.sql and demo_players.sql.
set search_path = public;

create or replace function seed_user(p_id uuid, p_email text, p_nick text, p_birth date) returns void
language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token, email_change, email_change_token_new)
  values ('00000000-0000-0000-0000-000000000000', p_id, 'authenticated', 'authenticated', p_email,
    '', now(), '{"provider":"email","providers":["email"]}', jsonb_build_object('nickname', p_nick, 'birth_date', p_birth::text),
    now(), now(), '', '', '', '');
  insert into auth.identities (id, user_id, provider_id, provider, identity_data, last_sign_in_at, created_at, updated_at)
  values (gen_random_uuid(), p_id, p_id::text, 'email', jsonb_build_object('sub', p_id::text, 'email', p_email), now(), now(), now());
end $$;

select seed_user('a0000000-0000-0000-0000-000000000001', 'admin@valhalla.demo', 'Odin', '1985-03-01');
select seed_user('a0000000-0000-0000-0000-000000000002', 'staff@valhalla.demo', 'Heimdall', '1992-07-14');
drop function seed_user(uuid, text, text, date);

update auth.users set encrypted_password = extensions.crypt('Valhalla123!', extensions.gen_salt('bf'))
where email like '%@valhalla.demo';

update profiles set role = 'admin', leaderboard_visible = false where id = 'a0000000-0000-0000-0000-000000000001';
update profiles set role = 'staff', leaderboard_visible = false where id = 'a0000000-0000-0000-0000-000000000002';
insert into venue_staff values ('a0000000-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111');

-- pending claims for the staff demo
insert into visit_claims (user_id, venue_id, amount_cents, note) values
  ('a0000000-0000-0000-0000-000000000007', '11111111-1111-1111-1111-111111111111', 4250, 'Freitag, Tisch 4'),
  ('a0000000-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 1890, null);

-- events and news are written by Odin
update posts set author_id = 'a0000000-0000-0000-0000-000000000001' where author_id is null;
