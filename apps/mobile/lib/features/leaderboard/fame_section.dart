import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// Ruhmeshalle as a sliver group: podium, own rank, everyone in order, and the
/// avenue of statues for those who reached level VIII.
class FameSliver extends ConsumerStatefulWidget {
  const FameSliver({super.key});
  @override
  ConsumerState<FameSliver> createState() => _FameSliverState();
}

class _FameSliverState extends ConsumerState<FameSliver> {
  bool _onBoardOnly = false;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final levels = ref.watch(levelMapProvider);
    final me = ref.watch(profileProvider).valueOrNull;
    final myRank = ref.watch(myRankProvider).valueOrNull;
    final board = ref.watch(leaderboardProvider);
    final all = board.valueOrNull ?? const <PublicProfile>[];
    final list = _onBoardOnly ? all.where((p) => p.onBoard).toList() : all;
    final top = list.take(3).toList();
    final rest = list.skip(3).toList();
    final immortals = all.where((p) => p.level >= 8).toList();
    final above = myRank == null ? null : all.where((p) => p.rank == myRank.rank - 1).firstOrNull;

    return SliverMainAxisGroup(slivers: [
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: VSegmented(labels: [t.allHeroes, t.onBoard], index: _onBoardOnly ? 1 : 0, onChanged: (i) => setState(() => _onBoardOnly = i == 1)),
        ),
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 450,
          child: Stack(children: [
            Positioned.fill(child: Opacity(opacity: .5, child: VArt.image(VArt.scene('hall')))),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [VColors.bg, Color(0x590E0B09), Color(0x990E0B09), VColors.bg],
                    stops: [0, .25, .7, 1],
                  ),
                ),
              ),
            ),
            const Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: RadialGradient(center: Alignment(0, .1), radius: .7, colors: [Color(0x2EE3A645), Color(0x00E3A645)])),
              ),
            ),
            const Positioned.fill(child: VEmbers(opacity: .6)),
            if (board.isLoading && all.isEmpty) Positioned.fill(child: vLoading()),
            if (top.length > 1) _PodiumHero(p: top[1], place: 2, levels: levels, cx: -115, dy: -120),
            if (top.length > 2) _PodiumHero(p: top[2], place: 3, levels: levels, cx: 115, dy: -120),
            if (top.isNotEmpty) _PodiumHero(p: top[0], place: 1, levels: levels, cx: 0, dy: -120),
          ]),
        ),
      ),
      if (me != null && !me.leaderboardVisible)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          sliver: SliverToBoxAdapter(child: Text(t.leaderboardHidden, style: VType.body(size: 12.5, color: VColors.ash))),
        ),
      if (myRank != null && myRank.rank > 3)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
          sliver: SliverToBoxAdapter(
            child: VCard(
              borderColor: VColors.gold.withValues(alpha: .55),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(children: [
                SizedBox(width: 30, child: Text('${myRank.rank}', textAlign: TextAlign.center, style: VType.cinzel(size: 20, color: VColors.goldBright))),
                const SizedBox(width: 8),
                VPortrait(level: myRank.level, form: myRank.heroForm, size: 36),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.yourPosition, style: VType.body(size: 14.5, weight: FontWeight.w800)),
                    if (above != null)
                      Row(children: [
                        const VIcon(VIcons.arrowUp, size: 14, color: VColors.frostBright, stroke: 2.2),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(t.xpToRank(vNum(above.xp - myRank.xp + 1), above.rank),
                              overflow: TextOverflow.ellipsis, style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.frostBright)),
                        ),
                      ]),
                  ]),
                ),
                Text(vNum(myRank.xp), style: VType.body(size: 16, weight: FontWeight.w800, tabular: true)),
              ]),
            ),
          ),
        ),
      SliverPadding(
        padding: const EdgeInsets.fromLTRB(30, 4, 34, 6),
        sliver: SliverToBoxAdapter(
          child: Row(children: [
            Text(t.rankHeader, style: VType.body(size: 11, weight: FontWeight.w800, color: VColors.ash2, spacing: 1.2)),
            const Spacer(),
            Text('XP', style: VType.body(size: 11, weight: FontWeight.w800, color: VColors.ash2, spacing: 1.2)),
          ]),
        ),
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverList.separated(
          itemCount: rest.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (_, i) => FameRow(p: rest[i], levels: levels, me: rest[i].id == me?.id),
        ),
      ),
      SliverPadding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 10), sliver: SliverToBoxAdapter(child: VSectionHeader(t.alleyTitle))),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverToBoxAdapter(child: Text(t.alleyBody, style: VType.body(size: 13.5, color: VColors.ash, height: 1.45))),
      ),
      SliverPadding(padding: const EdgeInsets.fromLTRB(20, 14, 20, 0), sliver: SliverToBoxAdapter(child: _Alley(immortals: immortals))),
    ]);
  }
}

