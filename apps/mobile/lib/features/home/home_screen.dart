import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import '../claim/claim_sheet.dart';

/// Halle: the guest's hero on their level backdrop, the next goal, and what
/// is happening in the hall.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final profile = ref.watch(profileProvider).valueOrNull;
    final levels = ref.watch(levelMapProvider);
    final economy = ref.watch(economyProvider).valueOrNull;
    final equipped = ref.watch(myEquippedAssetsProvider);
    final unread = ref.watch(unreadCountProvider);
    if (profile == null) return const SizedBox.shrink();

    final form = profile.heroForm;
    final level = levels[profile.level];
    final next = levels[profile.level + 1];
    final from = level?.xpThreshold ?? 0;
    final progress = next == null ? 1.0 : (profile.xp - from) / (next.xpThreshold - from);
    final onBoardDays = economy?.onboardWindowDays ?? 30;
    final onBoard = isOnBoard(profile.lastVisitAt, onBoardDays);
    final daysLeftOnBoard = profile.lastVisitAt == null ? 0 : math.max(0, onBoardDays - DateTime.now().difference(profile.lastVisitAt!).inDays);
    final hour = DateTime.now().hour;
    final greet = hour < 11 ? t.greetMorning(profile.nickname) : hour < 18 ? t.greetDay(profile.nickname) : t.greetEvening(profile.nickname);
    final xpPerVisit = economy?.xpPerVisit ?? 50;

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        child: RefreshIndicator(
          color: VColors.gold,
          backgroundColor: VColors.surface2,
          onRefresh: () async {
            invalidateUserData(ref);
            ref.invalidate(feedProvider);
          },
          child: CustomScrollView(slivers: [
            SliverToBoxAdapter(
              child: SizedBox(
                height: 620,
                child: Stack(children: [
                  Positioned.fill(
                    child: VHeroStage(level: profile.level, form: form, height: 620, heroHeight: 392, heroTop: 84, companion: equipped[ItemSlot.companion]),
                  ),
                  Positioned(
                    left: 110,
                    right: 110,
                    top: 110,
                    height: 350,
                    child: Semantics(
                      button: true,
                      label: t.customizeHero,
                      child: GestureDetector(behavior: HitTestBehavior.opaque, onTap: () => context.go('/hero')),
                    ),
                  ),
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 4, 8, 0),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const SizedBox(height: 6),
                          Text('VALHALLA', style: VType.cinzel(size: 17, color: const Color(0xFFE8C27A), spacing: 3.4)),
                          const SizedBox(height: 3),
                          Text(greet.toUpperCase(), style: VType.body(size: 10.5, weight: FontWeight.w800, color: VColors.ash, spacing: 1.4)),
                        ]),
                        const Spacer(),
                        VCoinPill(amount: profile.coinBalance, onTap: () => context.push('/coins')),
                        VRoundButton(icon: VIcons.horn, tooltip: t.notifications, dot: unread > 0, onTap: () => context.push('/notifications')),
                      ]),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 18,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        VLevelBadge(level: profile.level, size: 44),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(levelName(levels, profile.level, form).toUpperCase(), style: VType.cinzel(size: 25, spacing: 2, height: 1.05)),
                            const SizedBox(height: 3),
                            Text('${profile.nickname} · ${t.levelOfTotal(profile.level)}', style: VType.body(size: 13, weight: FontWeight.w600, color: VColors.ash)),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/hero?seg=1'),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(children: [
                              Text(t.heroPath, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.gold)),
                              const VIcon(VIcons.chevRight, size: 16, color: VColors.gold, stroke: 2),
                            ]),
                          ),
                        ),
                      ]),
                      const SizedBox(height: 14),
                      Row(children: [
                        const VGem(size: 16),
                        const SizedBox(width: 7),
                        Text(t.xpLabel(profile.xp), style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.frostBright, tabular: true)),
                        const Spacer(),
                        if (next != null)
                          Text('${vNum(next.xpThreshold)} · ${next.nameFor(form)}', style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.ash, tabular: true)),
                      ]),
                      const SizedBox(height: 8),
                      VXpBar(progress: progress),
                      const SizedBox(height: 6),
                      Text(
                        next == null
                            ? t.maxLevelReached
                            : t.nextLevelHint(next.xpThreshold - profile.xp, math.max(1, ((next.xpThreshold - profile.xp) / xpPerVisit).ceil()), next.nameFor(form)),
                        style: VType.body(size: 13, weight: FontWeight.w600, color: const Color(0xFFD6CAB4)),
                      ),
                    ]),
                  ),
                ]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              sliver: SliverToBoxAdapter(
                child: Row(children: [
                  Expanded(child: VStatTile(icon: VIcons.ship, color: VColors.goldBright, value: t.weeksCount(profile.currentStreakWeeks), label: t.statStreak)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: VStatTile(
                      icon: VIcons.anchor,
                      color: onBoard ? VColors.moss : VColors.ash,
                      value: onBoard ? t.daysCount(daysLeftOnBoard) : '—',
                      label: t.statOnBoard,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: VStatTile(icon: VIcons.seal, color: const Color(0xFFD6CAB4), value: vNum(profile.visitCount), label: t.statVisits)),
                ]),
              ),
            ),
            const SliverToBoxAdapter(child: _PendingClaimBanner()),
            SliverPadding(padding: const EdgeInsets.fromLTRB(20, 20, 20, 0), sliver: SliverToBoxAdapter(child: _GoalCard(profile: profile))),
            const SliverToBoxAdapter(child: _Events()),
            const SliverToBoxAdapter(child: _Saga()),
            if (!onBoard && economy != null)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(28, 18, 28, 0),
                sliver: SliverToBoxAdapter(child: Text(t.onBoardHint(onBoardDays), textAlign: TextAlign.center, style: VType.body(size: 12.5, color: VColors.ash))),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(28, 18, 28, kTabBarSpace),
              sliver: SliverToBoxAdapter(child: Text(t.responsibleDrinking, textAlign: TextAlign.center, style: VType.body(size: 11.5, color: VColors.ash2))),
            ),
          ]),
        ),
      ),
    );
  }
}

