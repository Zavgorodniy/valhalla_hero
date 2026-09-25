import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'item_tile.dart';

/// Held tab: the hero with five cosmetic slots, the level path and achievements.
class HeroScreen extends ConsumerStatefulWidget {
  const HeroScreen({super.key, this.initialSegment = 0});
  final int initialSegment;
  @override
  ConsumerState<HeroScreen> createState() => _HeroScreenState();
}

class _HeroScreenState extends ConsumerState<HeroScreen> {
  late int _seg = widget.initialSegment.clamp(0, 2);
  ItemSlot _slot = ItemSlot.headgear;
  String? _selectedId;

  @override
  void didUpdateWidget(covariant HeroScreen old) {
    super.didUpdateWidget(old);
    if (old.initialSegment != widget.initialSegment) _seg = widget.initialSegment.clamp(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final profile = ref.watch(profileProvider).valueOrNull;
    final levels = ref.watch(levelMapProvider);
    if (profile == null) return const SizedBox.shrink();
    final form = profile.heroForm;
    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    final owned = (ref.watch(myItemsProvider).valueOrNull ?? const <UserItem>[]).map((i) => i.itemId).toSet();
    final equipment = ref.watch(myEquipmentProvider).valueOrNull ?? const <Equipment>[];
    final equippedIds = equipment.map((e) => e.itemId).toSet();
    final bySlot = {for (final e in equipment) e.slot: items.where((i) => i.id == e.itemId).firstOrNull};
    final achievements = ref.watch(achievementsProvider).valueOrNull ?? const <Achievement>[];
    final selected = _seg == 0 ? items.where((i) => i.id == _selectedId && i.slot == _slot).firstOrNull : null;

    Widget slotButton(ItemSlot s) {
      final it = bySlot[s];
      final sel = _seg == 0 && _slot == s;
      return Semantics(
        button: true,
        selected: sel,
        label: '${slotName(t, s)}${it == null ? '' : ': ${it.name(locale)}'}',
        child: GestureDetector(
          onTap: () => setState(() {
            _seg = 0;
            _slot = s;
            _selectedId = null;
          }),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: VColors.bg.withValues(alpha: .78),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: sel ? VColors.goldBright : (it == null ? const Color(0xFF6A5A4A) : VColors.rarity(it.rarity).withValues(alpha: .67)),
                  width: 1.5,
                ),
                boxShadow: sel ? [BoxShadow(color: VColors.gold.withValues(alpha: .45), blurRadius: 18)] : null,
              ),
              child: Center(child: it == null ? VIcon(slotIcon(s), size: 22, color: const Color(0xFF8C7F70), stroke: 1.8) : VItemArt(assetKey: it.assetKey, slot: s, size: 50)),
            ),
            const SizedBox(height: 5),
            Text(slotName(t, s),
                style: VType.body(size: 11, weight: FontWeight.w800, color: sel ? VColors.goldBright : const Color(0xFFCDBFA8)).copyWith(shadows: const [Shadow(blurRadius: 4)])),
          ]),
        ),
      );
    }

    final content = switch (_seg) {
      0 => _gear(t, locale, items, owned, equippedIds, achievements),
      1 => _Path(profile: profile),
      _ => _Achievements(profile: profile),
    };

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        child: Stack(children: [
          CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 560,
                child: Stack(children: [
                  Positioned.fill(
                    child: VHeroStage(level: profile.level, form: form, height: 560, heroHeight: 398, heroTop: 80, companion: bySlot[ItemSlot.companion]?.assetKey),
                  ),
                  SafeArea(
                    bottom: false,
                    child: VTopBar(
                      title: t.myHero,
                      actions: [
                        VRoundButton(
                          icon: VIcons.share,
                          tooltip: t.share,
                          onTap: () => Share.share(t.shareLevelText(levelName(levels, profile.level, form))),
                        ),
                        VRoundButton(icon: VIcons.settings, tooltip: t.settings, onTap: () => context.push('/settings')),
                      ],
                    ),
                  ),
                  Positioned(left: 16, top: 150, child: Column(children: [slotButton(ItemSlot.headgear), const SizedBox(height: 16), slotButton(ItemSlot.handItem)])),
                  Positioned(
                    right: 16,
                    top: 150,
                    child: Column(children: [
                      slotButton(ItemSlot.cape),
                      const SizedBox(height: 16),
                      slotButton(ItemSlot.companion),
                      const SizedBox(height: 16),
                      slotButton(ItemSlot.frame),
                    ]),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 16,
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      VLevelBadge(level: profile.level, size: 34),
                      const SizedBox(width: 12),
                      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(profile.nickname, style: VType.cinzel(size: 22, height: 1.1)),
                        Text('${levelName(levels, profile.level, form)} · ${t.xpLabel(profile.xp)}',
                            style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.ash, tabular: true)),
                      ]),
                    ]),
                  ),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              sliver: SliverToBoxAdapter(
                child: VSegmented(
                  labels: [t.gear, t.heroPath, t.achievements],
                  index: _seg,
                  onChanged: (i) => setState(() {
                    _seg = i;
                    _selectedId = null;
                  }),
                ),
              ),
            ),
            content,
            SliverToBoxAdapter(child: SizedBox(height: kTabBarSpace + (selected != null ? 76 : 0))),
          ]),
          if (selected != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 66 + MediaQuery.paddingOf(context).bottom,
              child: ItemActionBar(
                key: ValueKey(selected.id),
                item: selected,
                state: itemState(selected, owned: owned, equipped: equippedIds),
                lockText: unlockText(t, selected, achievements, locale),
              ),
            ),
        ]),
      ),
    );
  }

  Widget _gear(L10n t, String locale, List<Item> items, Set<String> owned, Set<String> equipped, List<Achievement> achievements) {
    final slotItems = items.where((i) => i.slot == _slot).toList()
      ..sort((a, b) {
        int rank(Item i) => itemState(i, owned: owned, equipped: equipped).index;
        final r = rank(a).compareTo(rank(b));
        return r != 0 ? r : a.sort.compareTo(b.sort);
      });
    final ownedCount = slotItems.where((i) => owned.contains(i.id)).length;
    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 34,
          child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), children: [
            for (final s in ItemSlot.values)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: VChip(
                  label: slotName(t, s),
                  icon: slotIcon(s),
                  active: s == _slot,
                  onTap: () => setState(() {
                    _slot = s;
                    _selectedId = null;
                  }),
                ),
              ),
          ]),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 12),
        sliver: SliverToBoxAdapter(
          child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Expanded(child: Text(slotName(t, _slot), style: VType.body(size: 16, weight: FontWeight.w800))),
            Text(t.ownedOf(ownedCount, slotItems.length), style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.ash)),
          ]),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, mainAxisExtent: 150),
          itemCount: slotItems.length,
          itemBuilder: (_, i) {
            final it = slotItems[i];
            return ItemTile(
              item: it,
              state: itemState(it, owned: owned, equipped: equipped),
              lockText: unlockText(t, it, achievements, locale),
              locale: locale,
              selected: it.id == _selectedId,
              onTap: () => setState(() => _selectedId = _selectedId == it.id ? null : it.id),
            );
          },
        ),
      ),
    ]);
  }
}

