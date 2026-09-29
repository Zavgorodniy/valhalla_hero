import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'event_widgets.dart';

/// Events tab: what is on at the bar (soonest first), then past events as
/// the bar's history. Every event is a picture card with likes.
class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final upcoming = ref.watch(upcomingEventsProvider);
    final past = ref.watch(pastEventsProvider);
    final loading = ref.watch(feedProvider).isLoading && upcoming.isEmpty && past.isEmpty;

    Widget cards(List<Post> list) => SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList.separated(
            itemCount: list.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (_, i) => EventCard(post: list[i]),
          ),
        );

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
            if (loading) SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(40), child: vLoading())),
            if (!loading && upcoming.isEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 32, 40, 8),
                  child: Column(children: [
                    const VIcon(VIcons.calendar, size: 44, color: VColors.ash2, stroke: 1.5),
                    const SizedBox(height: 12),
                    Text(t.eventsEmpty, textAlign: TextAlign.center, style: VType.body(size: 14, color: VColors.ash)),
                  ]),
                ),
              ),
            if (upcoming.isNotEmpty) ...[
              const SliverToBoxAdapter(child: SizedBox(height: 18)),
              cards(upcoming),
            ],
            if (past.isNotEmpty) ...[
              SliverPadding(padding: const EdgeInsets.fromLTRB(0, 30, 0, 14), sliver: SliverToBoxAdapter(child: VSectionHeader(t.eventsPast))),
              cards(past),
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
