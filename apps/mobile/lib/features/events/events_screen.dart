import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'event_widgets.dart';

String eventCategoryName(L10n t, EventCategory? c) => switch (c) {
      EventCategory.match => t.catMatch,
      EventCategory.live => t.catLive,
      EventCategory.quiz => t.catQuiz,
      EventCategory.party => t.catParty,
      EventCategory.special || null => t.catSpecial,
    };

VIcons eventCategoryIcon(EventCategory? c) => switch (c) {
      EventCategory.match => VIcons.shield,
      EventCategory.live => VIcons.music,
      EventCategory.quiz => VIcons.rune,
      EventCategory.party => VIcons.sparkle,
      EventCategory.special || null => VIcons.star,
    };

/// Events tab: what is on at the bar, soonest first, with likes.
class EventsScreen extends ConsumerStatefulWidget {
  const EventsScreen({super.key});
  @override
  ConsumerState<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends ConsumerState<EventsScreen> {
  EventCategory? _filter;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final all = ref.watch(upcomingEventsProvider);
    final loading = ref.watch(feedProvider).isLoading && all.isEmpty;
    final cats = {for (final e in all) e.category ?? EventCategory.special}.toList()..sort((a, b) => a.index.compareTo(b.index));
    final events = all.where((e) => _filter == null || (e.category ?? EventCategory.special) == _filter).toList();
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final highlight = events.where((e) => e.startsAt!.toLocal().isBefore(today.add(const Duration(days: 1)))).firstOrNull;
    final rest = events.where((e) => e != highlight).toList();

    final groups = <DateTime, List<Post>>{};
    for (final e in rest) {
      final d = e.startsAt!.toLocal();
      groups.putIfAbsent(DateTime(d.year, d.month, d.day), () => []).add(e);
    }
    String dayLabel(DateTime d) {
      if (d == today) return t.today;
      if (d == today.add(const Duration(days: 1))) return t.tomorrow;
      return DateFormat.MMMMEEEEd(locale).format(d);
    }

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        glow: VColors.frost,
        child: RefreshIndicator(
          color: VColors.gold,
          onRefresh: () async {
            ref.invalidate(feedProvider);
            ref.invalidate(myLikesProvider);
          },
          child: CustomScrollView(slivers: [
            SliverSafeArea(bottom: false, sliver: SliverToBoxAdapter(child: VTopBar(title: t.tabEvents))),
            if (cats.length > 1)
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 34,
                  child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), children: [
                    Padding(padding: const EdgeInsets.only(right: 8), child: VChip(label: t.all, active: _filter == null, onTap: () => setState(() => _filter = null))),
                    for (final c in cats)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: VChip(label: eventCategoryName(t, c), icon: eventCategoryIcon(c), active: _filter == c, onTap: () => setState(() => _filter = c)),
                      ),
                  ]),
                ),
              ),
            if (loading) SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(40), child: vLoading())),
            if (!loading && events.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(children: [
                    const VIcon(VIcons.calendar, size: 44, color: VColors.ash2, stroke: 1.5),
                    const SizedBox(height: 12),
                    Text(t.eventsEmpty, textAlign: TextAlign.center, style: VType.body(size: 14, color: VColors.ash)),
                  ]),
                ),
              ),
            if (highlight != null)
              SliverPadding(padding: const EdgeInsets.fromLTRB(20, 18, 20, 0), sliver: SliverToBoxAdapter(child: _Tonight(post: highlight))),
            for (final g in groups.entries) ...[
              SliverPadding(padding: const EdgeInsets.fromLTRB(0, 26, 0, 12), sliver: SliverToBoxAdapter(child: VSectionHeader(dayLabel(g.key)))),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverList.separated(
                  itemCount: g.value.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => EventRow(post: g.value[i]),
                ),
              ),
            ],
            const SliverToBoxAdapter(child: SizedBox(height: kTabBarSpace)),
          ]),
        ),
      ),
    );
  }
}

/// Like toggle for posts/events with optimistic count.
class LikeButton extends ConsumerStatefulWidget {
  const LikeButton({super.key, required this.post, this.compact = false});
  final Post post;
  final bool compact;
  @override
  ConsumerState<LikeButton> createState() => _LikeButtonState();
}

class _LikeButtonState extends ConsumerState<LikeButton> {
  bool? _liked;
  int _delta = 0;

