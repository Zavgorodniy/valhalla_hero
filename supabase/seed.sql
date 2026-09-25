-- Valhalla Hero demo seed (local / demo project only)
set search_path = public;

insert into venues (id, slug, name, address, city, is_active) values
  ('11111111-1111-1111-1111-111111111111', 'valhalla-berlin', 'Valhalla Bar', 'Warschauer Str. 42', 'Berlin', true),
  ('22222222-2222-2222-2222-222222222222', 'valhalla-hamburg', 'Valhalla Hamburg', 'Reeperbahn 1', 'Hamburg', false);

insert into levels (level, name, name_female, xp_threshold, coin_multiplier, hero_asset, tagline_de, tagline_en) values
  (1, 'Thrall', 'Thrallin',     0,     1.00, 'hero_01_thrall',    'Jeder Weg beginnt am Ufer.',        'Every journey starts on the shore.'),
  (2, 'Karl', 'Karlin',       100,   1.00, 'hero_02_karl',      'Frei und ungebunden.',              'Free and unbound.'),
  (3, 'Drengr', 'Drengrin',     300,   1.05, 'hero_03_drengr',    'Ein junger Krieger der Tafel.',     'A young warrior of the table.'),
  (4, 'Huskarl', 'Huskarlin',    700,   1.10, 'hero_04_huskarl',   'Treu bis zum letzten Horn.',        'Loyal to the last horn.'),
  (5, 'Berserker', 'Berserkerin',  1500,  1.15, 'hero_05_berserker', 'Furchtlos. Unaufhaltsam.',          'Fearless. Unstoppable.'),
  (6, 'Jarl', 'Jarlin',       3000,  1.20, 'hero_06_jarl',      'Herr über Halle und Hof.',          'Lord of hall and court.'),
  (7, 'Konungr', 'Konungrin',    6000,  1.30, 'hero_07_konungr',   'Gekrönt von der Gemeinschaft.',     'Crowned by the community.'),
  (8, 'Einherjar', 'Valkyrja',  12000, 1.50, 'hero_08_einherjar', 'Auserwählt für Walhalla.',          'Chosen for Valhalla.');

insert into achievements (key, name_de, name_en, description_de, description_en, icon, xp_reward, coin_reward, sort) values
  ('first_visit', 'Erste Einkehr', 'First Stop', 'Dein erster Besuch wurde gutgeschrieben.', 'Your first visit was credited.', 'horn', 20, 50, 1),
  ('visits_5', 'Stammgast', 'Regular', '5 Besuche.', '5 visits.', 'shield', 50, 100, 2),
  ('visits_25', 'Hallenbewohner', 'Hall Dweller', '25 Besuche.', '25 visits.', 'axe', 150, 250, 3),
  ('visits_50', 'Tafelrunde', 'Round Table', '50 Besuche.', '50 visits.', 'sword', 300, 500, 4),
  ('visits_100', 'Legende der Halle', 'Legend of the Hall', '100 Besuche.', '100 visits.', 'crown', 600, 1000, 5),
  ('streak_4w', 'An Bord', 'On Board', '4 Wochen in Folge an Bord.', '4 weeks in a row on board.', 'ship', 100, 150, 6),
  ('streak_12w', 'Steuermann', 'Helmsman', '12 Wochen in Folge an Bord.', '12 weeks in a row on board.', 'ship', 300, 500, 7),
  ('events_3', 'Saga-Gast', 'Saga Guest', '3 Events besucht.', 'Attended 3 events.', 'drum', 80, 100, 8),
  ('events_10', 'Skalden-Freund', 'Friend of Skalds', '10 Events besucht.', 'Attended 10 events.', 'drum', 250, 400, 9),
  ('liked_10', 'Runenleser', 'Rune Reader', '10 Beiträge geliked.', 'Liked 10 posts.', 'rune', 30, 30, 10),
  ('first_reward', 'Erste Beute', 'First Loot', 'Erste Belohnung eingelöst.', 'Redeemed your first reward.', 'chest', 30, 0, 11),
  ('rewards_5', 'Plünderer', 'Raider', '5 Belohnungen eingelöst.', 'Redeemed 5 rewards.', 'chest', 100, 100, 12),
  ('first_item', 'Gut gerüstet', 'Well Equipped', 'Erstes Ausrüstungsteil gekauft.', 'Bought your first gear.', 'helm', 30, 0, 13),
  ('level_4', 'Huskarl', 'Huskarl', 'Stufe 4 erreicht.', 'Reached level 4.', 'star', 0, 200, 14),
  ('level_8', 'Einherjar', 'Einherjar', 'Stufe 8 erreicht. Walhalla!', 'Reached level 8. Valhalla!', 'star', 0, 1000, 15),
  ('venues_all', 'Weltenbummler', 'Wayfarer', 'Alle Bars der Kette besucht.', 'Visited every bar of the chain.', 'map', 200, 300, 16);