class _PodiumHero extends StatelessWidget {
  const _PodiumHero({required this.p, required this.place, required this.levels, required this.cx, this.dy = 0});
  final PublicProfile p;
  final int place;
  final Map<int, Level> levels;
  final double cx;
  final double dy;

  @override
  Widget build(BuildContext context) {
    final first = place == 1;
    final h = first ? 250.0 : 206.0;
    final w = h * 380 / 916;
    final plinthW = first ? 140.0 : 112.0;
    final plinthH = first ? 62.0 : 46.0;
    final top = (first ? 150.0 : 206.0) + dy;
    final metal = switch (place) { 1 => const [Color(0xFFFFE3A0), Color(0xFFC98F35)], 2 => const [Color(0xFFF2F0EA), Color(0xFF9C9A94)], _ => const [Color(0xFFF2C08F), Color(0xFFB06C3C)] };
    return Positioned(
      left: 0,
      right: 0,
      top: top,
      child: Transform.translate(
        offset: Offset(cx, 0),
        child: Center(
          child: GestureDetector(
            onTap: () => context.push('/player/${p.id}'),
            child: SizedBox(
              width: plinthW + 20,
              child: Column(children: [
                if (first) const Padding(padding: EdgeInsets.only(bottom: 2), child: VIcon(VIcons.crown, size: 26, color: VColors.goldBright, stroke: 1.8)),
                SizedBox(width: w, height: h, child: VArt.image(VArt.hero(p.level, p.heroForm), fit: BoxFit.contain)),
                Transform.translate(
                  offset: const Offset(0, -10),
                  child: Container(
                    width: plinthW,
                    height: plinthH,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(6), bottom: Radius.circular(2)),
                      gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF4A3F36), Color(0xFF2A231E), Color(0xFF1C1714)], stops: [0, .18, 1]),
                      boxShadow: const [BoxShadow(color: Color(0x99000000), blurRadius: 24, offset: Offset(0, 12))],
                      border: const Border(top: BorderSide(color: Color(0x40FFEBC8))),
                    ),
                    child: Center(
                      child: ShaderMask(
                        shaderCallback: (r) => LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: metal).createShader(r),
                        child: Text(romanLevel(place), style: VType.cinzel(size: first ? 26 : 20, weight: FontWeight.w800, color: Colors.white)),
                      ),
                    ),
                  ),
                ),
                Text(p.nickname, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 14.5, weight: FontWeight.w800)),
                Row(mainAxisSize: MainAxisSize.min, children: [
                  const VGem(size: 12),
                  const SizedBox(width: 4),
                  Text(vNum(p.xp), style: VType.body(size: 12, weight: FontWeight.w800, color: VColors.frostBright, tabular: true)),
                ]),
                Text('${romanLevel(p.level)} · ${levelName(levels, p.level, p.heroForm).toUpperCase()}',
                    maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 10.5, color: VColors.level(p.level), spacing: 1)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}

class FameRow extends StatelessWidget {
  const FameRow({super.key, required this.p, required this.levels, this.me = false});
  final PublicProfile p;
  final Map<int, Level> levels;
  final bool me;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return Semantics(
      button: true,
      label: '${p.rank}. ${p.nickname}, ${p.xp} XP',
      child: GestureDetector(
        onTap: () => context.push('/player/${p.id}'),
        child: Container(
          height: 64,
          padding: const EdgeInsets.fromLTRB(10, 0, 14, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: me
                ? LinearGradient(colors: [VColors.gold.withValues(alpha: .14), VColors.gold.withValues(alpha: .04)])
                : const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1C1511), Color(0xFF161110)]),
            border: Border.all(color: me ? VColors.gold : VColors.border, width: me ? 1.5 : 1),
          ),
          child: Row(children: [
            SizedBox(width: 28, child: Text('${p.rank}', textAlign: TextAlign.center, style: VType.cinzel(size: 16, color: me ? VColors.goldBright : VColors.ash))),
            const SizedBox(width: 8),
            VPortrait(level: p.level, form: p.heroForm, size: 40),
            const SizedBox(width: 10),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Flexible(child: Text(p.nickname, overflow: TextOverflow.ellipsis, style: VType.body(size: 15, weight: FontWeight.w800))),
                  if (me) ...[
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(color: VColors.gold, borderRadius: BorderRadius.circular(5)),
                      child: Text(t.leaderboardYou.toUpperCase(), style: VType.body(size: 10, weight: FontWeight.w800, color: VColors.onGold)),
                    ),
                  ],
                ]),
                Text('${romanLevel(p.level)} · ${levelName(levels, p.level, p.heroForm).toUpperCase()}', style: VType.cinzel(size: 10.5, color: VColors.level(p.level), spacing: 1)),
              ]),
            ),
            if (p.onBoard) const VIcon(VIcons.anchor, size: 16, color: VColors.moss, stroke: 1.9) else const SizedBox(width: 16),
            SizedBox(width: 64, child: Text(vNum(p.xp), textAlign: TextAlign.right, style: VType.body(size: 15, weight: FontWeight.w800, tabular: true))),
          ]),
        ),
      ),
    );
  }
}

