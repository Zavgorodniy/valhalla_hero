# Valhalla Hero — concept generation prompts

Prompt 1 is the master brief (ChatGPT / Gemini / Figma Make / Google Stitch — anything that can do a design system + screens).
Prompts 2–6 are for image models (Midjourney / GPT-image / Flux / Nano Banana) to produce the actual art.
Recommended order: mood board + one hero (Huskarl) first → approve the style → generate the rest with that image as style/character reference.

---

## 1. Master brief

```text
You are a senior game UI/UX art director. Create a complete visual concept (art direction + design system + key screens) for a mobile app.

## Product
"Valhalla Hero" — loyalty & gamification app for a Viking-themed bar chain in Germany ("Valhalla"). Guests (18+) report a bar visit, staff approve it, and the guest earns:
- XP (never decreases, raises the level from 1 to 8),
- Coins (spent in the shop on rewards and hero cosmetics).
Each guest has a Viking hero avatar that evolves visually with level and can be dressed with cosmetic items. There is an all-time leaderboard, a news/events feed, achievements, and vouchers redeemed at the bar counter.
Platform: iOS + Android (Flutter). Dark theme only. UI language: German (primary), English second — use German labels in mockups.
Tone: epic but warm and playful — the feeling of walking into a fire-lit mead hall with friends. A premium mobile RPG, not a corporate loyalty card and not a cheesy costume party.

## Art direction — "Hearth & Iron"
- Atmosphere: night inside a mead hall; firelight, smoke, drifting embers; carved dark oak, hammered iron, worn leather, parchment. Norse knotwork used sparingly as ornament on frames and dividers.
- Light: warm firelight key light, cool moonlight/aurora rim light. Deep shadows; high contrast only on focal points.
- Rendering: stylized hand-painted 2.5D, bold readable silhouettes, visible brush texture, slightly heroic proportions (~1:6 head-to-body). Must read clearly at 64 px.
- UI surfaces: dark, subtly textured (wood grain / charred iron at 3–6 % opacity), thin metallic borders with small corner ornaments on hero elements only; plain flat surfaces for lists and forms. Ornament is seasoning, not the meal.

## Color system (starting point — refine, keep WCAG AA contrast)
- Background "Night Hall" #0E0B09; surfaces #1A1411 / #241C17 / #2F2520; lines #3A302A
- Text "Bone" #EDE3D0; secondary "Ash" #9A8F80
- Primary action + Coins "Ember Gold" #E3A645 (bright #F5C66B, dim #8A6428) — only ONE gold primary action per screen
- XP / progression "Rune Frost" #6FB3C8 with a soft glow — XP bars, level-up effects. XP and Coins must never look alike.
- Danger "Blood" #A8322A; success "Moss" #6B9A4E
- Level colors (badges, hero backdrop tint): 1 Thrall ash grey · 2 Karl earth brown · 3 Drengr forest green · 4 Huskarl steel blue · 5 Berserker blood red · 6 Jarl royal purple · 7 Konungr gold · 8 Einherjar radiant white-gold
- Rarity: common iron grey · rare rune blue · legendary gold with shimmer

## Typography (Google Fonts only, full German support ä ö ü ß)
- Display (wordmark, screen titles, level names, big numbers): chiselled capital serif with Norse character (e.g. Cinzel, Marcellus SC). Propose 2 options, pick one.
- UI/body: clean sans with tabular figures (e.g. Manrope, Inter, Barlow).
- Optional accent: Noto Sans Runic for decorative rune strips only, never readable text.
- No blackletter / Fraktur.

## Iconography
Custom stroke icon set (1.75 px, rounded joins, 24 px grid) with Norse motifs, plus a filled active state:
Halle (longhouse), Saga (scroll), Beute (chest), Rangliste (banners/podium), Profil (helmet), Team (key/badge), Besuch melden (receipt with rune seal), coin, XP rune, streak (longship), on-board (anchor), notifications (horn), settings, lock, check, voucher/ticket.
16 achievement medallions: round embossed metal badges (bronze/silver/gold), locked state = dull iron silhouette.

## Heroes (most important asset)
8 level heroes, one continuous evolution from poor to legendary, all in the SAME unified pose: full body, facing front, symmetric neutral stance, feet shoulder-width, arms slightly away from the body, right hand in a relaxed half-fist at hip height (held items are layered there). Head uncovered, no cape, no weapon, no shield, no animal — those are cosmetic layers. Same scale, same baseline, same 10:13 canvas, transparent/plain background.
1 Thrall – rags, rope belt, barefoot, humble but determined
2 Karl – simple wool tunic, leather shoes, free farmer
3 Drengr – young warrior, padded gambeson, leather bracers
4 Huskarl – chainmail, sturdy belt with bronze buckle, veteran guard
5 Berserker – bare arms, bear-fur mantle, dark ash war paint (no blood)
6 Jarl – embroidered tunic, silver arm rings, fur-trimmed coat
7 Konungr – ornate lamellar armor, gold arm rings, royal bearing
8 Einherjar – chosen warrior of Valhalla, golden-white ethereal armor, faint divine glow
Optional: a female variant for every level with the same pose and silhouette logic.

Cosmetic layers (separate transparent images that fit the unified pose):
- Headgear: leather cap, iron helm, horned helm (playful fantasy), raven hood, crown
- Hand item (right hand): axe, drinking horn, round shield, spear, sword
- Cape (behind the body): wool, fur, royal
- Companion (beside feet or on shoulder): raven, wolf, bear cub
- Frame (around the avatar card): wood, iron, runic, saga, gold

## Backgrounds
One vertical backdrop per level (behind the hero on Halle and hero screens), dark, calm and low-detail in the top third where UI sits:
1 misty muddy shore · 2 village with smoking roofs · 3 longship deck on a fjord · 4 guarded longhouse gate at night · 5 storm over a battlefield hill · 6 jarl's great hall with hearth · 7 cliff fortress under aurora · 8 golden gates of Valhalla above the clouds.
Plus: login/splash (mead hall doors opening, firelight spilling out), empty states (quiet hall, empty chest), level-up celebration (rune ring + embers).

## Screens (iPhone 402×874, German labels)
1. Login / Onboarding — splash art, wordmark, Apple/Google/email buttons, 18+ note
2. Halle (home) — hero on its level backdrop, nickname, level badge "IV · Huskarl", XP bar to next level, coins, visits, weekly streak, "An Bord" status, primary button "Besuch melden", achievements strip, recent activity
3. Held anpassen — large hero, 5 slot tabs, item grid with rarity, locked items with unlock condition (coins / level / achievement / event)
4. Beute — tabs Belohnungen / Ausrüstung; reward cards (merch, drink, discount, priority booking, event access) with coin price and stock
5. Gutschein — large redeem code for the bartender, validity, status
6. Rangliste — top-3 podium with heroes, list rows (rank, hero thumb, nickname, XP, on-board marker), own row pinned
7. Saga — news and event cards with image, date, like
8. Profil / Erfolge — stats, achievement medal grid
9. Level-up moment — full-screen celebration
Bottom navigation: 5 tabs (+ "Team" for staff), custom styled, not default Material.

## Hard constraints
- Never glorify alcohol: no drunk characters, no chugging, no overflowing beer as a reward motif. XP rewards visits, not spending; never show bill amounts as achievements.
- Germany: runes only as decorative texture or spelling "VALHALLA". Do NOT use symbols tied to far-right movements: Othala/Odal, Sowilo/Sig (esp. doubled), Tiwaz as emblem, Algiz ("Lebensrune") and its inverted form, Hagalaz, Wolfsangel, Black Sun/Sonnenrad, triskele, Celtic cross, Totenkopf, Iron Cross, eagle-on-wreath; no Valknut as a central emblem. Mjölnir is fine.
- Fantasy-friendly Norse: horned helmets only as a playful cosmetic.
- Implementable in Flutter: flat layers, 9-slice frames, gradients, PNG/WebP illustrations, SVG icons. No real-time 3D.
- Accessibility: body text ≥ 4.5:1, touch targets ≥ 44 pt, never text on busy art without a scrim.

## Deliverables
1. Mood board (6–9 tiles) + one-paragraph art direction statement
2. Color tokens (name, hex, usage), type scale (size / weight / line height), radius & spacing scale
3. Component sheet: buttons (primary / secondary / ghost), coin pill, XP bar, level badge, rarity chip, card (plain + ornamented), tab bar, input, list row, achievement medal locked/unlocked
4. Hero lineup: all 8 levels side by side + one hero fully equipped
5. The 9 screens above
6. App icon (1024 px) and splash
```

