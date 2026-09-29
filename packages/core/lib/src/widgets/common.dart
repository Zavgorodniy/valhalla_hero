import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../l10n/generated/app_localizations.dart';
import '../models/enums.dart';
import '../theme/valhalla_theme.dart';

/// Renders an AsyncValue with consistent loading / error UI.
class AsyncView<T> extends StatelessWidget {
  const AsyncView({super.key, required this.value, required this.data, this.onRetry, this.compact = false});
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final VoidCallback? onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return value.when(
      skipLoadingOnReload: true,
      skipLoadingOnRefresh: true,
      data: data,
      loading: () => compact
          ? const Padding(padding: EdgeInsets.all(12), child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))))
          : const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: VColors.blood, size: 32),
              const SizedBox(height: 8),
              Text('$e', textAlign: TextAlign.center, style: const TextStyle(color: VColors.ash, fontSize: 12)),
              if (onRetry != null) TextButton(onPressed: onRetry, child: Text(L10n.of(context).retry)),
            ],
          ),
        ),
      ),
    );
  }
}

class CoinChip extends StatelessWidget {
  const CoinChip({super.key, required this.amount, this.large = false});
  final int amount;
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: large ? 14 : 10, vertical: large ? 8 : 5),
      decoration: BoxDecoration(
        color: VColors.gold.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: VColors.goldDim),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.toll_rounded, size: large ? 20 : 15, color: VColors.gold),
          const SizedBox(width: 6),
          Text('$amount', style: TextStyle(color: VColors.goldBright, fontWeight: FontWeight.w700, fontSize: large ? 17 : 13)),
        ],
      ),
    );
  }
}

class XpBar extends StatelessWidget {
  const XpBar({super.key, required this.xp, required this.from, required this.to, this.height = 10});
  final int xp;
  final int from;
  final int? to; // null = max level
  final double height;

  @override
  Widget build(BuildContext context) {
    final t = to;
    final progress = t == null ? 1.0 : ((xp - from) / (t - from)).clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height),
      child: Stack(children: [
        Container(height: height, color: VColors.surface3),
        FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            height: height,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [VColors.goldDim, VColors.goldBright])),
          ),
        ),
      ]),
    );
  }
}

class LevelBadge extends StatelessWidget {
  const LevelBadge({super.key, required this.level, this.name, this.small = false});
  final int level;
  final String? name;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final c = VColors.levelColors[level] ?? VColors.ash;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: small ? 8 : 10, vertical: small ? 3 : 5),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.18), borderRadius: BorderRadius.circular(8), border: Border.all(color: c.withValues(alpha: 0.6))),
      child: Text(name == null ? '$level' : '$level · $name', style: TextStyle(color: c, fontWeight: FontWeight.w700, fontSize: small ? 11 : 12, letterSpacing: 0.5)),
    );
  }
}

class RarityDot extends StatelessWidget {
  const RarityDot({super.key, required this.rarity, this.label});
  final ItemRarity rarity;
  final String? label;

  Color get color => switch (rarity) {
        ItemRarity.common => VColors.rarityCommon,
        ItemRarity.rare => VColors.rarityRare,
        ItemRarity.legendary => VColors.rarityLegendary,
      };

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
      if (label != null) ...[const SizedBox(width: 5), Text(label!, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600))],
    ]);
  }
}

class OnBoardChip extends StatelessWidget {
  const OnBoardChip({super.key, required this.onBoard, required this.label});
  final bool onBoard;
  final String label;

  @override
  Widget build(BuildContext context) {
    final c = onBoard ? VColors.moss : VColors.ash;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: c.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(999), border: Border.all(color: c.withValues(alpha: 0.5))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(onBoard ? Icons.sailing_rounded : Icons.anchor_rounded, size: 13, color: c),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(color: c, fontSize: 11, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 10),
      child: Row(children: [
        Expanded(child: Text(text.toUpperCase(), style: Theme.of(context).textTheme.labelSmall)),
        if (trailing != null) trailing!,
      ]),
    );
  }
}

void showSnack(BuildContext context, String message, {bool error = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message), backgroundColor: error ? VColors.blood : null));
}
