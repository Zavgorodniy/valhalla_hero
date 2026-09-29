import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import '../events/event_widgets.dart';

/// Event or news post. Likes only: no comments and no RSVP by design.
class PostScreen extends ConsumerStatefulWidget {
  const PostScreen({super.key, required this.postId});
  final String postId;
  @override
  ConsumerState<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends ConsumerState<PostScreen> {
  bool? _liked;
  int _delta = 0;

  Future<void> _toggle() async {
    final liked = await ref.read(feedRepoProvider).toggleLike(widget.postId);
    setState(() {
      _delta += liked ? 1 : -1;
      _liked = liked;
    });
    ref.invalidate(myLikesProvider);
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final post = (ref.watch(feedProvider).valueOrNull ?? const <Post>[]).where((p) => p.id == widget.postId).firstOrNull;
    final venues = ref.watch(venuesProvider).valueOrNull ?? const <Venue>[];
    if (post == null) return VScreen(child: SafeArea(child: Column(children: [const VTopBar(back: true), Expanded(child: vLoading())])));
    final liked = _liked ?? (ref.watch(myLikesProvider).valueOrNull?.contains(post.id) ?? false);
    final venue = venues.where((v) => v.id == post.venueId).firstOrNull;
    final isEvent = post.type == PostType.event && post.startsAt != null;
    final s = post.startsAt?.toLocal();
    final picture = ref.watch(feedRepoProvider).imageUrl(post.imageUrl);
    final topBar = SafeArea(
      bottom: false,
      child: VTopBar(back: true, actions: [
        VRoundButton(icon: VIcons.share, tooltip: t.share, onTap: () => Share.share('${post.title}\n\n${post.body}')),
      ]),
    );

    Widget meta(VIcons icon, String title, String sub) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: const Color(0xFF1C1511), borderRadius: BorderRadius.circular(10), border: Border.all(color: VColors.border)),
                    child: Center(child: VIcon(icon, size: 18, color: VColors.goldBright, stroke: 1.8)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(title, style: VType.body(size: 14.5, weight: FontWeight.w800)),
                      if (sub.isNotEmpty) Text(sub, style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                    ]),
                  ),
                ]),
              );

          return Scaffold(
            backgroundColor: VColors.bg,
            body: VBackground(
              child: Stack(children: [
                CustomScrollView(slivers: [
                  SliverToBoxAdapter(
                    child: picture != null
                        ? _FlyerHeader(url: picture, topBar: topBar)
                        : SizedBox(
                            height: 340,
                            child: Stack(fit: StackFit.expand, children: [
                              PostImage(post: post),
                              const DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Color(0x8C0E0B09), Color(0x000E0B09), Color(0x330E0B09), VColors.bg],
                                    stops: [0, .3, .6, 1],
                                  ),
                                ),
                              ),
                              Align(alignment: Alignment.topCenter, child: topBar),
                              if (isEvent)
                                Positioned(
                                  left: 20,
                                  bottom: 6,
                                  child: DateBadge(
                                    large: true,
                                    day: dayAbbrev(t, s!.weekday),
                                    date: '${s.day}'.padLeft(2, '0'),
                                    month: MaterialLocalizations.of(context).formatMonthYear(s).split(' ').first.substring(0, 3).toUpperCase(),
                                  ),
                                ),
                            ]),
                          ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 130),
                    sliver: SliverList.list(children: [
                      VEyebrow(isEvent ? t.postTypeEvent : t.postTypeNews, color: VColors.gold, size: 11.5),
                      const SizedBox(height: 8),
                      Text(post.title, style: VType.cinzel(size: 27, height: 1.15)),
                      const SizedBox(height: 18),
                      if (isEvent) meta(VIcons.calendar, formatDateTime(s!, locale: locale), ''),
                      if (venue != null) meta(VIcons.pin, venue.name, [venue.address, venue.city].whereType<String>().join(' · ')),
                      if (!isEvent && post.publishedAt != null) meta(VIcons.saga, formatDate(post.publishedAt!, locale: locale), ''),
                      const SizedBox(height: 6),
                      Text(post.body, style: VType.body(size: 15, color: const Color(0xFFCFC2AE), height: 1.6)),
                    ]),
                  ),
                ]),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: DecoratedBox(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x000E0B09), VColors.bg], stops: [0, .45]),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 36, 20, 20 + MediaQuery.paddingOf(context).bottom),
                      child: Row(children: [
                    Semantics(
                      button: true,
                      toggled: liked,
                      label: '${post.likeCount + _delta}',
                      child: GestureDetector(
                        onTap: _toggle,
                        child: Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: liked ? VColors.gold.withValues(alpha: .12) : VColors.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: liked ? VColors.gold.withValues(alpha: .55) : VColors.border),
                          ),
                          child: Row(children: [
                            Icon(liked ? Icons.favorite : Icons.favorite_border, size: 20, color: liked ? VColors.gold : VColors.ash),
                            const SizedBox(width: 8),
                            Text('${post.likeCount + _delta}', style: VType.body(size: 15, weight: FontWeight.w800, color: liked ? VColors.goldBright : VColors.bone)),
                          ]),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(child: VSecondaryButton(label: t.share, icon: VIcons.share, onPressed: () => Share.share('${post.title}\n\n${post.body}'))),
                    if (venue?.address != null) ...[
                      const SizedBox(width: 10),
                      VRoundButton(
                        icon: VIcons.route,
                        tooltip: t.directions,
                        size: 50,
                        background: VColors.surface2,
                        onTap: () => launchUrl(
                          Uri.https('maps.apple.com', '/', {'q': '${venue!.name}, ${venue.address}, ${venue.city ?? ''}'}),
                          mode: LaunchMode.externalApplication,
                        ),
                      ),
                    ],
                ]),
              ),
            ),
          ),
          const StatusBarScrim(),
        ]),
      ),
    );
  }
}

/// Header for posts with their own picture: the whole flyer, as tall as it
/// needs (up to 480), on a blurred copy of itself.
class _FlyerHeader extends StatelessWidget {
  const _FlyerHeader({required this.url, required this.topBar});
  final String url;
  final Widget topBar;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return Stack(children: [
      // blurred, darkened backdrop that fades into the page
      Positioned.fill(
        child: ShaderMask(
          blendMode: BlendMode.dstIn,
          shaderCallback: (r) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white, Colors.transparent],
            stops: [0, .55, 1],
          ).createShader(r),
          child: ClipRect(
            child: Stack(fit: StackFit.expand, children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 26, sigmaY: 26, tileMode: TileMode.clamp),
                child: Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => const SizedBox.shrink()),
              ),
              const ColoredBox(color: Color(0x990E0B09)),
            ]),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.fromLTRB(20, top + 64, 20, 24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 480),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                url,
                fit: BoxFit.contain,
                frameBuilder: (_, child, frame, sync) => frame == null && !sync ? const SizedBox(height: 320) : child,
                errorBuilder: (_, _, _) => const SizedBox(height: 120),
              ),
            ),
          ),
        ),
      ),
      Positioned(top: 0, left: 0, right: 0, child: topBar),
    ]);
  }
}