class _PendingClaimBanner extends ConsumerWidget {
  const _PendingClaimBanner();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final pending = (ref.watch(myClaimsProvider).valueOrNull ?? const <VisitClaim>[]).where((c) => c.status == ClaimStatus.pending).firstOrNull;
    if (pending == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
      child: VCard(
        onTap: () => context.push('/claim/${pending.id}'),
        borderColor: VColors.gold.withValues(alpha: .45),
        padding: const EdgeInsets.all(14),
        child: Row(children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: VColors.gold, width: 2), boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .35), blurRadius: 12)]),
            child: const Center(child: VIcon(VIcons.hourglass, size: 20, color: VColors.goldBright)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.pendingClaimTitle, style: VType.body(size: 15, weight: FontWeight.w800)),
              Text(t.pendingClaimBody(claimCode(pending.id)), style: VType.body(size: 13, color: VColors.ash, weight: FontWeight.w600)),
            ]),
          ),
          const VIcon(VIcons.chevRight, size: 18, color: VColors.ash2, stroke: 2),
        ]),
      ),
    );
  }
}

/// "Dein nächstes Ziel": weekly streak first, then the next level.
class _GoalCard extends ConsumerWidget {
  const _GoalCard({required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final levels = ref.watch(levelMapProvider);
    final economy = ref.watch(economyProvider).valueOrNull;
    final achievements = ref.watch(achievementsProvider).valueOrNull ?? const <Achievement>[];
    final mine = (ref.watch(myAchievementsProvider).valueOrNull ?? const <UserAchievement>[]).map((a) => a.achievementKey).toSet();
    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    final form = profile.heroForm;

    final now = DateTime.now();
    final thisWeek = weekStart(now);
    final lastWeek = profile.lastVisitAt == null ? null : weekStart(profile.lastVisitAt!);
    final visitedThisWeek = lastWeek == thisWeek;
    final streakAlive = lastWeek != null && thisWeek.difference(lastWeek).inDays == 7;
    final daysLeft = 8 - now.weekday;
    final next = levels[profile.level + 1];
    final xpPerVisit = economy?.xpPerVisit ?? 50;
    final bonusXp = streakAlive ? (economy?.streakBonusXp ?? 25) * math.min(profile.currentStreakWeeks + 1, 4) : 0;
    final targetWeeks = profile.currentStreakWeeks + 1;

    String title;
    String body;
    if (visitedThisWeek) {
      title = t.goalDoneTitle;
      body = next == null ? t.goalMaxBody : t.goalDoneBody(next.nameFor(form));
    } else if (streakAlive) {
      title = t.goalStreakTitle(targetWeeks);
      body = next != null && xpPerVisit + bonusXp >= next.xpThreshold - profile.xp ? t.goalStreakLevelBody(next.nameFor(form)) : t.goalStreakBody;
    } else {
      title = t.goalStartTitle;
      body = t.goalStartBody;
    }

    // Achievement that the next streak week would unlock (e.g. "An Bord" at 4).
    final streakAch = streakAlive && !visitedThisWeek
        ? achievements.where((a) => a.key == 'streak_${targetWeeks}w' && !mine.contains(a.key)).firstOrNull
        : null;
    final streakItem = streakAch == null ? null : items.where((i) => i.unlockAchievementKey == streakAch.key).firstOrNull;

    final stones = <Widget>[];
    for (var i = 3; i >= 0; i--) {
      final week = thisWeek.subtract(Duration(days: 7 * i));
      final isThis = i == 0;
      final lit = isThis ? visitedThisWeek : (streakAlive || visitedThisWeek) && i <= profile.currentStreakWeeks - (visitedThisWeek ? 1 : 0);
      stones.add(_Stone(lit: lit, current: isThis && !visitedThisWeek, label: isThis ? t.thisWeek : t.weekShort(isoWeek(week))));
      if (i > 0) {
        stones.add(Expanded(
          child: Container(
            height: 2,
            margin: const EdgeInsets.only(top: 21),
            color: lit ? VColors.gold.withValues(alpha: .7) : VColors.border,
          ),
        ));
      }
    }

    return VOrnateCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: VEyebrow(t.nextGoal, color: VColors.gold, size: 11.5)),
          if (!visitedThisWeek) VStatusPill(label: t.daysLeft(daysLeft), color: VColors.amber, icon: VIcons.clock),
        ]),
        const SizedBox(height: 10),
        Text(title, style: VType.cinzel(size: 21)),
        const SizedBox(height: 4),
        Text(body, style: VType.body(size: 14, color: VColors.ash, height: 1.45)),
        const SizedBox(height: 16),
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: stones),
        if (!visitedThisWeek && (bonusXp > 0 || streakAch != null)) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(color: VColors.bg.withValues(alpha: .55), borderRadius: BorderRadius.circular(12), border: Border.all(color: const Color(0xCC3A302A))),
            child: Row(children: [
              Text(t.rewardLabel, style: VType.body(size: 12, weight: FontWeight.w700, color: VColors.ash)),
              const Spacer(),
              if (streakItem != null) ...[
                VItemArt(assetKey: streakItem.assetKey, slot: streakItem.slot, size: 26),
                const SizedBox(width: 4),
                Flexible(child: Text(streakItem.name(locale), overflow: TextOverflow.ellipsis, style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.rarity(streakItem.rarity)))),
                Container(width: 1, height: 16, margin: const EdgeInsets.symmetric(horizontal: 8), color: VColors.border),
              ],
              const VGem(size: 14),
              const SizedBox(width: 4),
              Text('+${bonusXp + (streakAch?.xpReward ?? 0)}', style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.frostBright)),
              if ((streakAch?.coinReward ?? 0) > 0) ...[
                const SizedBox(width: 8),
                const VCoin(size: 14),
                const SizedBox(width: 4),
                Text('+${streakAch!.coinReward}', style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.goldBright)),
              ],
            ]),
          ),
        ],
        const SizedBox(height: 16),
        VPrimaryButton(label: t.claimVisit, icon: VIcons.seal, onPressed: () => openClaimSheet(context)),
      ]),
    );
  }
}

