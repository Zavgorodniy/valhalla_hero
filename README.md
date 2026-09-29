# Valhalla Hero

Community & loyalty app for a bar chain in Germany: guests scan receipts, share moderated photo check-ins,
follow events and trade coins for merch and perks. See [docs/SPEC.md](docs/SPEC.md).

Mobile tabs: **Held** (hero, gear, Hall of Fame, achievements) · **Events** (upcoming, then past events; likes) ·
**Hinzufügen** (raised centre button: receipt QR / one-time code) · **Saga** (photo check-in feed, likes) · **Beute** (shop, vouchers).
Settings (top right on Held) hold language, hero form, notifications, bug report, sign-out and account deletion.

## Layout

- `apps/mobile` — Flutter iOS/Android guest app (with Staff tab)
- `apps/admin` — Flutter Web admin
- `packages/core` — shared models, repositories, theme, i18n
- `supabase/` — migrations, seed, edge functions

## Setup

```bash
dart pub global activate melos
melos bootstrap
melos run gen
supabase start          # local stack (Docker)
supabase db reset       # migrations + seeds/content.sql, demo_players.sql, demo_users.sql
./supabase/seed_media.sh      # event flyers + demo Saga photos (needs the stack running)
```

Configuration lives in `.env` at the repo root (git-ignored; template `.env.example`): `SUPABASE_URL`,
`SUPABASE_ANON_KEY`, optional Google client ids. Empty values mean the local stack (`http://127.0.0.1:54421`).

```bash
cp .env.example .env    # then fill in the Supabase URL and anon key
cd apps/mobile && flutter run --dart-define-from-file=../../.env
cd apps/admin && flutter run -d chrome --dart-define-from-file=../../.env
```

A physical phone against the *local* stack needs the Mac's LAN address (`SUPABASE_URL=http://<mac-ip>:54421`)
or, over USB on Android, `adb reverse tcp:54421 tcp:54421`.

## Demo accounts (local seed)

Password for all: `Valhalla123!`

| Email | Role |
|---|---|
| admin@valhalla.demo | admin (web admin, everything) |
| staff@valhalla.demo | staff (Settings → Team mode: confirm visits, review photos, redeem vouchers) |
| guest@valhalla.demo | guest "Ragnar", level 4 (Held) |
| lagertha@ / bjorn@ / floki@ / ivar@ / astrid@ / ubbe@ / torvi@valhalla.demo | guests with seeded history (Lagertha, Astrid, Torvi play as Heldin) |

Local Supabase ports are rebased to `544xx` (see `supabase/config.toml`) so it can run next to other local projects.
Android emulator: `SUPABASE_URL=http://10.0.2.2:54421`.

## Demo content

The demo bar is **Valhalla Helmstedt** (Papenberg 2). Apart from one test event that is always "tonight"
(Bundesliga live), the events are the bar's real past events from instagram.com/valhallahelmstedt – flyer,
caption and Instagram likes as the starting like count. Flyers live in `supabase/seed_media/events/` and are uploaded
to the public `media` bucket by `seed_media.sh`; `posts.image_url` can be a full URL or a path in that bucket.

## Branding

App icon = design "App-Symbol" variant C "Herdfeuer" (horse from the bar logo, flame mane), home-screen name "Valhalla Hero".
Sources in `apps/mobile/assets/branding/` (full icon, adaptive-icon layers, splash emblem); regenerate from `apps/mobile`:

```bash
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

`flutter_native_splash` rewrites `ios/Runner/Info.plist` (re-indents it, adds `UIStatusBarHidden`) and
`flutter_launcher_icons` touches `project.pbxproj`; review those diffs and keep only what is needed.
Coins show the same horse (`packages/core/assets/art/brand/coin_horse.svg`, from 20 px up).

## Receipts (demo)

The centre tab credits a visit from the receipt itself, never from a typed amount:

- **TSE QR code** (German KassenSichV / DSFinV-K format `V0;<register serial>;…;Beleg^<gross per VAT rate>^…;<tx no>;…`).
  The amount is the sum of the gross fields; each register serial + transaction number counts once.
  Registers must be listed in `venue_registers` (demo: `VH-BERLIN-KASSE-1`). The TSE signature is **not** verified yet.
- **One-time code** printed on the receipt (`receipt_codes`, demo: `VH-7Q4K-2M`, `VH-3X9P-5T`, `VH-8N2D-6R`, … see `supabase/seeds/content.sql`).
- Several receipts per day are fine (split bills, a second round): the first receipt of the day is the visit
  (fixed XP, streak, visit count); later ones join that visit and only add coins, within `daily_coin_cap`.
  `receipt_daily_limit` (default 10) is only an abuse guard. Receipts older than `receipt_max_age_hours`
  are rejected (the demo seed sets it to `0` = off).
- "Ohne QR melden" falls back to the staff-confirmed visit claim.

Test material: `docs/test-receipts/*.png` (valid TSE receipts, an unknown register, two code receipts; regenerate with
`swift tools/make_test_receipts.swift`). On the iOS simulator there is no camera and image analysis is unsupported,
so use **Code eingeben** or the **Demo-Beleg** button (shown only against a local backend).

## Languages

UI: German (template), English, Russian, Ukrainian, Dutch, French, Italian, Spanish, Polish, Turkish
(`packages/core/lib/src/l10n/app_*.arb`, run `flutter gen-l10n` in `packages/core`). Admin-only strings exist in DE/EN
and fall back to German. Server-side content (items, achievements, notifications) is DE/EN; other languages show English.

## Deploying to Supabase Cloud

Seeds are split: `supabase/seeds/content.sql` (venue, levels, gear, rewards, events, demo receipt codes – no users),
`demo_players.sql` (eight test players with history for the Hall of Fame; random passwords, nobody can sign in as them)
and `demo_users.sql` (admin/staff and the shared password `Valhalla123!` – local only). For a cloud project:

```bash
supabase link --project-ref <ref>
supabase db push                                         # schema + functions
supabase db query --linked -f supabase/seeds/content.sql # bar content, once
supabase db query --linked -f supabase/seeds/demo_players.sql # optional: test players, once
supabase seed buckets --linked                           # event flyers -> media bucket
```

Then put `https://<ref>.supabase.co` and the publishable/anon key into `.env`. Staff/admin roles are set per account
(`update profiles set role = 'staff' where nickname = '…'`). With "Confirm email" on (Auth → Providers → Email),
sign-up shows a "check your inbox" step; turn it off for quick testing.

## Social login

- Google: create OAuth clients (Web + iOS + Android), enable the Google provider in Supabase Auth, pass
  `GOOGLE_WEB_CLIENT_ID` / `GOOGLE_IOS_CLIENT_ID` in `.env` (the Google button appears once they are set).
- Apple: enable Sign in with Apple capability in Xcode and the Apple provider in Supabase Auth.

## Push notifications

FCM is wired but optional: without `android/app/google-services.json` and `ios/Runner/GoogleService-Info.plist`
the app logs "Firebase not configured" and runs without push. Device tokens are stored in `device_tokens`;
sending is left to a Supabase Edge Function / cron (not part of v1).

## Legal notes baked into the design

- XP per visit is fixed, never proportional to the bill; leaderboards rank XP, not spend (App Store 1.4.3, Google Play, Deutscher Werberat).
- 18+ self-declaration at onboarding; separate, unticked marketing consents (DSGVO Art. 7(4)).
- Coins expire after 36 months (configurable) with a 30-day warning; XP never decays.
- Account deletion and data export are self-service in Settings.
- Operator paperwork still required: Teilnahmebedingungen, Datenschutzerklärung, DPIA, VAT on merch rewards.
