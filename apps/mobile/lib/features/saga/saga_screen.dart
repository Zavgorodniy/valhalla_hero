import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import '../events/event_widgets.dart';

String timeAgo(L10n t, DateTime d, String locale) {
  final diff = DateTime.now().difference(d);
  if (diff.inMinutes < 1) return t.justNow;
  if (diff.inHours < 1) return t.agoMinutes(diff.inMinutes);
  if (diff.inHours < 24) return t.agoHours(diff.inHours);
  return formatDate(d, locale: locale);
}

/// Saga: moderated photo check-ins from the hall, plus the bar's news.
class SagaScreen extends ConsumerWidget {
  const SagaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final feed = ref.watch(checkinFeedProvider);
    final news = (ref.watch(feedProvider).valueOrNull ?? const <Post>[]).where((p) => p.type == PostType.news && p.publishedAt != null).toList();
    final items = <(DateTime, Object)>[
      for (final c in feed.valueOrNull ?? const <FeedCheckin>[]) (c.createdAt, c),
      for (final n in news) (n.publishedAt!, n),
    ]..sort((a, b) => b.$1.compareTo(a.$1));

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        glow: VColors.gold,
        child: RefreshIndicator(
          color: VColors.gold,
          onRefresh: () async {
            ref.invalidate(checkinFeedProvider);
            ref.invalidate(myCheckinsProvider);
            ref.invalidate(feedProvider);
          },
          child: CustomScrollView(slivers: [
            SliverSafeArea(bottom: false, sliver: SliverToBoxAdapter(child: VTopBar(title: t.tabSaga))),
            const SliverPadding(padding: EdgeInsets.fromLTRB(20, 8, 20, 6), sliver: SliverToBoxAdapter(child: _Composer())),
            if (feed.isLoading && items.isEmpty) SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(40), child: vLoading())),
            if (!feed.isLoading && items.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Text(t.sagaEmpty, textAlign: TextAlign.center, style: VType.body(size: 14, color: VColors.ash)),
                ),
              ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              sliver: SliverList.separated(
                itemCount: items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 16),
                itemBuilder: (_, i) => switch (items[i].$2) {
                  final FeedCheckin c => CheckinCard(checkin: c),
                  final Post p => _NewsCard(post: p),
                  _ => const SizedBox.shrink(),
                },
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: kTabBarSpace)),
          ]),
        ),
      ),
    );
  }
}

/// Entry point for a new photo, or the state of the one under review.
class _Composer extends ConsumerWidget {
  const _Composer();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final economy = ref.watch(economyProvider).valueOrNull;
    final mine = ref.watch(myCheckinsProvider).valueOrNull ?? const <Checkin>[];
    final pending = mine.where((c) => c.status == CheckinStatus.pending).firstOrNull;
    final rejected = mine.where((c) => c.status == CheckinStatus.rejected && c.reviewedAt != null && DateTime.now().difference(c.reviewedAt!).inDays < 2).firstOrNull;
    final repo = ref.read(communityRepoProvider);

