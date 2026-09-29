#!/bin/bash
# SessionStart hook (.claude/settings.json). Cloud sessions only: fetch packages and generate the git-ignored
# freezed / json_serializable code so `flutter analyze` works. Locally this exits immediately.
[ "$CLAUDE_CODE_REMOTE" = "true" ] || exit 0

if ! command -v flutter >/dev/null; then
  echo "Flutter is not installed: add scripts/cloud-setup.sh as the cloud environment's setup script." >&2
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR" || exit 0
flutter pub get
for dir in packages/core apps/mobile apps/admin; do
  (cd "$dir" && dart run build_runner build -d)
done
exit 0