insert into items (slot, name_de, name_en, rarity, asset_key, source, price_coins, unlock_level, unlock_achievement_key, sort) values
  ('headgear', 'Lederkappe', 'Leather Cap', 'common', 'headgear_leather_cap', 'level', null, 2, null, 1),
  ('headgear', 'Eisenhelm', 'Iron Helm', 'common', 'headgear_iron_helm', 'shop', 400, null, null, 2),
  ('headgear', 'Hörnerhelm', 'Horned Helm', 'rare', 'headgear_horned_helm', 'shop', 900, null, null, 3),
  ('headgear', 'Rabenkapuze', 'Raven Hood', 'rare', 'headgear_raven_hood', 'achievement', null, null, 'streak_4w', 4),
  ('headgear', 'Krone des Konungr', 'Crown of the Konungr', 'legendary', 'headgear_crown', 'level', null, 7, null, 5),
  ('hand_item', 'Trinkhorn', 'Drinking Horn', 'common', 'hand_horn', 'level', null, 1, null, 10),
  ('hand_item', 'Rundschild', 'Round Shield', 'common', 'hand_shield', 'shop', 350, null, null, 11),
  ('hand_item', 'Bartaxt', 'Bearded Axe', 'rare', 'hand_axe', 'shop', 800, null, null, 12),
  ('hand_item', 'Speer Gungnir', 'Spear Gungnir', 'legendary', 'hand_spear', 'achievement', null, null, 'visits_50', 13),
  ('hand_item', 'Runenschwert', 'Rune Sword', 'legendary', 'hand_sword', 'level', null, 8, null, 14),
  ('cape', 'Wollumhang', 'Wool Cape', 'common', 'cape_wool', 'shop', 300, null, null, 20),
  ('cape', 'Fellumhang', 'Fur Cape', 'rare', 'cape_fur', 'level', null, 5, null, 21),
  ('cape', 'Königsmantel', 'Royal Mantle', 'legendary', 'cape_royal', 'shop', 2500, null, null, 22),
  ('companion', 'Rabe Hugin', 'Raven Hugin', 'rare', 'companion_raven', 'shop', 700, null, null, 30),
  ('companion', 'Wolf Fenrir', 'Wolf Fenrir', 'legendary', 'companion_wolf', 'level', null, 6, null, 31),
  ('companion', 'Bär Bjorn', 'Bear Bjorn', 'legendary', 'companion_bear', 'achievement', null, null, 'visits_100', 32),
  ('frame', 'Holzrahmen', 'Wooden Frame', 'common', 'frame_wood', 'shop', 200, null, null, 40),
  ('frame', 'Eisenrahmen', 'Iron Frame', 'rare', 'frame_iron', 'level', null, 3, null, 41),
  ('frame', 'Runenrahmen', 'Rune Frame', 'rare', 'frame_runic', 'achievement', null, null, 'visits_25', 42),
  ('frame', 'Goldrahmen', 'Golden Frame', 'legendary', 'frame_gold', 'level', null, 8, null, 43),
  ('frame', 'Saga-Rahmen 2026', 'Saga Frame 2026', 'legendary', 'frame_saga', 'event', null, null, null, 44);

insert into rewards (type, name_de, name_en, description_de, description_en, price_coins, stock, validity_days, sort) values
  ('drink', 'Getränk aufs Haus', 'Drink on the House', 'Ein Getränk deiner Wahl von der Karte.', 'One drink of your choice from the menu.', 300, null, 30, 1),
  ('drink', 'Signature Cocktail', 'Signature Cocktail', 'Ein Cocktail von der Karte.', 'One cocktail from the menu.', 600, null, 30, 2),
  ('merch', 'Valhalla Sticker-Set', 'Valhalla Sticker Set', '5 Vinyl-Sticker.', '5 vinyl stickers.', 400, 100, 60, 3),
  ('merch', 'Emaille-Pin „Rabe“', 'Enamel Pin "Raven"', 'Limitierter Pin.', 'Limited pin.', 900, 50, 60, 4),
  ('merch', 'Valhalla T-Shirt', 'Valhalla T-Shirt', 'Schwarz, Bio-Baumwolle, S–XXL.', 'Black, organic cotton, S–XXL.', 2500, 30, 90, 5),
  ('merch', 'Valhalla Hoodie', 'Valhalla Hoodie', 'Schwerer Hoodie mit Runenprint.', 'Heavy hoodie with rune print.', 5000, 15, 90, 6),
  ('merch', 'Trinkhorn mit Gravur', 'Engraved Drinking Horn', 'Echtes Horn, mit deinem Nickname.', 'Real horn, engraved with your nickname.', 8000, 10, 90, 7),
  ('discount', '10 % auf die Rechnung', '10% off the Bill', 'Einmalig, max. 100 €.', 'One time, max. 100 €.', 800, null, 30, 8),
  ('priority_booking', 'Vorrang-Reservierung', 'Priority Booking', 'Tisch am Freitag/Samstag, Vorzeigen beim Anruf.', 'Table on Fri/Sat, show when calling.', 1200, null, 60, 9),
  ('event_access', 'Zugang: Skalden-Nacht', 'Access: Skalds'' Night', 'Eintritt zur nächsten Skalden-Nacht.', 'Entry to the next Skalds'' Night.', 500, 40, 45, 10);