class _Stone extends StatelessWidget {
  const _Stone({required this.lit, required this.current, required this.label});
  final bool lit;
  final bool current;
  final String label;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 70,
        child: Column(children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: lit ? const RadialGradient(center: Alignment(0, -.3), colors: [Color(0xFF4A3620), Color(0xFF231910)]) : null,
              color: lit ? null : (current ? VColors.gold.withValues(alpha: .06) : const Color(0xFF171210)),
              border: Border.all(color: lit ? VColors.gold : (current ? VColors.gold : VColors.border), width: 1.5),
              boxShadow: lit ? [BoxShadow(color: VColors.gold.withValues(alpha: .35), blurRadius: 14)] : null,
            ),
            child: Center(
              child: current
                  ? const VIcon(VIcons.plus, size: 20, color: VColors.gold, stroke: 2)
                  : VIcon(VIcons.ship, size: 22, color: lit ? VColors.goldBright : const Color(0xFF5E554B), stroke: 1.8),
            ),
          ),
          const SizedBox(height: 6),
          FittedBox(fit: BoxFit.scaleDown, child: Text(label, maxLines: 1, style: VType.body(size: 11, weight: current ? FontWeight.w800 : FontWeight.w700, color: current ? VColors.goldBright : VColors.ash))),
        ]),
      );
}

