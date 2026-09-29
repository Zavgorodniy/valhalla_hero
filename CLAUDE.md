# Valhalla Hero

Community & loyalty app for the Valhalla bar in Helmstedt (chain later). Early concept stage: the goal is a convincing
demo for the owner, not production hardening. Product background: [README.md](README.md), [docs/SPEC.md](docs/SPEC.md).

## Layout

Dart pub workspace (root `pubspec.yaml`) + melos:

- `packages/core` — models (freezed), repositories, Riverpod providers, theme (`VColors`, `VType`), shared widgets
  (`v_components.dart`, `VIcons`), l10n
- `apps/mobile` — guest app (iOS/Android); tabs Held · Events · [Hinzufügen] · Saga · Beute; staff "Team-Modus"
- `apps/admin` — Flutter Web admin
- `supabase/` — migrations, seeds (`seeds/content.sql`, `demo_players.sql`, `demo_users.sql`), `seed_media/`
- `design/` — design canvas and art prompts

## Commands

```bash
flutter pub get                                          # repo root
(cd packages/core && dart run build_runner build -d)     # also apps/mobile, apps/admin; *.g.dart / *.freezed.dart are git-ignored
(cd packages/core && flutter gen-l10n)                   # after editing ARB files
(cd apps/mobile && flutter analyze)                      # same for packages/core (use `flutter analyze lib`) and apps/admin
(cd apps/admin && flutter build web)
```

There are no test suites yet, and none are wanted at this stage.

## Conventions

- Dark theme only; use `VColors` / `VType` / existing `V*` components instead of raw Material styling.
- Every user-visible string goes through `L10n.of(context)`. `app_de.arb` is the template; mobile strings must exist
  in all 10 languages (de, en, ru, uk, nl, fr, it, es, pl, tr). Admin-only keys (`admin*` and the few used only in
  `apps/admin`) exist in DE/EN only on purpose.
- Server content (items, rewards, achievements, levels) has `*_de` / `*_en` columns; other locales show English.
- All crediting (XP, coins, vouchers) happens server-side in SQL functions. Internal `SECURITY DEFINER` helpers must
  have `EXECUTE` revoked from `anon`/`authenticated` (see `20260926000003_lock_internal_functions.sql`).
- New DB changes = new migration file in `supabase/migrations/`, never edit applied ones.
- XP is fixed per visit, never proportional to the bill (store / alcohol-advertising rules). No alcohol wording in copy.
- Config comes from `.env` via `--dart-define-from-file` (git-ignored); empty values mean the local Supabase stack.

## Cloud sessions

`scripts/cloud-setup.sh` is the environment setup script (Flutter 3.44.0); the SessionStart hook
`scripts/cloud-session-start.sh` runs `pub get` + code generation. In the cloud there is no iOS simulator, Android
emulator, `.env` or Supabase backend, so work that needs them (running the app, visual checks, DB migrations against a
live stack) is verified locally by the developer. Finish with `flutter analyze` clean in the packages you touched and
describe in the PR what still needs checking on a device.