-- ---------- demo users (password: Valhalla123!) ----------
create or replace function seed_user(p_id uuid, p_email text, p_nick text, p_birth date) returns void
language plpgsql as $$
begin
  insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
    raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token, email_change, email_change_token_new)
  values ('00000000-0000-0000-0000-000000000000', p_id, 'authenticated', 'authenticated', p_email,
    extensions.crypt('Valhalla123!', extensions.gen_salt('bf')), now(),
    '{"provider":"email","providers":["email"]}', jsonb_build_object('nickname', p_nick, 'birth_date', p_birth::text),
    now(), now(), '', '', '', '');
  insert into auth.identities (id, user_id, provider_id, provider, identity_data, last_sign_in_at, created_at, updated_at)
  values (gen_random_uuid(), p_id, p_id::text, 'email', jsonb_build_object('sub', p_id::text, 'email', p_email), now(), now(), now());
end $$;

select seed_user('a0000000-0000-0000-0000-000000000001', 'admin@valhalla.demo', 'Odin', '1985-03-01');
select seed_user('a0000000-0000-0000-0000-000000000002', 'staff@valhalla.demo', 'Heimdall', '1992-07-14');
select seed_user('a0000000-0000-0000-0000-000000000003', 'guest@valhalla.demo', 'Ragnar', '1996-11-22');
select seed_user('a0000000-0000-0000-0000-000000000004', 'lagertha@valhalla.demo', 'Lagertha', '1994-05-05');
select seed_user('a0000000-0000-0000-0000-000000000005', 'bjorn@valhalla.demo', 'Bjorn', '1990-01-30');
select seed_user('a0000000-0000-0000-0000-000000000006', 'floki@valhalla.demo', 'Floki', '1988-09-09');
select seed_user('a0000000-0000-0000-0000-000000000007', 'ivar@valhalla.demo', 'Ivar', '1999-12-12');
select seed_user('a0000000-0000-0000-0000-000000000008', 'astrid@valhalla.demo', 'Astrid', '1997-04-18');
select seed_user('a0000000-0000-0000-0000-000000000009', 'ubbe@valhalla.demo', 'Ubbe', '1993-08-08');
select seed_user('a0000000-0000-0000-0000-000000000010', 'torvi@valhalla.demo', 'Torvi', '1995-02-02');

update profiles set role = 'admin', leaderboard_visible = false where id = 'a0000000-0000-0000-0000-000000000001';
update profiles set role = 'staff', leaderboard_visible = false where id = 'a0000000-0000-0000-0000-000000000002';
update profiles set hero_form = 'heroine' where nickname in ('Lagertha', 'Astrid', 'Torvi');
insert into venue_staff values ('a0000000-0000-0000-0000-000000000002', '11111111-1111-1111-1111-111111111111');

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
drop function seed_user(uuid, text, text, date);

-- pending claims for the staff demo
insert into visit_claims (user_id, venue_id, amount_cents, note) values
  ('a0000000-0000-0000-0000-000000000007', '11111111-1111-1111-1111-111111111111', 4250, 'Freitag, Tisch 4'),
  ('a0000000-0000-0000-0000-000000000003', '11111111-1111-1111-1111-111111111111', 1890, null);

-- equipment for the leaderboard
insert into equipment (user_id, slot, item_id)
select 'a0000000-0000-0000-0000-000000000005', slot, id from items where asset_key in ('headgear_crown', 'cape_fur', 'companion_wolf', 'frame_iron', 'hand_horn')
on conflict do nothing;
insert into equipment (user_id, slot, item_id)
select 'a0000000-0000-0000-0000-000000000004', slot, id from items where asset_key in ('headgear_leather_cap', 'hand_horn', 'frame_iron')
on conflict do nothing;