    if (pending != null) {
      return VCard(
        borderColor: VColors.gold.withValues(alpha: .45),
        padding: const EdgeInsets.all(12),
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(repo.photoUrl(pending.photoPath), width: 64, height: 64, fit: BoxFit.cover, errorBuilder: (_, _, _) => const SizedBox(width: 64, height: 64)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                const VIcon(VIcons.hourglass, size: 16, color: VColors.goldBright, stroke: 1.9),
                const SizedBox(width: 6),
                Flexible(child: Text(t.checkinPendingTitle, style: VType.body(size: 15, weight: FontWeight.w800))),
              ]),
              const SizedBox(height: 3),
              Text(t.checkinPendingBody, style: VType.body(size: 12.5, color: VColors.ash, height: 1.4)),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  style: TextButton.styleFrom(padding: EdgeInsets.zero, minimumSize: const Size(0, 36)),
                  onPressed: () async {
                    await repo.withdraw(pending);
                    ref.invalidate(myCheckinsProvider);
                  },
                  child: Text(t.checkinWithdraw),
                ),
              ),
            ]),
          ),
        ]),
      );
    }

    return Column(children: [
      if (rejected != null)
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: VCard(
            borderColor: VColors.bloodText.withValues(alpha: .5),
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              const VIcon(VIcons.close, size: 20, color: VColors.bloodText, stroke: 2),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(t.checkinRejectedTitle, style: VType.body(size: 14, weight: FontWeight.w800)),
                  if (rejected.rejectReason != null) Text(rejected.rejectReason!, style: VType.body(size: 12.5, color: VColors.ash)),
                ]),
              ),
            ]),
          ),
        ),
      VOrnateCard(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: () => context.push('/checkin/new'),
          child: Row(children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(shape: BoxShape.circle, gradient: VColors.goldGradient, boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .3), blurRadius: 16)]),
              child: const Center(child: VIcon(VIcons.camera, size: 24, color: VColors.onGold, stroke: 2)),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(t.sagaComposerTitle, style: VType.cinzel(size: 18)),
                const SizedBox(height: 3),
                Text(t.sagaComposerSub(economy?.checkinXp ?? 30, economy?.checkinCoins ?? 50), style: VType.body(size: 12.5, color: VColors.ash, height: 1.35)),
              ]),
            ),
            const VIcon(VIcons.chevRight, size: 18, color: VColors.gold, stroke: 2),
          ]),
        ),
      ),
    ]);
  }
}

/// One approved photo with author and heart; double-tap likes too.
class CheckinCard extends ConsumerStatefulWidget {
  const CheckinCard({super.key, required this.checkin});
  final FeedCheckin checkin;
  @override
  ConsumerState<CheckinCard> createState() => _CheckinCardState();
}

class _CheckinCardState extends ConsumerState<CheckinCard> with SingleTickerProviderStateMixin {
  late bool _liked = widget.checkin.likedByMe;
  late int _count = widget.checkin.likeCount;
  late final AnimationController _burst = AnimationController(vsync: this, duration: const Duration(milliseconds: 650));

  @override
  void didUpdateWidget(covariant CheckinCard old) {
    super.didUpdateWidget(old);
    if (old.checkin != widget.checkin) {
      _liked = widget.checkin.likedByMe;
      _count = widget.checkin.likeCount;
    }
  }

  @override
  void dispose() {
    _burst.dispose();
    super.dispose();
  }

