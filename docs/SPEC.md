# Valhalla Hero — Product & Architecture Spec (v1)

Status: agreed 2026-09-08. This file is the canonical record of product decisions.
Change it deliberately; everything in code follows from it.

## 1. Context

- Loyalty + gamification app for a bar chain in Germany. One bar today, the data model is multi-venue from day one.
- Owner is the client; all product decisions are made by the developer (Mykola).
- Goals, in order: more visits and load, engagement, interest in merch. First milestone: a demo.
- No deadline.

## 2. Platforms & stack

| Layer | Choice |
|---|---|
| Mobile | Flutter (iOS + Android), Riverpod, go_router, freezed |
| Admin | Flutter Web, same monorepo |
| Backend | Supabase (Postgres, Auth, Storage, Edge Functions) |
| Push | Firebase Cloud Messaging |
| i18n | German primary, English second (ARB, gen-l10n) |
| Theme | Dark only in v1 |
| Repo | `apps/mobile`, `apps/admin`, `packages/core`, `supabase/` (pub workspace + melos) |

All crediting/economy logic lives in Postgres functions (SECURITY DEFINER) behind RLS.
Clients never write to ledgers directly.

## 3. Roles

`user` (guest), `staff` (bartender: redeem vouchers, approve claims in the mobile "Staff" tab),
`manager` (own venue: news, events, claims), `admin` (everything, admin web app).

## 4. Earning (v1)

- Guest submits a **visit claim**: venue, bill amount (EUR), optional note. No photo in v1.
- Staff/manager/admin approves or rejects. On approval the server credits:
  - **XP**: fixed `xp_per_visit` (NOT proportional to the bill — App Store 1.4.3 / Google Play / Deutscher Werberat forbid encouraging alcohol consumption) + streak bonus.
  - **Coins**: `coins_per_euro × amount × level_multiplier`, capped by `daily_coin_cap`.
- Admin can also credit manually (same RPC, `source = 'manual'`).
- QR receipt scanner (DSFinV-K / TSE signature verification) is v2; claims remain as fallback.

## 5. Two scales

- **XP** only grows. Level thresholds are config (`economy_config.level_thresholds`).
- **Coins** are spent on rewards and cosmetic items. Each credit expires 36 months after issue (config); users get a notification 30 days before expiry. Coins are legally a free, revocable discount privilege, never a cash-value voucher.
- No XP decay. Activity is shown as **"On board the longship"**: visited within `onboard_window_days` (default 30). Weekly visit streak gives an XP bonus.

## 6. Levels & heroes (variant A)

| Lvl | Name | Default XP threshold |
|---|---|---|
| 1 | Thrall | 0 |
| 2 | Karl | 100 |
| 3 | Drengr | 300 |
| 4 | Huskarl | 700 |
| 5 | Berserker | 1500 |
| 6 | Jarl | 3000 |
| 7 | Konungr | 6000 |
| 8 | Einherjar | 12000 |

Each level has a standard hero illustration in a **unified frontal pose**, in two **hero forms**: Held and Heldin
(`profiles.hero_form` = `hero | heroine`, chosen at onboarding, changeable any time in settings, purely cosmetic —
XP, items and economy are shared). Female level names (`levels.name_female`): Thrallin, Karlin, Drengrin, Huskarlin,
Berserkerin, Jarlin, Konungrin, Valkyrja. Base heroes carry **no equipment**; weapons, shields, capes etc. are cosmetic layers. Cosmetic **slots**: `headgear`, `hand_item`, `cape`, `companion`, `frame`.
Items are unlocked via `shop` (coins), `level`, `achievement`, `event`. Rarity: common / rare / legendary.
Level perk: coin multiplier (config per level). Art: raster heroes/portraits/backdrops/items in `packages/core/assets/art/` (cut from the concept sheets, placeholders until final art);
SVG item placeholders remain for items without painted art.

## 7. Rewards

Single **reward** model: `merch | drink | discount | priority_booking | event_access`. Price in coins, stock, validity days.
Redeeming creates a **voucher** with a short code; staff confirms it in the Staff tab. No booking system, no money payments in v1.

## 8. Feed

Admin-authored **posts**: `news` and `event` (with starts_at, venue). Users can like. No comments, no RSVP, no UGC.

## 9. Leaderboard

All-time XP, nickname + hero with equipped items, "on board" marker. Everyone participates by default; opt-out in settings (`profiles.leaderboard_visible`). Real names are never shown.

## 10. Achievements (v1 set, ~16)

first_visit, visits_5, visits_25, visits_100, streak_4w, streak_12w, events_3, events_10, venues_all,
liked_10, first_reward, rewards_5, first_item, level_4, level_8, onboard_6m. Each grants XP and a small coin bonus.

## 11. Auth & compliance

- Email + password, Google, Apple. Date of birth at onboarding, 18+ gate (self-declared).
- Separate, unticked opt-ins for push marketing and personalised offers (Art. 6(1)(a), Kopplungsverbot). Account creation only requires T&Cs + privacy acknowledgment.
- Settings: data export (JSON), account deletion (with coin-forfeiture warning), leaderboard opt-out.
- Store minimum from claims: venue, amount, timestamp.
- Operator paperwork (not app): Teilnahmebedingungen, Datenschutzerklärung, DPIA, VAT on merch rewards.

## 12. Deferred (v2+)

QR receipt scanner, money payments / real shop, referrals, Instagram story rewards (must instruct "Werbung" label),
table booking system, UGC/comments, RSVP, item-level achievements (needs POS API), light theme.
