import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// Another guest's hero from the Hall of Fame.
class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({super.key, required this.playerId});
  final String playerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final levels = ref.watch(levelMapProvider);
    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    final p = (ref.watch(leaderboardProvider).valueOrNull ?? const <PublicProfile>[]).where((x) => x.id == playerId).firstOrNull;
    if (p == null) return VScreen(child: SafeArea(child: Column(children: [const VTopBar(back: true), Expanded(child: vLoading())])));

    final equipped = <ItemSlot, Item>{
      for (final e in p.equipped.entries)
        if (items.where((i) => i.assetKey == e.value).firstOrNull case final Item it) it.slot: it,
    };

    Widget stat(String v, String l, {Color? color}) => Expanded(
          child: VCard(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            radius: 14,
            child: Column(children: [
              FittedBox(fit: BoxFit.scaleDown, child: Text(v, maxLines: 1, style: VType.cinzel(size: 19, color: color ?? VColors.bone))),
              Text(l, style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.ash)),
            ]),
          ),
        );

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        child: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: 560,
              child: Stack(children: [
                Positioned.fill(child: VHeroStage(level: p.level, form: p.heroForm, height: 560, heroHeight: 372, heroTop: 64, companion: p.equipped['companion'])),
                SafeArea(
                  bottom: false,
                  child: Column(children: [
                    VTopBar(back: true, actions: [
                      VRoundButton(icon: VIcons.flag, tooltip: t.reportName, onTap: () => showSnack(context, t.reportThanks)),
                    ]),
                  ]),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 12,
                  child: Column(children: [
                    VStatusPill(label: t.rankInFame(p.rank), color: p.rank <= 3 ? VColors.goldBright : VColors.parchment, icon: p.rank == 1 ? VIcons.crown : VIcons.ruhm),
                    const SizedBox(height: 10),
                    Text(p.nickname, style: VType.cinzel(size: 30, height: 1)),
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      VLevelBadge(level: p.level, size: 26),
                      const SizedBox(width: 8),
                      Text(levelName(levels, p.level, p.heroForm).toUpperCase(), style: VType.cinzel(size: 13, color: VColors.level(p.level), spacing: 1.5)),
                      if (p.onBoard) ...[const SizedBox(width: 10), VStatusPill(label: t.onBoard, color: VColors.moss, icon: VIcons.anchor)],
                    ]),
                  ]),
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
            sliver: SliverToBoxAdapter(
              child: Row(children: [
                stat(vNum(p.xp), 'XP', color: VColors.frostBright),
                const SizedBox(width: 10),
                stat(vNum(p.visitCount), t.statVisits),
                const SizedBox(width: 10),
                stat(t.weeksCount(p.currentStreakWeeks), t.statStreak),
              ]),
            ),
          ),
          SliverPadding(padding: const EdgeInsets.fromLTRB(0, 28, 0, 14), sliver: SliverToBoxAdapter(child: VSectionHeader(t.gear))),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverToBoxAdapter(
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                for (final s in ItemSlot.values)
                  Column(children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF15100D),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: equipped[s] == null ? const Color(0xFF4A3E34) : VColors.rarity(equipped[s]!.rarity).withValues(alpha: .67), width: 1.5),
                      ),
                      child: Center(
                        child: equipped[s] == null
                            ? VIcon(slotIcon(s), size: 22, color: const Color(0xFF6D6358), stroke: 1.8)
                            : VItemArt(assetKey: equipped[s]!.assetKey, slot: s, size: 50),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: 64,
                      child: Text(equipped[s]?.name(locale) ?? slotName(t, s),
                          textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.body(size: 11, weight: FontWeight.w700, color: VColors.ash, height: 1.2)),
                    ),
                  ]),
              ]),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 48)),
        ]),
      ),
    );
  }
}
