import 'package:flutter/material.dart';
import 'package:valhalla_core/valhalla_core.dart';

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
