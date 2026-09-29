-- Valhalla Hero bar content: venue, levels, achievements, gear, rewards, events, demo receipts.
-- Safe for any project (no users). Local: applied by `supabase db reset`; cloud: see README.
set search_path = public;

insert into venues (id, slug, name, address, city, is_active) values
  ('11111111-1111-1111-1111-111111111111', 'valhalla-helmstedt', 'Valhalla Helmstedt', 'Papenberg 2', 'Helmstedt', true),
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

-- feed: events (with categories) and news
insert into posts (type, category, title, body, venue_id, starts_at, ends_at, published_at, author_id, like_count) values
  ('event', 'match', 'Bundesliga live: Union – Dortmund', 'Anpfiff um 18:30 auf der großen Leinwand. Wer ein Foto vom Spiel teilt, bekommt Punkte.', '11111111-1111-1111-1111-111111111111', ((current_date + 0) + time '18:30') at time zone 'Europe/Berlin', ((current_date + 0) + time '20:30') at time zone 'Europe/Berlin', now() - interval '3 days', null, 0),
  ('news', null, 'Neuer Hoodie im Shop', 'Der schwere Runen-Hoodie ist da. 5000 Münzen, nur 15 Stück.', null, null, null, now() - interval '4 days', null, 0),
  ('news', null, 'Doppelte Münzen am Donnerstag', 'Jeden Donnerstag im September gibt es doppelte Münzen auf alle Besuche.', '11111111-1111-1111-1111-111111111111', null, null, now() - interval '9 days', null, 0),
  ('news', null, 'Wir eröffnen in Hamburg', 'Im Winter öffnet Valhalla Hamburg. Wer beide Hallen besucht, wird Weltenbummler.', null, null, null, null, null, 0);

