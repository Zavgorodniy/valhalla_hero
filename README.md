# Valhalla Hero

Loyalty & gamification app for a bar chain in Germany. See [docs/SPEC.md](docs/SPEC.md).

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
supabase db reset       # applies migrations + seed
```

Run the mobile app against local Supabase:

```bash
cd apps/mobile
flutter run --dart-define=SUPABASE_URL=http://127.0.0.1:54321 --dart-define=SUPABASE_ANON_KEY=<anon key from `supabase status`>
```

Admin (web):

```bash
cd apps/admin
flutter run -d chrome --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_ANON_KEY=...
```

## Demo accounts (local seed)

Password for all: `Valhalla123!`

| Email | Role |
|---|---|
| admin@valhalla.demo | admin (web admin, everything) |
| staff@valhalla.demo | staff (mobile "Team" tab: approve claims, redeem vouchers) |
| guest@valhalla.demo | guest "Ragnar", level 4 (Held) |
| lagertha@ / bjorn@ / floki@ / ivar@ / astrid@ / ubbe@ / torvi@valhalla.demo | guests with seeded history (Lagertha, Astrid, Torvi play as Heldin) |

Local Supabase ports are rebased to `544xx` (see `supabase/config.toml`) so it can run next to other local projects.
Android emulator: pass `--dart-define=SUPABASE_URL=http://10.0.2.2:54421`.

## Deploying to Supabase Cloud

```bash
supabase link --project-ref <ref>
supabase db push            # migrations
psql "$DB_URL" -f supabase/seed.sql   # optional demo data (creates demo auth users!)
```

Then run the apps with `--dart-define=SUPABASE_URL=https://<ref>.supabase.co --dart-define=SUPABASE_ANON_KEY=<publishable key>`.

## Social login

- Google: create OAuth clients (Web + iOS + Android), enable the Google provider in Supabase Auth, pass
  `--dart-define=GOOGLE_WEB_CLIENT_ID=... --dart-define=GOOGLE_IOS_CLIENT_ID=...`.
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