---

## 2. Hero lineup (image model)

```text
Character lineup sheet of 8 Viking heroes showing progression from poor thrall to divine Valhalla warrior, left to right: 1 thrall in rags and rope belt, barefoot; 2 free farmer in simple wool tunic; 3 young warrior in padded gambeson and leather bracers; 4 veteran guard in chainmail with bronze belt buckle; 5 berserker with bare arms, bear-fur mantle and dark ash war paint; 6 jarl in embroidered tunic, silver arm rings, fur-trimmed coat; 7 king in ornate lamellar armor with gold arm rings; 8 einherjar in golden-white ethereal armor with a faint divine glow. All in the identical pose: full body, front view, symmetric neutral stance, arms slightly away from the body, right hand relaxed half-fist at hip, head uncovered, no weapons, no shields, no capes, no animals. Same height, same baseline. Stylized hand-painted 2.5D mobile RPG character art, bold readable silhouettes, visible brush texture, warm firelight key light, cool blue rim light, plain dark charcoal background, no text --ar 16:9
```

Single hero (repeat per level, attach the lineup as character/style reference; Midjourney: `--oref` / `--sref`):

```text
[LEVEL DESCRIPTION], single Viking hero character, full body, front view, symmetric neutral stance, arms slightly away from the body, right hand relaxed half-fist at hip, head uncovered, no weapon, no cape, no shield, centered, feet on the lower baseline, stylized hand-painted 2.5D mobile RPG art, warm firelight key light, cool blue rim light, plain flat dark background for easy cutout, no text --ar 10:13
```