// ---------------------------------------------------------------- Heldenweg
class _Path extends ConsumerWidget {
  const _Path({required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final levels = (ref.watch(levelsProvider).valueOrNull ?? const <Level>[]).toList()..sort((a, b) => a.level.compareTo(b.level));
    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    final form = profile.heroForm;
    if (levels.isEmpty) return SliverToBoxAdapter(child: vLoading());
    final max = levels.last.xpThreshold;
    final cur = levels.where((l) => l.level == profile.level).firstOrNull;
    final nxt = levels.where((l) => l.level == profile.level + 1).firstOrNull;
    final inLevel = nxt == null ? 1.0 : (profile.xp - (cur?.xpThreshold ?? 0)) / (nxt.xpThreshold - (cur?.xpThreshold ?? 0));

    Widget chip(String text) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: VColors.bg.withValues(alpha: .7), borderRadius: BorderRadius.circular(99), border: Border.all(color: VColors.border)),
          child: Text(text, style: VType.body(size: 11, weight: FontWeight.w800, color: const Color(0xFFCDBFA8))),
        );

    final rows = <Widget>[];
    for (final l in levels) {
      final n = l.level;
      final c = VColors.level(n);
      final unlocks = items.where((i) => i.source == ItemSource.level && i.unlockLevel == n).map((i) => i.name(locale)).toList();
      final mult = multiplierText(l.coinMultiplier, locale);
      Widget node;
      Widget card;
      if (n < profile.level) {
        node = Container(width: 32, height: 32, decoration: const BoxDecoration(color: VColors.moss, shape: BoxShape.circle), child: const Center(child: VIcon(VIcons.check, size: 16, color: Color(0xFF101A0B), stroke: 2.8)));
        card = VCard(
          color: const Color(0xFF161110),
          padding: const EdgeInsets.fromLTRB(10, 10, 14, 10),
          child: Row(children: [
            ClipRRect(borderRadius: BorderRadius.circular(10), child: _thumb(n, form, 46, 58)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(l.nameFor(form), style: VType.cinzel(size: 16)),
                Text('${t.fromXp(vNum(l.xpThreshold))} · ${t.coinBonus(mult)}', style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
              ]),
            ),
            Text(romanLevel(n), style: VType.cinzel(size: 13, color: c)),
          ]),
        );
      } else if (n == profile.level) {
        node = Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: const Color(0xFF241A12), shape: BoxShape.circle, border: Border.all(color: c, width: 2), boxShadow: [BoxShadow(color: c.withValues(alpha: .55), blurRadius: 18)]),
          child: Center(child: Text(romanLevel(n), style: VType.cinzel(size: 13, color: c))),
        );
        card = Container(
          height: 250,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFF141A1F), borderRadius: BorderRadius.circular(18), border: Border.all(color: c, width: 1.5), boxShadow: [BoxShadow(color: c.withValues(alpha: .2), blurRadius: 24)]),
          child: Stack(children: [
            Positioned(right: 0, top: 0, bottom: 0, width: 150, child: _thumb(n, form, 150, 250)),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF11161A), Color(0xFF11161A), Color(0x3311161A), Color(0x0011161A)], stops: [0, .45, .8, 1])),
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              right: 110,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                VStatusPill(label: t.yourLevel.toUpperCase(), color: c),
                const SizedBox(height: 8),
                Text(l.nameFor(form), style: VType.cinzel(size: 24)),
                const SizedBox(height: 4),
                Text(l.tagline(locale), style: VType.body(size: 13, color: const Color(0xFFC9BCA8)).copyWith(fontStyle: FontStyle.italic)),
              ]),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const VGem(size: 14),
                  const SizedBox(width: 6),
                  Text(nxt == null ? t.xpLabel(profile.xp) : '${vNum(profile.xp)} / ${vNum(nxt.xpThreshold)} XP',
                      style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.frostBright, tabular: true)),
                ]),
                const SizedBox(height: 8),
                VXpBar(progress: inLevel, height: 9),
                const SizedBox(height: 8),
                Wrap(spacing: 6, runSpacing: 6, children: [chip(t.coinBonus(mult)), for (final u in unlocks) chip(u)]),
              ]),
            ),
          ]),
        );
      } else {
        final isNext = n == profile.level + 1;
        final last = n == 8;
        node = Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: const Color(0xFF171210), shape: BoxShape.circle, border: Border.all(color: isNext ? c : const Color(0xFF4A3E34), width: 1.5)),
          child: Center(child: Text(romanLevel(n), style: VType.cinzel(size: n < 7 ? 11 : 9, color: isNext ? c : const Color(0xFF7D7265)))),
        );
        card = Container(
          height: last ? 232 : 140,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: const Color(0xFF141010),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: last ? const Color(0x80F4E6BD) : (isNext ? c.withValues(alpha: .55) : VColors.border)),
            boxShadow: last ? [const BoxShadow(color: Color(0x2EF4E6BD), blurRadius: 30)] : null,
          ),
          child: Stack(children: [
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              width: last ? 150 : 120,
              child: ColorFiltered(
                colorFilter: isNext || last ? const ColorFilter.mode(Colors.transparent, BlendMode.dst) : const ColorFilter.matrix([.6, .2, .1, 0, 0, .15, .6, .1, 0, 0, .1, .15, .55, 0, 0, 0, 0, 0, 1, 0]),
                child: _thumb(n, form, last ? 150 : 120, last ? 232 : 140),
              ),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF141010), Color(0xFF141010), Color(0x1A141010)], stops: [0, .5, .85])),
              ),
            ),
            Positioned(
              left: 16,
              top: 14,
              right: 110,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Flexible(child: Text(l.nameFor(form), overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 19, color: isNext || last ? VColors.bone : const Color(0xFFCFC2AE)))),
                  if (isNext) ...[const SizedBox(width: 8), Text(t.nextUp.toUpperCase(), style: VType.body(size: 10.5, weight: FontWeight.w800, color: c, spacing: .6))],
                ]),
                const SizedBox(height: 4),
                Text(
                  isNext ? t.xpLeft(vNum(l.xpThreshold - profile.xp)) : t.fromXp(vNum(l.xpThreshold)),
                  style: VType.body(size: 12.5, weight: FontWeight.w700, color: isNext ? VColors.frostBright : VColors.ash, tabular: true),
                ),
                const SizedBox(height: 8),
                Wrap(spacing: 5, runSpacing: 5, children: [chip(t.coinBonus(mult)), for (final u in unlocks) chip(u), if (last) chip(t.alleyTitle)]),
              ]),
            ),
          ]),
        );
      }
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [SizedBox(width: 38, child: Center(child: node)), const SizedBox(width: 10), Expanded(child: card)]),
      ));
    }

    final segs = [
      for (final l in levels)
        Expanded(
          child: Container(
            height: 6,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: l.level < profile.level ? VColors.moss : (l.level == profile.level ? null : const Color(0xFF2A2420)),
              gradient: l.level == profile.level
                  ? LinearGradient(colors: const [VColors.frost, VColors.frost, Color(0xFF2A2420), Color(0xFF2A2420)], stops: [0, inLevel, inLevel, 1])
                  : null,
            ),
          ),
        ),
    ];

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList.list(children: [
        VCard(
          child: Column(children: [
            Row(children: [
              VLevelBadge(level: profile.level, size: 48),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.levelOfEight(romanLevel(profile.level)), style: VType.cinzel(size: 18)),
                  Text(t.xpToValhalla(vNum(profile.xp), vNum(max)), style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                ]),
              ),
            ]),
            const SizedBox(height: 14),
            Row(children: segs),
          ]),
        ),
        const SizedBox(height: 18),
        ...rows,
      ]),
    );
  }

  static Widget _thumb(int level, HeroForm form, double w, double h) => SizedBox(
        width: w,
        height: h,
        child: Stack(fit: StackFit.expand, children: [
          VArt.image(VArt.stage(level)),
          Padding(padding: EdgeInsets.only(top: h * .06), child: VArt.image(VArt.hero(level, form), fit: BoxFit.fitHeight, alignment: Alignment.topCenter)),
        ]),
      );
}

