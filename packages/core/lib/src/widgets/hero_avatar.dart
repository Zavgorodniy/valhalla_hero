import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../models/enums.dart';
import '../theme/valhalla_theme.dart';

/// Composes the level hero with equipped cosmetic layers.
///
/// All hero and item SVGs share the same 200x260 canvas and a unified frontal
/// pose, so items line up regardless of level. Layer order: frame (back),
/// cape, hero, headgear, hand item, companion, frame (front ring).
class HeroAvatar extends StatelessWidget {
  const HeroAvatar({
    super.key,
    required this.heroAsset,
    this.equipped = const {},
    this.size = 160,
    this.level,
  });

  final String heroAsset;
  final Map<ItemSlot, String> equipped;
  final double size;
  final int? level;

  static const _pkg = 'valhalla_core';

  String _hero(String key) => 'assets/heroes/$key.svg';
  String _item(String key) => 'assets/items/$key.svg';

  @override
  Widget build(BuildContext context) {
    final accent = VColors.levelColors[level ?? 1] ?? VColors.ash;
    final layers = <Widget>[
      if (equipped[ItemSlot.frame] != null) _svg(_item('${equipped[ItemSlot.frame]}_back')),
      if (equipped[ItemSlot.cape] != null) _svg(_item(equipped[ItemSlot.cape]!)),
      _svg(_hero(heroAsset)),
      if (equipped[ItemSlot.headgear] != null) _svg(_item(equipped[ItemSlot.headgear]!)),
      if (equipped[ItemSlot.handItem] != null) _svg(_item(equipped[ItemSlot.handItem]!)),
      if (equipped[ItemSlot.companion] != null) _svg(_item(equipped[ItemSlot.companion]!)),
      if (equipped[ItemSlot.frame] != null) _svg(_item(equipped[ItemSlot.frame]!)),
    ];
    return SizedBox(
      width: size,
      height: size * 1.3,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: [accent.withValues(alpha: 0.22), Colors.transparent], radius: 0.75),
        ),
        child: Stack(fit: StackFit.expand, children: layers),
      ),
    );
  }

  Widget _svg(String path) => SvgPicture.asset(
        path,
        package: _pkg,
        fit: BoxFit.contain,
        placeholderBuilder: (_) => const SizedBox.shrink(),
      );
}

/// Small standalone preview of one item, cropped to the region of the shared
/// 200x260 canvas where that item lives (so a helmet fills the tile instead of
/// showing as a speck at the top of an empty hero silhouette).
class ItemPreview extends StatelessWidget {
  const ItemPreview({super.key, required this.assetKey, required this.slot, this.size = 72});
  final String assetKey;
  final ItemSlot slot;
  final double size;

  static const _canvas = Size(200, 260);

  /// Focus rectangles in canvas coordinates; per asset first, per slot fallback.
  static const _assetFocus = <String, Rect>{
    'hand_shield': Rect.fromLTWH(10, 116, 72, 72),
    'hand_spear': Rect.fromLTWH(110, 0, 80, 170),
    'hand_axe': Rect.fromLTWH(120, 80, 80, 90),
    'hand_sword': Rect.fromLTWH(120, 60, 60, 100),
    'hand_horn': Rect.fromLTWH(130, 96, 60, 64),
    'companion_raven': Rect.fromLTWH(0, 70, 60, 40),
    'companion_wolf': Rect.fromLTWH(0, 180, 84, 60),
    'companion_bear': Rect.fromLTWH(0, 174, 90, 64),
  };
  static const _slotFocus = <ItemSlot, Rect>{
    ItemSlot.headgear: Rect.fromLTWH(36, 0, 128, 100),
    ItemSlot.handItem: Rect.fromLTWH(110, 60, 90, 110),
    ItemSlot.cape: Rect.fromLTWH(36, 90, 128, 128),
    ItemSlot.companion: Rect.fromLTWH(0, 170, 90, 70),
    ItemSlot.frame: Rect.fromLTWH(0, 0, 200, 260),
  };

  @override
  Widget build(BuildContext context) {
    final r = _assetFocus[assetKey] ?? _slotFocus[slot]!;
    final k = size / (r.width > r.height ? r.width : r.height);
    final dx = (size - r.width * k) / 2 - r.left * k;
    final dy = (size - r.height * k) / 2 - r.top * k;
    return SizedBox(
      width: size,
      height: size,
      child: ClipRect(
        child: Stack(clipBehavior: Clip.none, children: [
          Positioned(
            left: dx,
            top: dy,
            width: _canvas.width * k,
            height: _canvas.height * k,
            child: SvgPicture.asset('assets/items/$assetKey.svg', package: 'valhalla_core', fit: BoxFit.fill),
          ),
        ]),
      ),
    );
  }
}

/// Reward artwork: uses the DB image_url when present, else a type placeholder.
class RewardImage extends StatelessWidget {
  const RewardImage({super.key, required this.type, this.imageUrl, this.size = 72});
  final RewardType type;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    if (url != null && url.startsWith('http')) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(url, width: size, height: size, fit: BoxFit.cover, errorBuilder: (_, _, _) => _placeholder()),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => SizedBox(
        width: size,
        height: size,
        child: SvgPicture.asset('assets/rewards/${enumWire(type)}.svg', package: 'valhalla_core', fit: BoxFit.contain),
      );
}