class _Alley extends StatelessWidget {
  const _Alley({required this.immortals});
  final List<PublicProfile> immortals;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final slots = <PublicProfile?>[...immortals.take(3), for (var i = immortals.length; i < 3; i++) null];
    Widget statue(PublicProfile? p, HeroForm fallback) {
      final filled = p != null;
      final img = VArt.image(VArt.hero(8, p?.heroForm ?? fallback), width: 76, height: 184, fit: BoxFit.contain);
      return Expanded(
        child: GestureDetector(
          onTap: filled ? () => context.push('/player/${p.id}') : null,
          child: Column(children: [
            filled
                ? img
                : Opacity(
                    opacity: .35,
                    child: ColorFiltered(colorFilter: const ColorFilter.matrix([.25, .5, .1, 0, -20, .25, .5, .1, 0, -20, .25, .5, .1, 0, -20, 0, 0, 0, 1, 0]), child: img),
                  ),
            Container(
              width: 88,
              height: 30,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(5), bottom: Radius.circular(2)),
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF3A322B), Color(0xFF1C1714)]),
              ),
            ),
            const SizedBox(height: 6),
            Text(filled ? p.nickname : t.alleyFree, style: VType.body(size: 11.5, weight: FontWeight.w800, color: filled ? VColors.bone : VColors.ash)),
          ]),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0x2EF4E6BD)),
        gradient: const RadialGradient(center: Alignment(0, 1), radius: 1, colors: [Color(0x1AF4E6BD), Color(0x00F4E6BD)]),
      ),
      child: Row(children: [statue(slots[0], HeroForm.hero), statue(slots[1], HeroForm.heroine), statue(slots[2], HeroForm.hero)]),
    );
  }
}