-- feed: events (with categories) and news
insert into posts (type, category, title, body, venue_id, starts_at, ends_at, published_at, author_id, like_count) values
  ('event', 'match', 'Bundesliga live: Union – Dortmund', 'Anpfiff um 18:30 auf der großen Leinwand. Wer ein Foto vom Spiel teilt, bekommt Punkte.', '11111111-1111-1111-1111-111111111111', ((current_date + 0) + time '18:30') at time zone 'Europe/Berlin', ((current_date + 0) + time '20:30') at time zone 'Europe/Berlin', now() - interval '3 days', 'a0000000-0000-0000-0000-000000000001', 0),
  ('event', 'live', 'Skalden-Nacht: Live-Musik', 'Ab 21 Uhr spielen die „Nordwind“ akustisch. Eintritt frei für alle an Bord.', '11111111-1111-1111-1111-111111111111', ((current_date + 2) + time '21:00') at time zone 'Europe/Berlin', ((current_date + 2) + time '23:30') at time zone 'Europe/Berlin', now() - interval '2 days', 'a0000000-0000-0000-0000-000000000001', 0),
  ('event', 'match', 'Champions League auf der Leinwand', 'Alle Spiele des Abends, Ton an, beste Plätze für Stammgäste.', '11111111-1111-1111-1111-111111111111', ((current_date + 4) + time '21:00') at time zone 'Europe/Berlin', ((current_date + 4) + time '23:00') at time zone 'Europe/Berlin', now() - interval '1 day', 'a0000000-0000-0000-0000-000000000001', 0),
  ('event', 'quiz', 'Runen-Quiz', 'Sechs Runden rund um Nordmänner, Musik und Berlin. Teams bis sechs Personen.', '11111111-1111-1111-1111-111111111111', ((current_date + 6) + time '20:00') at time zone 'Europe/Berlin', ((current_date + 6) + time '22:30') at time zone 'Europe/Berlin', now() - interval '1 day', 'a0000000-0000-0000-0000-000000000001', 0),
  ('event', 'special', 'Hnefatafl-Turnier', 'Das Brettspiel der Wikinger – Regeln erklären wir vor Ort. Die Siegerin bekommt einen legendären Rahmen.', '11111111-1111-1111-1111-111111111111', ((current_date + 9) + time '19:00') at time zone 'Europe/Berlin', ((current_date + 9) + time '22:00') at time zone 'Europe/Berlin', now(), 'a0000000-0000-0000-0000-000000000001', 0),
  ('news', null, 'Neuer Hoodie im Shop', 'Der schwere Runen-Hoodie ist da. 5000 Münzen, nur 15 Stück.', null, null, null, now() - interval '4 days', 'a0000000-0000-0000-0000-000000000001', 0),
  ('news', null, 'Doppelte Münzen am Donnerstag', 'Jeden Donnerstag im September gibt es doppelte Münzen auf alle Besuche.', '11111111-1111-1111-1111-111111111111', null, null, now() - interval '9 days', 'a0000000-0000-0000-0000-000000000001', 0),
  ('news', null, 'Wir eröffnen in Hamburg', 'Im Winter öffnet Valhalla Hamburg. Wer beide Hallen besucht, wird Weltenbummler.', null, null, null, null, 'a0000000-0000-0000-0000-000000000001', 0);

insert into post_likes (post_id, user_id)
select p.id, u.id from posts p cross join (select id from profiles where role = 'user') u
where p.published_at is not null and random() < 0.6;
update posts set like_count = (select count(*) from post_likes where post_id = posts.id);

-- receipts: demo POS register (serial printed in the TSE QR) and one-time codes
insert into venue_registers (serial, venue_id, label) values ('VH-BERLIN-KASSE-1', '11111111-1111-1111-1111-111111111111', 'Demo-Kasse Theke');
insert into receipt_codes (code, venue_id, amount_cents) values
  ('VH-7Q4K-2M', '11111111-1111-1111-1111-111111111111', 3800), ('VH-3X9P-5T', '11111111-1111-1111-1111-111111111111', 2450), ('VH-8N2D-6R', '11111111-1111-1111-1111-111111111111', 5120), ('VH-4H7W-9C', '11111111-1111-1111-1111-111111111111', 1890),
  ('VH-6J3B-8L', '11111111-1111-1111-1111-111111111111', 4200), ('VH-2F5V-7Q', '11111111-1111-1111-1111-111111111111', 3150), ('VH-9K8T-3D', '11111111-1111-1111-1111-111111111111', 6600), ('VH-5M2R-4X', '11111111-1111-1111-1111-111111111111', 2780),
  ('VH-1W6C-2P', '11111111-1111-1111-1111-111111111111', 4450), ('VH-7T3N-5J', '11111111-1111-1111-1111-111111111111', 3320);
-- demo: accept old test receipts (production default is 48 hours)
update economy_config set receipt_max_age_hours = 0 where id = 1;