-- events from instagram.com/valhallahelmstedt (newest first; past ones stay as history); images: supabase/seed_media/events,
-- uploaded to the `media` bucket by ./supabase/seed_media.sh; like_count = the Instagram likes
insert into posts (type, category, title, body, venue_id, image_url, starts_at, ends_at, published_at, author_id, like_count) values
  ('event', 'live', 'Bodo Lüddemann – zurück im Valhalla', 'Er ist zurück! Bodo spielt bei uns am 01.10.26 ab 19:30 Uhr. Kommt vorbei! Er ist ein Must-See, auch ohne Sitzplatz. Wir freuen uns, euch diesen genialen Act erneut präsentieren zu dürfen. 🎸🎶', '11111111-1111-1111-1111-111111111111', 'events/DdwNqVZNsD5.jpg', timestamptz '2026-10-01 19:30 Europe/Berlin', timestamptz '2026-10-01 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-09-26 12:00 Europe/Berlin', null, 11),
  ('event', 'match', 'Silberfüchse vs. MTV Hondelage II', 'Viel Erfolg Jungs! Wir drücken euch die Daumen 🫵', '11111111-1111-1111-1111-111111111111', 'events/DdUQkRtNU-T.jpg', timestamptz '2026-09-20 13:00 Europe/Berlin', timestamptz '2026-09-20 13:00 Europe/Berlin' + interval '3 hours', timestamptz '2026-09-15 12:00 Europe/Berlin', null, 11),
  ('event', 'live', 'Mark Beerell – Abschiedskonzert', 'Am 27.08 gibt Mark Beerell sein Abschiedskonzert bei uns im Valhalla. Keine Sorgen, wir arbeiten bereits an regelmäßigen Revivals im Valhalla. Ab 19:30 Uhr geht''s los. Reserviert euch schnell die letzten Plätze. 🎼🎵🎶', '11111111-1111-1111-1111-111111111111', 'events/DceUV6YNJC-.jpg', timestamptz '2026-08-27 19:30 Europe/Berlin', timestamptz '2026-08-27 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-08-25 12:00 Europe/Berlin', null, 11),
  ('event', 'live', 'Country Man Nico', 'Leider kam es bei unserer Zeitungsannounce zu einem kleinen Fehler. Morgen, den 20.08 ist unser Country Man Nico in the house. Nächsten Donnerstag, den 27.08 ist dann Mark Beerell zu Gast. Beide Konzerte sind fast ausgebucht. Ruft kurz durch für die letzten Plätze. Wir freuen uns auf euch! 🎶🎵🎼🥁🎙', '11111111-1111-1111-1111-111111111111', 'events/DcOugPZtkjF.jpg', timestamptz '2026-08-20 19:30 Europe/Berlin', timestamptz '2026-08-20 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-08-19 12:00 Europe/Berlin', null, 7),
  ('event', 'live', 'Walter P – Live im Valhalla', 'Nach dem letzten großen Erfolg in Valhalla freuen wir uns das Trio am 23.07.26 ab 19:30 Uhr wieder in Valhalla begrüßen zu dürfen. Walther P bietet eine musikalische Reise durch die letzten 70 Jahre. Von Rock’n’Roll über Blues bis Folk und Pop. Wir freuen uns auf ein weiteres musikalisches Highlight!', '11111111-1111-1111-1111-111111111111', 'events/DbFl_CltkoX.jpg', timestamptz '2026-07-23 19:30 Europe/Berlin', timestamptz '2026-07-23 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-07-22 12:00 Europe/Berlin', null, 6),
  ('event', 'match', 'WM-Finale: Spanien – Argentinien', 'Am Sonntag, den 19.07.26 übertragen wir das Knallerfinale der WM Spanien vs. Argentinien. Wir sind für euch ab 17:00 Uhr geöffnet! Wir freuen uns auf einen gemeinsamen Fußball Abend!', '11111111-1111-1111-1111-111111111111', 'events/Da40tEMtN-3.jpg', timestamptz '2026-07-19 17:00 Europe/Berlin', timestamptz '2026-07-19 17:00 Europe/Berlin' + interval '3 hours', timestamptz '2026-07-17 12:00 Europe/Berlin', null, 26),
  ('event', 'live', 'Bodo Lüddemann: Rock & Blues', 'Morgen, den 02.07.2026 präsentieren wir euch einen weiteren Top Act in Valhalla! Bodo Lüddemann spielt eine Mischung aus Rockclassics, Bluesrock & Blues. Sichert euch für morgen noch einen Platz und schickt uns eure Reservierung. Start wie gewohnt 19:30 Uhr 🎼🎵🎶🎙', '11111111-1111-1111-1111-111111111111', 'events/DaPnN9iNkWx.jpg', timestamptz '2026-07-02 19:30 Europe/Berlin', timestamptz '2026-07-02 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-07-01 12:00 Europe/Berlin', null, 12),
  ('event', 'match', 'WM: Deutschland – Paraguay', 'Heute, ab 18:00 Uhr sind wir bereit für Paraguay! Es ist spät, wir müssen alle arbeiten, aber diese Spiele finden nur alle 4 Jahre statt. Ich hoffe einige Fans schauen dennoch vorbei. Wir freuen uns auf euch! ⚽️🏆', '11111111-1111-1111-1111-111111111111', 'events/DaJjVW8qL8f.jpg', timestamptz '2026-06-28 18:00 Europe/Berlin', timestamptz '2026-06-28 18:00 Europe/Berlin' + interval '3 hours', timestamptz '2026-06-28 10:00 Europe/Berlin', null, 13),
  ('event', 'match', 'WM: Deutschland – Ecuador', 'Heute, im Anschluss an das Livekonzert der Ego Monsters übertragen wir selbstverständlich das Spiel Deutschland gegen Ecuador! Bis später! ⚽️🏆', '11111111-1111-1111-1111-111111111111', 'events/DaAiPgTtIOw.jpg', timestamptz '2026-06-25 22:00 Europe/Berlin', timestamptz '2026-06-25 22:00 Europe/Berlin' + interval '3 hours', timestamptz '2026-06-25 10:00 Europe/Berlin', null, 13),
  ('event', 'live', 'Ego Monsters live', 'Morgen, den 25.06.2026 ab 19:30 Uhr spielen die Ego Monsters bei uns im Valhalla. Anschließend übertragen wir das Deutschlandspiel. Wir freuen uns auf einen ereignisreichen Abend. Reservierungen empfohlen! 🎼🎵🎶🎸', '11111111-1111-1111-1111-111111111111', 'events/DZ9s1z6NSTe.jpg', timestamptz '2026-06-25 19:30 Europe/Berlin', timestamptz '2026-06-25 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-06-24 12:00 Europe/Berlin', null, 27),
  ('event', 'live', 'Mike – #playmysong', 'Morgen, den 18.06.2026 rockt Mike erneut das Valhalla. Sichert euch noch schnell Plätze! Wir freuen uns auf einen schönen, musikalischen Abend mit euch 🎼🎵🎶🎙', '11111111-1111-1111-1111-111111111111', 'events/DZrgutmtxNu.jpg', timestamptz '2026-06-18 19:30 Europe/Berlin', timestamptz '2026-06-18 19:30 Europe/Berlin' + interval '3 hours', timestamptz '2026-06-17 12:00 Europe/Berlin', null, 10),
  ('event', 'match', 'WM: Deutschland – Curaçao', 'Morgen ab 18:00 Uhr sind wir für euch geöffnet und übertragen das Spiel Deutschland vs. Curacao. Wir freuen uns auf euch 🇩🇪', '11111111-1111-1111-1111-111111111111', 'events/DZiPJVHNqLx.jpg', timestamptz '2026-06-14 18:00 Europe/Berlin', timestamptz '2026-06-14 18:00 Europe/Berlin' + interval '3 hours', timestamptz '2026-06-13 12:00 Europe/Berlin', null, 15);

-- receipts: demo POS register (serial printed in the TSE QR) and one-time codes
insert into venue_registers (serial, venue_id, label) values ('VH-BERLIN-KASSE-1', '11111111-1111-1111-1111-111111111111', 'Demo-Kasse Theke');
insert into receipt_codes (code, venue_id, amount_cents) values
  ('VH-7Q4K-2M', '11111111-1111-1111-1111-111111111111', 3800), ('VH-3X9P-5T', '11111111-1111-1111-1111-111111111111', 2450), ('VH-8N2D-6R', '11111111-1111-1111-1111-111111111111', 5120), ('VH-4H7W-9C', '11111111-1111-1111-1111-111111111111', 1890),
  ('VH-6J3B-8L', '11111111-1111-1111-1111-111111111111', 4200), ('VH-2F5V-7Q', '11111111-1111-1111-1111-111111111111', 3150), ('VH-9K8T-3D', '11111111-1111-1111-1111-111111111111', 6600), ('VH-5M2R-4X', '11111111-1111-1111-1111-111111111111', 2780),
  ('VH-1W6C-2P', '11111111-1111-1111-1111-111111111111', 4450), ('VH-7T3N-5J', '11111111-1111-1111-1111-111111111111', 3320),
  ('VH-TEST-01', '11111111-1111-1111-1111-111111111111', 5000);  -- easy to type for manual tests (50,00 €)
-- demo: accept old test receipts (production default is 48 hours)
update economy_config set receipt_max_age_hours = 0 where id = 1;
