import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:valhalla_core/valhalla_core.dart';

import 'events_screen.dart' show LikeButton;

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

/// Post image (full URL or path in the `media` bucket), or a scene from the
/// art kit when none is set.
///
/// [whole] shows the complete picture instead of cropping it – event flyers
/// carry their own text – on top of a blurred, darkened copy of itself.
/// [padding] keeps the whole picture clear of overlaid content, [alignment]
/// picks the visible part of a cropped picture, [dim] desaturates it (events
/// that are over).
class PostImage extends ConsumerWidget {
  const PostImage({
    super.key,
    required this.post,
    this.index = 0,
    this.whole = false,
    this.padding = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.dim = false,
  });
  final Post post;
  final int index;
  final bool whole;
  final EdgeInsets padding;
  final Alignment alignment;
  final bool dim;

  static const _desaturate = ColorFilter.matrix(<double>[
    0.567, 0.393, 0.040, 0, 0, //
    0.117, 0.843, 0.040, 0, 0,
    0.117, 0.393, 0.490, 0, 0,
    0, 0, 0, 1, 0,
  ]);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const scenes = ['hall', 'fjord', 'aurora', 'raven'];
    final fallback = VArt.image(VArt.scene(scenes[(post.id.hashCode.abs() + index) % scenes.length]));
    final url = ref.watch(feedRepoProvider).imageUrl(post.imageUrl);
    Widget child;
    if (url == null) {
      child = fallback;
    } else if (!whole) {
      child = Image.network(url, fit: BoxFit.cover, alignment: alignment, errorBuilder: (_, _, _) => fallback);
    } else {
      child = ClipRect(
        child: Stack(fit: StackFit.expand, children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 26, sigmaY: 26, tileMode: TileMode.clamp),
            child: Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => fallback),
          ),
          const ColoredBox(color: Color(0x8C0E0B09)),
          Padding(padding: padding, child: Image.network(url, fit: BoxFit.contain, errorBuilder: (_, _, _) => const SizedBox.shrink())),
        ]),
      );
    }
    return dim ? ColorFiltered(colorFilter: _desaturate, child: child) : child;
  }
}

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

/// An event as a large picture card – the picture fills the card – with status
/// or date, category · time, title and likes. Running and tonight's events
/// glow; past ones are desaturated.
class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.post});
  final Post post;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final now = DateTime.now();
    final s = post.startsAt!.toLocal();
    final today = DateUtils.dateOnly(now);
    final day = DateUtils.dateOnly(s);
    final live = post.isLiveAt(now);
    final past = post.isOverAt(now);
    final tonight = !live && !past && day == today;
    final highlight = live || tonight;
    final time = TimeOfDay.fromDateTime(s).format(context);

    final pill = live
        ? VStatusPill(label: t.liveNow.toUpperCase(), color: VColors.bloodText, dot: true)
        : tonight
            ? VStatusPill(label: t.tonight.toUpperCase(), color: VColors.goldBright, dot: true)
            : VStatusPill(
                label: (day == today.add(const Duration(days: 1)) ? t.tomorrow : DateFormat.MMMEd(locale).format(s)).toUpperCase(),
                color: past ? VColors.ash : VColors.goldBright,
                icon: VIcons.calendar,
              );

    return GestureDetector(
      onTap: () => context.push('/post/${post.id}'),
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: VColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: highlight ? VColors.gold.withValues(alpha: .55) : VColors.border),
            boxShadow: highlight ? [BoxShadow(color: VColors.gold.withValues(alpha: .12), blurRadius: 30)] : null,
          ),
          child: Stack(fit: StackFit.expand, children: [
            // biased to the top: the bottom sits under the title
            PostImage(post: post, dim: past, alignment: const Alignment(0, -.4)),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x800E0B09), Color(0x000E0B09), Color(0x000E0B09), Color(0xE60E0B09), VColors.bg],
                  stops: [0, .22, .42, .7, .9],
                ),
              ),
            ),
            if (highlight) const VEmbers(opacity: .6),
            // solid backing keeps the pill readable over busy flyers
            Positioned(
              left: 16,
              top: 16,
              child: DecoratedBox(decoration: BoxDecoration(color: const Color(0xE00E0B09), borderRadius: BorderRadius.circular(99)), child: pill),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  VIcon(eventCategoryIcon(post.category), size: 15, color: VColors.frostBright, stroke: 1.9),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text('${eventCategoryName(t, post.category)} · $time',
                        maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.frostBright)),
                  ),
                ]),
                const SizedBox(height: 6),
                Text(post.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 22, height: 1.15)),
                const SizedBox(height: 10),
                Row(children: [LikeButton(post: post, compact: true), const Spacer(), const VIcon(VIcons.chevRight, size: 20, color: VColors.ash)]),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
