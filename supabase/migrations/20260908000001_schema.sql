-- Valhalla Hero: core schema
create extension if not exists pgcrypto;

-- ---------- enums ----------
create type user_role as enum ('user', 'staff', 'manager', 'admin');
create type claim_status as enum ('pending', 'approved', 'rejected');
create type visit_source as enum ('claim', 'manual', 'receipt');
create type xp_reason as enum ('visit', 'streak', 'achievement', 'manual');
create type coin_reason as enum ('visit', 'achievement', 'manual', 'reward', 'item', 'expiry', 'refund');
create type item_slot as enum ('headgear', 'hand_item', 'cape', 'companion', 'frame');
create type item_rarity as enum ('common', 'rare', 'legendary');
create type item_source as enum ('shop', 'level', 'achievement', 'event');
create type reward_type as enum ('merch', 'drink', 'discount', 'priority_booking', 'event_access');
create type voucher_status as enum ('active', 'redeemed', 'expired', 'cancelled');
create type post_type as enum ('news', 'event');

-- ---------- venues ----------
create table venues (
  id uuid primary key default gen_random_uuid(),
  slug text unique not null,
  name text not null,
  address text,
  city text,
  image_url text,
  is_active boolean not null default true,
  created_at timestamptz not null default now()
);

-- ---------- economy config (single row) ----------
create table economy_config (
  id int primary key default 1 check (id = 1),
  xp_per_visit int not null default 50,
  coins_per_euro numeric(6,2) not null default 10,
  daily_coin_cap int not null default 1000,
  coin_expiry_months int not null default 36,
  onboard_window_days int not null default 30,
  streak_bonus_xp int not null default 25,
  updated_at timestamptz not null default now()
);
insert into economy_config (id) values (1);

-- ---------- levels ----------
create table levels (
  level int primary key check (level between 1 and 8),
  name text not null,
  xp_threshold int not null,
  coin_multiplier numeric(4,2) not null default 1.0,
  hero_asset text not null,
  tagline_de text,
  tagline_en text
);

-- ---------- profiles ----------
create table profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  nickname text unique not null check (char_length(nickname) between 3 and 20),
  role user_role not null default 'user',
  birth_date date not null,
  locale text not null default 'de',
  leaderboard_visible boolean not null default true,
  push_marketing_consent boolean not null default false,
  personalised_offers_consent boolean not null default false,
  consents_updated_at timestamptz,
  terms_accepted_at timestamptz not null default now(),
  xp int not null default 0,
  level int not null default 1 references levels(level),
  coin_balance int not null default 0,
  visit_count int not null default 0,
  last_visit_at timestamptz,
  current_streak_weeks int not null default 0,
  longest_streak_weeks int not null default 0,
  created_at timestamptz not null default now(),
  constraint adult_only check (birth_date <= (current_date - interval '18 years'))
);
create index profiles_xp_idx on profiles (xp desc);

create table venue_staff (
  user_id uuid references profiles(id) on delete cascade,
  venue_id uuid references venues(id) on delete cascade,
  primary key (user_id, venue_id)
);

create table device_tokens (
  user_id uuid references profiles(id) on delete cascade,
  token text not null,
  platform text not null,
  updated_at timestamptz not null default now(),
  primary key (user_id, token)
);

-- ---------- visits ----------
create table visit_claims (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  venue_id uuid not null references venues(id),
  amount_cents int not null check (amount_cents > 0 and amount_cents <= 100000),
  note text,
  status claim_status not null default 'pending',
  reviewed_by uuid references profiles(id),
  reviewed_at timestamptz,
  reject_reason text,
  created_at timestamptz not null default now()
);
create index visit_claims_status_idx on visit_claims (status, created_at);

create table visits (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  venue_id uuid not null references venues(id),
  claim_id uuid references visit_claims(id),
  amount_cents int not null,
  source visit_source not null,
  visited_at timestamptz not null default now(),
  created_by uuid references profiles(id)
);
create index visits_user_idx on visits (user_id, visited_at desc);