// ---------------------------------------------------------------- Erfolge
class _Achievements extends ConsumerWidget {
  const _Achievements({required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final all = ref.watch(achievementsProvider).valueOrNull ?? const <Achievement>[];
    final mine = (ref.watch(myAchievementsProvider).valueOrNull ?? const <UserAchievement>[]).map((a) => a.achievementKey).toSet();
    final vouchers = ref.watch(myVouchersProvider).valueOrNull ?? const <Voucher>[];
    final ownedItems = ref.watch(myItemsProvider).valueOrNull ?? const <UserItem>[];
    final redeemed = vouchers.where((v) => v.status == VoucherStatus.redeemed).length;

    // Closest locked achievement with measurable progress.
    (Achievement, int, int)? almost;
    for (final a in all.where((a) => !mine.contains(a.key) && !a.key.startsWith('level_'))) {
      final p = achievementProgress(a.key, profile);
      if (p == null || p.$2 == 0) continue;
      if (almost == null || p.$1 / p.$2 > almost.$2 / almost.$3) almost = (a, p.$1, p.$2);
    }

    Widget stat(String v, String l, VIcons icon, Color c) => VCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(children: [
            VIcon(icon, size: 22, color: c, stroke: 1.8),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(v, style: VType.cinzel(size: 19, height: 1.1)),
                Text(l, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 12, weight: FontWeight.w700, color: VColors.ash)),
              ]),
            ),
          ]),
        );

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList.list(children: [
        Row(children: [
          Expanded(child: stat(vNum(profile.visitCount), t.statVisits, VIcons.seal, const Color(0xFFD6CAB4))),
          const SizedBox(width: 10),
          Expanded(child: stat(t.weeksCount(profile.currentStreakWeeks), t.longestStreak(profile.longestStreakWeeks), VIcons.ship, VColors.goldBright)),
        ]),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(child: stat('$redeemed', t.rewardsRedeemed, VIcons.beute, VColors.goldBright)),
          const SizedBox(width: 10),
          Expanded(child: stat('${ownedItems.length}', t.itemsOwned, VIcons.held, VColors.frostBright)),
        ]),
        const SizedBox(height: 16),
        VOrnateCard(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            Row(children: [
              Expanded(child: Text(t.achievementsUnlocked(mine.length, all.length), style: VType.cinzel(size: 17))),
              Text(all.isEmpty ? '' : '${(mine.length * 100 / all.length).round()} %', style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.ash)),
            ]),
            const SizedBox(height: 10),
            VGoldBar(progress: all.isEmpty ? 0 : mine.length / all.length, height: 7),
            if (almost != null) ...[
              const SizedBox(height: 14),
              Row(children: [
                VMedal(tier: medalTier(almost.$1), icon: achievementVIcon(almost.$1.icon), size: 40, locked: true),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.almostThere(almost.$1.name(locale)), style: VType.body(size: 14, weight: FontWeight.w800)),
                    Text('${almost.$2} / ${almost.$3} · ${almost.$1.description(locale)}',
                        maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                  ]),
                ),
              ]),
            ],
          ]),
        ),
        const SizedBox(height: 22),
        VSectionHeader(t.achievements, padding: EdgeInsets.zero),
        const SizedBox(height: 16),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, mainAxisSpacing: 18, crossAxisSpacing: 6, mainAxisExtent: 124),
          itemCount: all.length,
          itemBuilder: (_, i) {
            final a = all[i];
            final got = mine.contains(a.key);
            final p = achievementProgress(a.key, profile);
            return Semantics(
              label: '${a.name(locale)}: ${a.description(locale)}',
              child: GestureDetector(
                onTap: () => showSnack(context, '${a.name(locale)} – ${a.description(locale)} (+${a.xpReward} XP${a.coinReward > 0 ? ', +${a.coinReward}' : ''})'),
                child: Column(children: [
                  VMedal(tier: medalTier(a), icon: achievementVIcon(a.icon), size: 62, locked: !got),
                  const SizedBox(height: 7),
                  Builder(builder: (_) {
                    final name = a.name(locale);
                    final style = VType.body(size: 11.5, weight: FontWeight.w800, height: 1.2, color: got ? VColors.bone : const Color(0xFFA89C8B));
                    if (name.split(' ').any((w) => w.length > 11)) {
                      return FittedBox(fit: BoxFit.scaleDown, child: Text(name, maxLines: 1, style: style));
                    }
                    return Text(name, maxLines: 2, textAlign: TextAlign.center, overflow: TextOverflow.ellipsis, style: style);
                  }),
                  const SizedBox(height: 2),
                  Text(
                    got ? t.reached : (p == null ? '' : '${p.$1.clamp(0, p.$2)}/${p.$2}'),
                    style: VType.body(size: 11, weight: FontWeight.w800, color: got ? VColors.moss : VColors.ash, tabular: true),
                  ),
                ]),
              ),
            );
          },
        ),
      ]),
    );
  }
}