  Future<void> _toggle() async {
    HapticFeedback.lightImpact();
    final was = _liked ?? (ref.read(myLikesProvider).valueOrNull?.contains(widget.post.id) ?? false);
    setState(() {
      _liked = !was;
      _delta += was ? -1 : 1;
    });
    try {
      final now = await ref.read(feedRepoProvider).toggleLike(widget.post.id);
      if (now == was && mounted) {
        setState(() {
          _liked = now;
          _delta += now ? 1 : -1;
        });
      }
    } on ApiError {
      if (mounted) {
        setState(() {
          _liked = was;
          _delta += was ? 1 : -1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final liked = _liked ?? (ref.watch(myLikesProvider).valueOrNull?.contains(widget.post.id) ?? false);
    final count = widget.post.likeCount + _delta;
    return Semantics(
      button: true,
      toggled: liked,
      label: L10n.of(context).whoLikes(count),
      child: GestureDetector(
        onTap: _toggle,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: widget.compact ? 36 : 44,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: liked ? VColors.gold.withValues(alpha: .12) : VColors.bg.withValues(alpha: .6),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: liked ? VColors.gold.withValues(alpha: .55) : VColors.border),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
              child: Icon(liked ? Icons.favorite : Icons.favorite_border, key: ValueKey(liked), size: 18, color: liked ? VColors.gold : VColors.ash),
            ),
            const SizedBox(width: 6),
            Text('$count', style: VType.body(size: 14, weight: FontWeight.w800, color: liked ? VColors.goldBright : VColors.bone, tabular: true)),
          ]),
        ),
      ),
    );
  }
}

class _Tonight extends StatelessWidget {
  const _Tonight({required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final s = post.startsAt!.toLocal();
    final now = DateTime.now();
    final live = s.isBefore(now) && (post.endsAt?.toLocal() ?? s.add(const Duration(hours: 3))).isAfter(now);
    final time = TimeOfDay.fromDateTime(s).format(context);
    return GestureDetector(
      onTap: () => context.push('/post/${post.id}'),
      child: Container(
        height: 250,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: VColors.gold.withValues(alpha: .55)),
          boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .12), blurRadius: 30)],
        ),
        child: Stack(fit: StackFit.expand, children: [
          PostImage(post: post),
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x330E0B09), Color(0x000E0B09), Color(0xF20E0B09)], stops: [0, .35, .95]),
            ),
          ),
          const VEmbers(opacity: .6),
          Positioned(
            left: 16,
            top: 16,
            child: VStatusPill(label: (live ? t.liveNow : t.tonight).toUpperCase(), color: live ? VColors.bloodText : VColors.goldBright, dot: true),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                VIcon(eventCategoryIcon(post.category), size: 15, color: VColors.frostBright, stroke: 1.9),
                const SizedBox(width: 6),
                Text('${eventCategoryName(t, post.category)} · $time', style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.frostBright)),
              ]),
              const SizedBox(height: 6),
              Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 23, height: 1.15)),
              const SizedBox(height: 10),
              Row(children: [LikeButton(post: post, compact: true), const Spacer(), const VIcon(VIcons.chevRight, size: 20, color: VColors.ash)]),
            ]),
          ),
        ]),
      ),
    );
  }
}

class EventRow extends StatelessWidget {
  const EventRow({super.key, required this.post});
  final Post post;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final s = post.startsAt!.toLocal();
    final time = TimeOfDay.fromDateTime(s).format(context);
    final month = MaterialLocalizations.of(context).formatMonthYear(s).split(' ').first;
    return GestureDetector(
      onTap: () => context.push('/post/${post.id}'),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(gradient: VColors.cardGradient, borderRadius: BorderRadius.circular(18), border: Border.all(color: VColors.border)),
        child: IntrinsicHeight(
          child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            SizedBox(
              width: 104,
              child: Stack(fit: StackFit.expand, children: [
                PostImage(post: post),
                const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0x000E0B09), Color(0x991A1411)]))),
                Center(child: DateBadge(day: dayAbbrev(t, s.weekday), date: '${s.day}'.padLeft(2, '0'), month: month.substring(0, month.length.clamp(0, 3)).toUpperCase())),
              ]),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 12, 12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    VIcon(eventCategoryIcon(post.category), size: 14, color: VColors.frostBright, stroke: 1.9),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text('${eventCategoryName(t, post.category)} · $time',
                          overflow: TextOverflow.ellipsis, style: VType.body(size: 12, weight: FontWeight.w800, color: VColors.frostBright)),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 16, height: 1.2)),
                  const SizedBox(height: 10),
                  LikeButton(post: post, compact: true),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