class _Events extends ConsumerWidget {
  const _Events();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final posts = ref.watch(feedProvider).valueOrNull ?? const <Post>[];
    final likes = ref.watch(myLikesProvider).valueOrNull ?? const <String>{};
    final now = DateTime.now().subtract(const Duration(hours: 6));
    final events = posts.where((p) => p.type == PostType.event && p.startsAt != null && p.startsAt!.isAfter(now)).toList()..sort((a, b) => a.startsAt!.compareTo(b.startsAt!));
    if (events.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        VSectionHeader(t.upcomingEvents),
        const SizedBox(height: 12),
        SizedBox(
          height: 222,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: events.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (_, i) => EventCard(post: events[i], index: i, liked: likes.contains(events[i].id)),
          ),
        ),
      ]),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.post, required this.index, this.liked = false, this.width = 272});
  final Post post;
  final int index;
  final bool liked;
  final double width;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final s = post.startsAt!.toLocal();
    final month = MaterialLocalizations.of(context).formatMonthYear(s).split(' ').first.substring(0, 3).toUpperCase();
    final time = '${s.hour.toString().padLeft(2, '0')}:${s.minute.toString().padLeft(2, '0')}';
    return Semantics(
      button: true,
      label: post.title,
      child: GestureDetector(
        onTap: () => context.push('/post/${post.id}'),
        child: Container(
          width: width,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFF171210), borderRadius: BorderRadius.circular(18), border: Border.all(color: VColors.border)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 124,
              child: Stack(fit: StackFit.expand, children: [
                PostImage(post: post, index: index),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x000E0B09), Color(0xFF171210)], stops: [.4, 1]),
                  ),
                ),
                Positioned(left: 12, top: 12, child: DateBadge(day: dayAbbrev(t, s.weekday), date: '${s.day}'.padLeft(2, '0'), month: month)),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 4, 14, 12),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                SizedBox(height: 44, child: Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 16, height: 1.25))),
                const SizedBox(height: 6),
                Row(children: [
                  const VIcon(VIcons.clock, size: 15, color: VColors.ash, stroke: 1.8),
                  const SizedBox(width: 6),
                  Text('${dayAbbrev(t, s.weekday)} · $time', style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                  const Spacer(),
                  VIcon(VIcons.heart, size: 15, color: liked ? VColors.gold : VColors.ash, stroke: 1.8),
                  const SizedBox(width: 5),
                  Text('${post.likeCount}', style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.ash)),
                ]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class DateBadge extends StatelessWidget {
  const DateBadge({super.key, required this.day, required this.date, required this.month, this.large = false});
  final String day;
  final String date;
  final String month;
  final bool large;
  @override
  Widget build(BuildContext context) => Container(
        width: large ? 64 : 48,
        padding: EdgeInsets.symmetric(vertical: large ? 10 : 6),
        decoration: BoxDecoration(color: VColors.bg.withValues(alpha: .85), borderRadius: BorderRadius.circular(large ? 14 : 12), border: Border.all(color: VColors.ornament.withValues(alpha: .6))),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(day, style: VType.body(size: large ? 11 : 10, weight: FontWeight.w800, color: VColors.gold, spacing: .8)),
          Text(date, style: VType.cinzel(size: large ? 28 : 20, height: 1.15)),
          Text(month, style: VType.body(size: large ? 11 : 10, weight: FontWeight.w800, color: VColors.ash, spacing: .8)),
        ]),
      );
}

/// Post image, or a scene from the art kit when none is set.
class PostImage extends StatelessWidget {
  const PostImage({super.key, required this.post, this.index = 0});
  final Post post;
  final int index;
  @override
  Widget build(BuildContext context) {
    const scenes = ['hall', 'fjord', 'aurora', 'raven'];
    final fallback = VArt.image(VArt.scene(scenes[(post.id.hashCode.abs() + index) % scenes.length]));
    final url = post.imageUrl;
    if (url == null || !url.startsWith('http')) return fallback;
    return Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => fallback);
  }
}

class _Saga extends ConsumerWidget {
  const _Saga();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final news = (ref.watch(feedProvider).valueOrNull ?? const <Post>[]).where((p) => p.type == PostType.news).take(3).toList();
    if (news.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Column(children: [
        VSectionHeader(t.fromSaga),
        const SizedBox(height: 12),
        for (var i = 0; i < news.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: VCard(
              onTap: () => context.push('/post/${news[i].id}'),
              padding: const EdgeInsets.all(12),
              child: Row(children: [
                ClipRRect(borderRadius: BorderRadius.circular(12), child: SizedBox(width: 52, height: 52, child: PostImage(post: news[i], index: i + 1))),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(news[i].title, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.body(size: 15, weight: FontWeight.w700, height: 1.3)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Text(news[i].publishedAt == null ? '' : '${formatDate(news[i].publishedAt!, locale: locale)} · ', style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                      const VIcon(VIcons.heart, size: 13, color: VColors.ash, stroke: 1.9),
                      const SizedBox(width: 4),
                      Text('${news[i].likeCount}', style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                    ]),
                  ]),
                ),
                const VIcon(VIcons.chevRight, size: 18, color: VColors.ash2, stroke: 2),
              ]),
            ),
          ),
      ]),
    );
  }
}