## 3. Level backdrops

```text
Vertical mobile game background, [SCENE], stylized hand-painted, dark and moody, palette of deep brown-black, ember gold and frost blue, top third calm and dark for UI text, soft focal light at lower center where a character will stand, atmospheric haze and drifting embers, no characters, no text --ar 9:19
```

Scenes: misty muddy shore at dawn · Viking village with smoking roofs · longship deck on a fjord at dusk · guarded longhouse gate at night with torches · storm over a battlefield hill · jarl's great hall with a roaring hearth · cliff fortress under aurora · golden gates of Valhalla above the clouds · (login) mead hall doors opening with firelight spilling out.

## 4. Cosmetic items

```text
Game item icon sheet, Norse Viking cosmetics, stylized hand-painted, each item isolated and evenly spaced on a plain dark background, consistent top-left warm light, 3/4 view: leather cap, iron helm, stylized horned helm, raven-feather hood, gold crown, bearded axe, carved drinking horn, round shield with painted knotwork, spear, sword, grey wool cape, fur cape, royal crimson cape with gold trim, raven, wolf, bear cub, no text --ar 1:1
```

## 5. Achievement medals

```text
Set of 16 round embossed metal medallions for a mobile game, Norse motifs: longship, longhouse, carved horn, round shield, raven, anchor, crown, map, drum, treasure chest, helmet, ring of decorative runes, star, banner, torch, tree; bronze, silver and gold tiers, stylized hand-painted, soft rim light, plain dark background, no text, no swastika-like or far-right runic symbols --ar 1:1
```

## 6. Reward illustrations

```text
Five reward illustrations for a Viking bar loyalty app, same stylized hand-painted style, each isolated on plain dark background: black merch t-shirt folded with a small longship emblem; a carved wooden drink token coin; a glowing rune coin with a percent sign for a discount; a reserved table with a candle and a wax-sealed card for priority booking; a parchment ticket with a wax seal for event access; no overflowing drinks, no text --ar 16:9
```

---

## 7. Heroes and heroines without equipment (regeneration)

The concept sheets are usable as placeholders, but the final base art must be **bare**: no weapon, shield, helmet,
cape or animal — those are cosmetic layers. On the heroine sheet the Huskarlin holds a shield and the Berserkerin an
axe; regenerate both (and ideally all 16) with this prompt, one image per level, using the concept sheet as
character/style reference (Midjourney `--oref` / `--sref`):

```text
[LEVEL DESCRIPTION], single Viking [hero | heroine] character, full body, front view, symmetric neutral stance,
arms slightly away from the body, both hands empty and relaxed at hip height, head uncovered, no weapon, no shield,
no helmet, no cape, no animal, nothing held in the hands, centered, feet on the lower baseline, same scale for every
level, stylized hand-painted 2.5D mobile RPG art, warm firelight key light, cool blue rim light,
plain flat dark background (#141414) for clean cutout, no text --ar 10:13
```

Heroine level descriptions: 1 Thrallin – ragged dress, rope belt, barefoot · 2 Karlin – wool dress, leather belt
with pouches · 3 Drengrin – young warrior, gambeson, braided hair · 4 Huskarlin – chainmail, bronze buckle, fur
shoulders · 5 Berserkerin – fur mantle, war paint (no blood), bare arms · 6 Jarlin – embroidered blue coat, braids,
silver jewellery · 7 Konungrin – royal gown with gold embroidery, circlet · 8 Valkyrja – golden-white ethereal
armour, faint divine glow.

Deliver each as PNG with transparent background (or on the flat dark background) at ≥ 1024 px height, so the app
no longer needs the approximate cutouts. Drop the files into `packages/core/assets/art/heroes/` as
`hero_<n>.webp` / `heroine_<n>.webp` and portraits as `assets/art/portraits/…` — no code changes needed.