-- ---------- ledgers ----------
create table xp_ledger (
  id bigint generated always as identity primary key,
  user_id uuid not null references profiles(id) on delete cascade,
  amount int not null,
  reason xp_reason not null,
  ref_id text,
  created_at timestamptz not null default now()
);
create index xp_ledger_user_idx on xp_ledger (user_id, created_at desc);

create table coin_ledger (
  id bigint generated always as identity primary key,
  user_id uuid not null references profiles(id) on delete cascade,
  amount int not null,               -- positive = credit, negative = debit
  remaining int not null default 0,  -- unconsumed part of a credit (FIFO)
  reason coin_reason not null,
  ref_id text,
  expires_at timestamptz,            -- credits only
  created_at timestamptz not null default now()
);
create index coin_ledger_user_idx on coin_ledger (user_id, created_at desc);
create index coin_ledger_fifo_idx on coin_ledger (user_id, expires_at) where remaining > 0;

-- ---------- achievements ----------
create table achievements (
  key text primary key,
  name_de text not null,
  name_en text not null,
  description_de text not null,
  description_en text not null,
  icon text not null,
  xp_reward int not null default 0,
  coin_reward int not null default 0,
  sort int not null default 0
);

create table user_achievements (
  user_id uuid references profiles(id) on delete cascade,
  achievement_key text references achievements(key) on delete cascade,
  unlocked_at timestamptz not null default now(),
  primary key (user_id, achievement_key)
);

-- ---------- cosmetic items ----------
create table items (
  id uuid primary key default gen_random_uuid(),
  slot item_slot not null,
  name_de text not null,
  name_en text not null,
  description_de text,
  description_en text,
  rarity item_rarity not null default 'common',
  asset_key text not null,
  source item_source not null,
  price_coins int check (price_coins is null or price_coins > 0),
  unlock_level int references levels(level),
  unlock_achievement_key text references achievements(key),
  is_active boolean not null default true,
  sort int not null default 0,
  created_at timestamptz not null default now()
);

create table user_items (
  user_id uuid references profiles(id) on delete cascade,
  item_id uuid references items(id) on delete cascade,
  source item_source not null,
  acquired_at timestamptz not null default now(),
  primary key (user_id, item_id)
);

create table equipment (
  user_id uuid references profiles(id) on delete cascade,
  slot item_slot not null,
  item_id uuid not null references items(id) on delete cascade,
  primary key (user_id, slot)
);

-- ---------- rewards & vouchers ----------
create table rewards (
  id uuid primary key default gen_random_uuid(),
  type reward_type not null,
  name_de text not null,
  name_en text not null,
  description_de text,
  description_en text,
  image_url text,
  price_coins int not null check (price_coins > 0),
  stock int,                        -- null = unlimited
  validity_days int not null default 30,
  venue_id uuid references venues(id),
  is_active boolean not null default true,
  sort int not null default 0,
  created_at timestamptz not null default now()
);

create table vouchers (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  reward_id uuid not null references rewards(id),
  code text unique not null,
  status voucher_status not null default 'active',
  price_paid int not null,
  expires_at timestamptz not null,
  redeemed_at timestamptz,
  redeemed_by uuid references profiles(id),
  redeemed_at_venue uuid references venues(id),
  created_at timestamptz not null default now()
);
create index vouchers_user_idx on vouchers (user_id, created_at desc);

-- ---------- feed ----------
create table posts (
  id uuid primary key default gen_random_uuid(),
  type post_type not null default 'news',
  title text not null,
  body text not null,
  image_url text,
  venue_id uuid references venues(id),
  starts_at timestamptz,            -- events
  published_at timestamptz,         -- null = draft
  author_id uuid references profiles(id),
  like_count int not null default 0,
  created_at timestamptz not null default now()
);
create index posts_published_idx on posts (published_at desc) where published_at is not null;

create table post_likes (
  post_id uuid references posts(id) on delete cascade,
  user_id uuid references profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, user_id)
);

-- ---------- notifications (in-app inbox) ----------
create table notifications (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references profiles(id) on delete cascade,
  type text not null,
  title_de text not null,
  title_en text not null,
  body_de text,
  body_en text,
  data jsonb not null default '{}',
  read_at timestamptz,
  created_at timestamptz not null default now()
);
create index notifications_user_idx on notifications (user_id, created_at desc);
