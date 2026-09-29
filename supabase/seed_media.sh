#!/usr/bin/env bash
# Demo media for the local stack. Run after `supabase db reset`:  ./supabase/seed_media.sh
#  1. event images (supabase/seed_media/events) -> `media` bucket via [storage.buckets.media]
#     in config.toml (cloud: `supabase seed buckets --linked`)
#  2. photo check-ins of the demo users: uploads a few images to the `checkins` bucket and
#     creates approved (and one pending) check-ins, unless demo check-ins already exist.
set -euo pipefail
cd "$(dirname "$0")/.."

eval "$(supabase status -o env | grep -E '^(API_URL|SERVICE_ROLE_KEY)=')"
KEY="$SERVICE_ROLE_KEY"
ART=packages/core/assets/art/scenes

supabase seed buckets --local > /dev/null
echo "Uploaded event images."

if [ "$(curl -sf "$API_URL/rest/v1/checkins?photo_path=like.*demo-*&select=id&limit=1" \
  -H "Authorization: Bearer $KEY" -H "apikey: $KEY")" != "[]" ]; then
  echo "Demo check-ins already present."
  exit 0
fi

upload() { # user_id file -> path
  local path="$1/demo-$(basename "$2")"
  curl -sf -X POST "$API_URL/storage/v1/object/checkins/$path" \
    -H "Authorization: Bearer $KEY" -H "apikey: $KEY" -H "x-upsert: true" \
    -H "Content-Type: image/webp" --data-binary "@$2" > /dev/null
  echo "$path"
}

row() { # user_id path caption status hours_ago likes
  local ts; ts="$(date -u -v-"$5"H +%Y-%m-%dT%H:%M:%SZ)"
  printf '{"user_id":"%s","photo_path":"%s","caption":%s,"status":"%s","reviewed_at":%s,"created_at":"%s","like_count":%s,"rewarded":%s}' \
    "$1" "$2" "$3" "$4" "$([ "$4" = approved ] && echo "\"$ts\"" || echo null)" "$ts" "$6" \
    "$([ "$4" = approved ] && echo true || echo false)"
}

BJORN=a0000000-0000-0000-0000-000000000005
LAGERTHA=a0000000-0000-0000-0000-000000000004
FLOKI=a0000000-0000-0000-0000-000000000006
TORVI=a0000000-0000-0000-0000-000000000010
UBBE=a0000000-0000-0000-0000-000000000009
IVAR=a0000000-0000-0000-0000-000000000007

ROWS="[
$(row $LAGERTHA "$(upload $LAGERTHA $ART/hall.webp)" '"Freitagabend am Feuer"' approved 3 12),
$(row $BJORN "$(upload $BJORN $ART/fjord.webp)" '"Neues Valhalla-Shirt, passt!"' approved 20 9),
$(row $FLOKI "$(upload $FLOKI $ART/aurora.webp)" '"Nordlicht-Deko an der Theke"' approved 30 7),
$(row $TORVI "$(upload $TORVI $ART/raven.webp)" '"Der Rabe wacht über die Halle"' approved 52 15),
$(row $UBBE "$(upload $UBBE $ART/splash.webp)" null approved 75 4),
$(row $IVAR "$(upload $IVAR $ART/empty.webp)" '"Mein erstes Foto hier"' pending 1 0)
]"

curl -sf -X POST "$API_URL/rest/v1/checkins" \
  -H "Authorization: Bearer $KEY" -H "apikey: $KEY" -H "Content-Type: application/json" \
  -H "Prefer: return=minimal" -d "$ROWS"
echo "Seeded demo check-ins."