  Future<void> _toggle({bool onlyLike = false}) async {
    if (onlyLike && _liked) {
      _burst.forward(from: 0);
      return;
    }
    HapticFeedback.lightImpact();
    final was = _liked;
    setState(() {
      _liked = !was;
      _count += was ? -1 : 1;
    });
    if (!was) _burst.forward(from: 0);
    try {
      final now = await ref.read(communityRepoProvider).toggleLike(widget.checkin.id);
      if (now != _liked && mounted) {
        setState(() {
          _liked = now;
          _count += now ? 1 : -1;
        });
      }
    } on ApiError {
      if (mounted) {
        setState(() {
          _liked = was;
          _count += was ? 1 : -1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final levels = ref.watch(levelMapProvider);
    final c = widget.checkin;
    final url = ref.read(communityRepoProvider).photoUrl(c.photoPath);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(gradient: VColors.cardGradient, borderRadius: BorderRadius.circular(20), border: Border.all(color: VColors.border)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        GestureDetector(
          onTap: () => context.push('/player/${c.userId}'),
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 14, 10),
            child: Row(children: [
              VPortrait(level: c.level, form: c.heroForm, size: 34),
              const SizedBox(width: 10),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(c.nickname, style: VType.body(size: 14.5, weight: FontWeight.w800)),
                  Text('${romanLevel(c.level)} · ${levelName(levels, c.level, c.heroForm).toUpperCase()}', style: VType.cinzel(size: 10, color: VColors.level(c.level), spacing: 1)),
                ]),
              ),
              Text(timeAgo(t, c.createdAt, locale), style: VType.body(size: 12, weight: FontWeight.w700, color: VColors.ash)),
            ]),
          ),
        ),
        GestureDetector(
          onDoubleTap: () => _toggle(onlyLike: true),
          child: AspectRatio(
            aspectRatio: 4 / 5,
            child: Stack(fit: StackFit.expand, children: [
              Image.network(
                url,
                fit: BoxFit.cover,
                loadingBuilder: (_, child, p) => p == null ? child : Container(color: VColors.surface2),
                errorBuilder: (_, _, _) => Container(color: VColors.surface2, child: const Center(child: VIcon(VIcons.image, size: 36, color: VColors.ash2))),
              ),
              AnimatedBuilder(
                animation: _burst,
                builder: (_, _) {
                  final v = _burst.value;
                  if (v == 0 || v == 1) return const SizedBox.shrink();
                  final scale = v < .4 ? Curves.easeOutBack.transform(v / .4) * 1.1 : 1.1 - (v - .4) * .2;
                  return Center(
                    child: Opacity(
                      opacity: v < .7 ? 1 : (1 - v) / .3,
                      child: Transform.scale(scale: scale, child: const Icon(Icons.favorite, size: 96, color: VColors.goldBright, shadows: [Shadow(color: Color(0x99000000), blurRadius: 20)])),
                    ),
                  );
                },
              ),
              if (c.eventTitle != null)
                Positioned(
                  left: 12,
                  bottom: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(color: VColors.bg.withValues(alpha: .8), borderRadius: BorderRadius.circular(99), border: Border.all(color: VColors.frost.withValues(alpha: .5))),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const VIcon(VIcons.calendar, size: 13, color: VColors.frostBright, stroke: 2),
                      const SizedBox(width: 5),
                      Text(c.eventTitle!, style: VType.body(size: 12, weight: FontWeight.w800, color: VColors.frostBright)),
                    ]),
                  ),
                ),
            ]),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 14, 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Semantics(
                button: true,
                toggled: _liked,
                label: t.whoLikes(_count),
                child: IconButton(
                  onPressed: _toggle,
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 180),
                    transitionBuilder: (w, a) => ScaleTransition(scale: a, child: w),
                    child: Icon(_liked ? Icons.favorite : Icons.favorite_border, key: ValueKey(_liked), size: 26, color: _liked ? VColors.goldBright : VColors.bone),
                  ),
                ),
              ),
              Text(t.whoLikes(_count), style: VType.body(size: 13.5, weight: FontWeight.w800)),
            ]),
            if (c.caption != null)
              Padding(
                padding: const EdgeInsets.only(left: 6, top: 2),
                child: Text.rich(TextSpan(children: [
                  TextSpan(text: '${c.nickname}  ', style: VType.body(size: 14, weight: FontWeight.w800)),
                  TextSpan(text: c.caption, style: VType.body(size: 14, color: const Color(0xFFD6CAB4))),
                ])),
              ),
          ]),
        ),
      ]),
    );
  }
}

class _NewsCard extends ConsumerWidget {
  const _NewsCard({required this.post});
  final Post post;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    return VCard(
      onTap: () => context.push('/post/${post.id}'),
      padding: const EdgeInsets.all(12),
      borderColor: VColors.ornament.withValues(alpha: .35),
      child: Row(children: [
        ClipRRect(borderRadius: BorderRadius.circular(12), child: SizedBox(width: 60, height: 60, child: PostImage(post: post, index: 1))),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            VEyebrow(t.postTypeNews, color: VColors.gold, size: 10.5),
            const SizedBox(height: 3),
            Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.body(size: 15, weight: FontWeight.w800, height: 1.25)),
            Text(timeAgo(t, post.publishedAt!, locale), style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
          ]),
        ),
        const VIcon(VIcons.chevRight, size: 18, color: VColors.ash2, stroke: 2),
      ]),
    );
  }
}
