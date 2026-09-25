import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../models/enums.dart';
import '../theme/valhalla_theme.dart';
import 'hero_avatar.dart';
import 'v_icons.dart';

const _pkg = 'valhalla_core';

String _roman(int n) => const ['', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII'][n.clamp(0, 8)];
String romanLevel(int n) => _roman(n);

// ---------------------------------------------------------------- art paths
class VArt {
  VArt._();
  static String hero(int level, HeroForm form) => 'assets/art/heroes/${form == HeroForm.heroine ? 'heroine' : 'hero'}_${level.clamp(1, 8)}.webp';
  static String portrait(int level, HeroForm form) => 'assets/art/portraits/${form == HeroForm.heroine ? 'heroine' : 'hero'}_${level.clamp(1, 8)}.webp';
  static String stage(int level) => 'assets/art/stages/stage_${level.clamp(1, 8)}.webp';
  static String scene(String name) => 'assets/art/scenes/$name.webp';
  static const grain = 'assets/art/tex/grain.png';
  static const embers = 'assets/art/tex/embers.png';

  /// Item asset keys that have painted art; the rest fall back to SVG placeholders.
  static const paintedItems = {
    'headgear_iron_helm', 'headgear_horned_helm', 'hand_horn', 'hand_shield', 'hand_axe', 'hand_spear', 'hand_sword',
    'cape_wool', 'cape_fur', 'cape_royal', 'companion_raven', 'companion_wolf', 'companion_bear',
    'frame_wood', 'frame_iron', 'frame_runic', 'frame_gold',
  };
  static String item(String key) => 'assets/art/items/$key.webp';

  static Image image(String path, {double? width, double? height, BoxFit fit = BoxFit.cover, Alignment alignment = Alignment.center}) =>
      Image.asset(path, package: _pkg, width: width, height: height, fit: fit, alignment: alignment, gaplessPlayback: true);

  static AssetImage provider(String path) => AssetImage(path, package: _pkg);
}

// ---------------------------------------------------------------- background
/// Night-hall background with a faint grain texture; wrap full screens in it.
class VBackground extends StatelessWidget {
  const VBackground({super.key, required this.child, this.glow});
  final Widget child;
  final Color? glow;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: VColors.bg,
        image: DecorationImage(image: VArt.provider(VArt.grain), repeat: ImageRepeat.repeat, scale: 2),
      ),
      child: glow == null
          ? child
          : DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(center: const Alignment(0, -1), radius: 1.1, colors: [glow!.withValues(alpha: .16), glow!.withValues(alpha: 0)]),
              ),
              child: child,
            ),
    );
  }
}

class VEmbers extends StatelessWidget {
  const VEmbers({super.key, this.opacity = .6});
  final double opacity;
  @override
  Widget build(BuildContext context) => IgnorePointer(
        child: Opacity(
          opacity: opacity,
          child: DecoratedBox(
            decoration: BoxDecoration(image: DecorationImage(image: VArt.provider(VArt.embers), fit: BoxFit.cover, alignment: Alignment.topCenter)),
            child: const SizedBox.expand(),
          ),
        ),
      );
}

// ---------------------------------------------------------------- currency
class VCoin extends StatelessWidget {
  const VCoin({super.key, this.size = 18});
  final double size;
  @override
  Widget build(BuildContext context) {
    final ring = math.max(1.0, size / 14);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          center: Alignment(-.32, -.44),
          colors: [Color(0xFFFFEDB8), Color(0xFFF0B955), Color(0xFFC8862C), Color(0xFF7C4E14)],
          stops: [0, .38, .72, 1],
        ),
        border: Border.all(color: const Color(0x8C643C0A), width: ring),
        boxShadow: const [BoxShadow(color: Color(0x80000000), blurRadius: 3, offset: Offset(0, 1))],
      ),
      child: size >= 30 ? Text('ᚠ', style: VType.runes(size: size * .46, color: const Color(0xD96B420F), spacing: 0)) : null,
    );
  }
}

class VGem extends StatelessWidget {
  const VGem({super.key, this.size = 18});
  final double size;
  @override
  Widget build(BuildContext context) => SizedBox(width: size, height: size, child: CustomPaint(painter: _GemPainter()));
}

class _GemPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final w = s.width, h = s.height;
    final top = Offset(w / 2, h * .1), right = Offset(w * .78, h / 2), bottom = Offset(w / 2, h * .9), left = Offset(w * .22, h / 2);
    canvas.drawPath(Path()..addPolygon([top, right, bottom, left], true),
        Paint()
          ..color = VColors.frost.withValues(alpha: .55)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3));
    canvas.drawPath(Path()..addPolygon([top, right, bottom, left], true), Paint()..color = const Color(0xFF4E97AE));
    canvas.drawPath(Path()..addPolygon([top, bottom, left], true), Paint()..color = VColors.frostBright);
    canvas.drawPath(Path()..addPolygon([top, right, left], true), Paint()..color = const Color(0x8CCFF1F8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VCoinPill extends StatelessWidget {
  const VCoinPill({super.key, required this.amount, this.onTap, this.label});
  final int amount;
  final VoidCallback? onTap;
  final String? label;
  @override
  Widget build(BuildContext context) {
    final pill = Container(
      height: 36,
      padding: const EdgeInsets.fromLTRB(8, 0, 13, 0),
      decoration: BoxDecoration(
        color: VColors.bg.withValues(alpha: .62),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: VColors.gold.withValues(alpha: .35)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        const VCoin(size: 20),
        const SizedBox(width: 7),
        Text(label ?? _fmt(amount), style: VType.body(size: 15, weight: FontWeight.w800, tabular: true)),
      ]),
    );
    if (onTap == null) return pill;
    return Semantics(button: true, child: GestureDetector(onTap: onTap, behavior: HitTestBehavior.opaque, child: pill));
  }
}

String _fmt(int n) => '${n < 0 ? '−' : ''}${NumberFormat.decimalPattern(Intl.defaultLocale ?? 'de').format(n.abs())}';

/// Thousands grouping in the UI language ("1.640", "1 640", "1,640").
String vNum(int n) => _fmt(n);

// ---------------------------------------------------------------- progress
class VXpBar extends StatelessWidget {
  const VXpBar({super.key, required this.progress, this.height = 10});
  final double progress;
  final double height;
  @override
  Widget build(BuildContext context) {
    final p = progress.clamp(0.0, 1.0);
    return LayoutBuilder(builder: (context, c) {
      final w = c.maxWidth;
      return SizedBox(
        height: height + 4,
        child: Stack(clipBehavior: Clip.none, alignment: Alignment.centerLeft, children: [
          Container(
            height: height,
            decoration: BoxDecoration(
              color: const Color(0xFF0A1316),
              borderRadius: BorderRadius.circular(99),
              border: Border.all(color: VColors.frost.withValues(alpha: .28)),
            ),
          ),
          Container(
            width: math.max(0, w * p),
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              gradient: const LinearGradient(colors: [Color(0xFF2C7690), VColors.frost, Color(0xFFC4EEF8)], stops: [0, .7, 1]),
              boxShadow: [BoxShadow(color: VColors.frost.withValues(alpha: .55), blurRadius: 12)],
            ),
          ),
          if (p > 0)
            Positioned(
              left: w * p - (height + 2) / 2,
              child: Transform.rotate(
                angle: math.pi / 4,
                child: Container(
                  width: height + 2,
                  height: height + 2,
                  decoration: BoxDecoration(color: const Color(0xFFDDF6FC), boxShadow: [BoxShadow(color: VColors.frostBright.withValues(alpha: .8), blurRadius: 10, spreadRadius: 1)]),
                ),
              ),
            ),
        ]),
      );
    });
  }
}

class VGoldBar extends StatelessWidget {
  const VGoldBar({super.key, required this.progress, this.height = 6});
  final double progress;
  final double height;
  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(99),
        child: Container(
          height: height,
          decoration: BoxDecoration(color: const Color(0xFF1B140E), border: Border.all(color: VColors.gold.withValues(alpha: .2))),
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: progress.clamp(0.0, 1.0),
            child: Container(decoration: const BoxDecoration(gradient: LinearGradient(colors: [VColors.goldDim, VColors.gold]))),
          ),
        ),
      );
}

// ---------------------------------------------------------------- badges & chips
class VLevelBadge extends StatelessWidget {
  const VLevelBadge({super.key, required this.level, this.size = 44});
  final int level;
  final double size;
  @override
  Widget build(BuildContext context) {
    final c = VColors.level(level);
    final gap = math.max(3.0, size / 12);
    return Container(
      width: size + gap * 2 + 2,
      height: size + gap * 2 + 2,
      alignment: Alignment.center,
      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: c.withValues(alpha: .53)), boxShadow: [BoxShadow(color: c.withValues(alpha: .33), blurRadius: size / 3)]),
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(center: Alignment(0, -.4), colors: [Color(0xFF33271D), Color(0xFF140F0B)], stops: [0, .75]),
          border: Border.all(color: c, width: 1.5),
        ),
        child: Text(_roman(level), style: VType.cinzel(size: size * (level < 7 ? .36 : .3), color: c)),
      ),
    );
  }
}

class VRarityChip extends StatelessWidget {
  const VRarityChip({super.key, required this.rarity, required this.label, this.small = false});
  final ItemRarity rarity;
  final String label;
  final bool small;
  @override
  Widget build(BuildContext context) {
    final c = VColors.rarity(rarity);
    return Container(
      height: small ? 18 : 22,
      padding: EdgeInsets.symmetric(horizontal: small ? 7 : 9),
      decoration: BoxDecoration(color: c.withValues(alpha: .12), borderRadius: BorderRadius.circular(99), border: Border.all(color: c.withValues(alpha: .4))),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Transform.rotate(angle: math.pi / 4, child: Container(width: 5.5, height: 5.5, color: c)),
        const SizedBox(width: 5),
        Text(label.toUpperCase(), style: VType.body(size: small ? 9.5 : 10.5, weight: FontWeight.w800, color: c, spacing: .4)),
      ]),
    );
  }
}

/// Small status pill ("Aktiv", "An Bord", "Noch 3 Tage").
class VStatusPill extends StatelessWidget {
  const VStatusPill({super.key, required this.label, required this.color, this.icon, this.dot = false});
  final String label;
  final Color color;
  final VIcons? icon;
  final bool dot;
  @override
  Widget build(BuildContext context) => Container(
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(99), border: Border.all(color: color.withValues(alpha: .45))),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (dot) Container(width: 8, height: 8, margin: const EdgeInsets.only(right: 7), decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          if (icon != null) Padding(padding: const EdgeInsets.only(right: 5), child: VIcon(icon!, size: 14, color: color, stroke: 2)),
          Text(label, style: VType.body(size: 12, weight: FontWeight.w800, color: color)),
        ]),
      );
}

class VEyebrow extends StatelessWidget {
  const VEyebrow(this.text, {super.key, this.color = const Color(0xFFC9B89A), this.size = 12});
  final String text;
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) => Text(text.toUpperCase(), style: VType.eyebrow(size: size, color: color));
}

class VDiamond extends StatelessWidget {
  const VDiamond({super.key, this.color = VColors.goldDim, this.size = 8});
  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: math.pi / 4,
        child: Container(width: size, height: size, decoration: BoxDecoration(border: Border.all(color: color, width: 1.5))),
      );
}

class VSectionHeader extends StatelessWidget {
  const VSectionHeader(this.title, {super.key, this.action, this.onAction, this.padding = const EdgeInsets.symmetric(horizontal: 20)});
  final String title;
  final String? action;
  final VoidCallback? onAction;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Padding(
        padding: padding,
        child: Row(children: [
          const VDiamond(),
          const SizedBox(width: 10),
          VEyebrow(title),
          const SizedBox(width: 10),
          Expanded(child: Container(height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [VColors.border, Color(0x003A302A)])))),
          if (action != null)
            GestureDetector(
              onTap: onAction,
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, top: 8, bottom: 8),
                child: Row(children: [
                  Text(action!, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.gold)),
                  const VIcon(VIcons.chevRight, size: 16, color: VColors.gold, stroke: 2),
                ]),
              ),
            ),
        ]),
      );
}

// ---------------------------------------------------------------- surfaces
class VCard extends StatelessWidget {
  const VCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.onTap, this.borderColor, this.radius = 18, this.color});
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final Color? borderColor;
  final double radius;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    final box = Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: color == null ? VColors.cardGradient : null,
        color: color,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? VColors.border),
      ),
      child: child,
    );
    if (onTap == null) return box;
    return Material(
      color: Colors.transparent,
      child: InkWell(borderRadius: BorderRadius.circular(radius), onTap: onTap, child: box),
    );
  }
}

/// Framed card for hero moments only (goal, voucher, highlight).
class VOrnateCard extends StatelessWidget {
  const VOrnateCard({super.key, required this.child, this.padding = const EdgeInsets.all(18)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const RadialGradient(center: Alignment(0, -1), radius: 1.3, colors: [Color(0xFF2C2118), Color(0xFF1A1411), Color(0xFF15100D)], stops: [0, .6, 1]),
        border: Border.all(color: VColors.ornament.withValues(alpha: .55)),
        boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .08), blurRadius: 40)],
      ),
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14), border: Border.all(color: VColors.ornament.withValues(alpha: .22))),
        child: CustomPaint(
          foregroundPainter: _CornerPainter(),
          child: Padding(padding: padding - const EdgeInsets.all(4), child: child),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = VColors.ornament
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;
    final p2 = Paint()
      ..color = VColors.ornament.withValues(alpha: .55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    void corner(Offset o, double sx, double sy) {
      canvas.save();
      canvas.translate(o.dx, o.dy);
      canvas.scale(sx, sy);
      canvas.drawPath(Path()..moveTo(1.5, 14.5)..lineTo(1.5, 6.5)..lineTo(6.5, 1.5)..lineTo(14.5, 1.5), p);
      canvas.drawPath(Path()..moveTo(5, 11)..lineTo(5, 7.8)..lineTo(7.8, 5)..lineTo(11, 5), p2);
      canvas.restore();
    }

    const i = 2.0;
    corner(const Offset(i, i), 1, 1);
    corner(Offset(size.width - i, i), -1, 1);
    corner(Offset(i, size.height - i), 1, -1);
    corner(Offset(size.width - i, size.height - i), -1, -1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class VStatTile extends StatelessWidget {
  const VStatTile({super.key, required this.icon, required this.color, required this.value, required this.label});
  final VIcons icon;
  final Color color;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Container(
        height: 84,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
        decoration: BoxDecoration(gradient: VColors.cardGradient, borderRadius: BorderRadius.circular(16), border: Border.all(color: VColors.border)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          VIcon(icon, size: 20, color: color, stroke: 1.8),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            FittedBox(fit: BoxFit.scaleDown, alignment: Alignment.centerLeft, child: Text(value, maxLines: 1, style: VType.cinzel(size: 17, height: 1.15))),
            Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.ash)),
          ]),
        ]),
      );
}

// ---------------------------------------------------------------- buttons
class VPrimaryButton extends StatelessWidget {
  const VPrimaryButton({super.key, required this.label, this.onPressed, this.icon, this.busy = false, this.height = 54, this.leading});
  final String label;
  final VoidCallback? onPressed;
  final VIcons? icon;
  final bool busy;
  final double height;
  final Widget? leading;
  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null && !busy;
    return Semantics(
      button: true,
      enabled: enabled,
      child: Opacity(
        opacity: enabled || busy ? 1 : .45,
        child: Material(
          color: Colors.transparent,
          child: Ink(
            height: height,
            decoration: BoxDecoration(
              gradient: VColors.goldGradient,
              borderRadius: BorderRadius.circular(14),
              boxShadow: enabled ? [BoxShadow(color: VColors.gold.withValues(alpha: .22), blurRadius: 28, offset: const Offset(0, 10))] : null,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(14),
              onTap: enabled
                  ? () {
                      HapticFeedback.lightImpact();
                      onPressed!();
                    }
                  : null,
              child: Center(
                child: busy
                    ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.4, color: VColors.onGold))
                    : Row(mainAxisSize: MainAxisSize.min, children: [
                        if (leading != null) ...[leading!, const SizedBox(width: 10)],
                        if (icon != null) ...[VIcon(icon!, size: 20, color: VColors.onGold, stroke: 2), const SizedBox(width: 10)],
                        Flexible(child: Text(label, overflow: TextOverflow.ellipsis, style: VType.body(size: 16, weight: FontWeight.w800, color: VColors.onGold))),
                      ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VSecondaryButton extends StatelessWidget {
  const VSecondaryButton({super.key, required this.label, this.onPressed, this.icon, this.height = 50, this.color = VColors.goldBright});
  final String label;
  final VoidCallback? onPressed;
  final VIcons? icon;
  final double height;
  final Color color;
  @override
  Widget build(BuildContext context) => Opacity(
        opacity: onPressed == null ? .45 : 1,
        child: Material(
          color: color.withValues(alpha: .07),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: BorderSide(color: color.withValues(alpha: .5))),
          child: InkWell(
            borderRadius: BorderRadius.circular(14),
            onTap: onPressed,
            child: SizedBox(
              height: height,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                if (icon != null) ...[VIcon(icon!, size: 19, color: color, stroke: 1.9), const SizedBox(width: 9)],
                Flexible(child: Text(label, overflow: TextOverflow.ellipsis, style: VType.body(size: 15, weight: FontWeight.w700, color: color))),
              ]),
            ),
          ),
        ),
      );
}

class VGhostButton extends StatelessWidget {
  const VGhostButton({super.key, required this.label, this.onPressed, this.icon, this.color = const Color(0xFFD6CAB4)});
  final String label;
  final VoidCallback? onPressed;
  final VIcons? icon;
  final Color color;
  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(foregroundColor: color, minimumSize: const Size(64, 48)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (icon != null) ...[VIcon(icon!, size: 18, color: color, stroke: 1.9), const SizedBox(width: 8)],
          Text(label, style: VType.body(size: 15, weight: FontWeight.w700, color: color)),
        ]),
      );
}

/// Round icon button used in top bars.
class VRoundButton extends StatelessWidget {
  const VRoundButton({super.key, required this.icon, required this.tooltip, this.onTap, this.dot = false, this.size = 40, this.background});
  final VIcons icon;
  final String tooltip;
  final VoidCallback? onTap;
  final bool dot;
  final double size;
  final Color? background;
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: tooltip,
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: math.max(44, size),
            height: math.max(44, size),
            child: Center(
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: background ?? VColors.bg.withValues(alpha: .55),
                  shape: BoxShape.circle,
                  border: Border.all(color: VColors.bone.withValues(alpha: .12)),
                ),
                child: Stack(alignment: Alignment.center, children: [
                  VIcon(icon, size: size * .52, color: const Color(0xFFE6DAC4), stroke: 1.8),
                  if (dot)
                    Positioned(
                      top: size * .2,
                      right: size * .22,
                      child: Container(width: 8, height: 8, decoration: BoxDecoration(color: VColors.bloodText, shape: BoxShape.circle, border: Border.all(color: VColors.bg, width: 2))),
                    ),
                ]),
              ),
            ),
          ),
        ),
      );
}

class VChip extends StatelessWidget {
  const VChip({super.key, required this.label, this.active = false, this.icon, this.onTap});
  final String label;
  final bool active;
  final VIcons? icon;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final fg = active ? VColors.onGold : const Color(0xFFD8CCB6);
    return Semantics(
      button: true,
      selected: active,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            gradient: active ? VColors.goldGradient : null,
            color: active ? null : VColors.bone.withValues(alpha: .05),
            borderRadius: BorderRadius.circular(99),
            border: Border.all(color: active ? const Color(0xCCF8D183) : VColors.border),
          ),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (icon != null) ...[VIcon(icon!, size: 16, color: fg, stroke: 1.9), const SizedBox(width: 6)],
            Text(label, style: VType.body(size: 13, weight: FontWeight.w700, color: fg)),
          ]),
        ),
      ),
    );
  }
}

class VSegmented extends StatelessWidget {
  const VSegmented({super.key, required this.labels, required this.index, required this.onChanged});
  final List<String> labels;
  final int index;
  final ValueChanged<int> onChanged;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: const Color(0xFF140F0C), borderRadius: BorderRadius.circular(14), border: Border.all(color: VColors.border)),
        child: Row(children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Expanded(
              child: Semantics(
                button: true,
                selected: i == index,
                child: GestureDetector(
                  onTap: () {
                    if (i != index) {
                      HapticFeedback.selectionClick();
                      onChanged(i);
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 36,
                    alignment: Alignment.center,
                    decoration: i == index
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF3A2D22), Color(0xFF2A2019)]),
                            border: Border.all(color: VColors.gold.withValues(alpha: .35)),
                          )
                        : const BoxDecoration(),
                    child: Text(labels[i],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: VType.body(size: 14, weight: i == index ? FontWeight.w800 : FontWeight.w700, color: i == index ? VColors.bone : VColors.ash)),
                  ),
                ),
              ),
            ),
          ],
        ]),
      );
}

/// Primary action that must be held (protects coin spending from mis-taps).
class VHoldButton extends StatefulWidget {
  const VHoldButton({super.key, required this.label, required this.onConfirmed, this.icon = VIcons.beute, this.enabled = true});
  final String label;
  final VoidCallback onConfirmed;
  final VIcons icon;
  final bool enabled;
  @override
  State<VHoldButton> createState() => _VHoldButtonState();
}

class _VHoldButtonState extends State<VHoldButton> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
    ..addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        HapticFeedback.mediumImpact();
        widget.onConfirmed();
        _c.reset();
      }
    });

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      enabled: widget.enabled,
      label: widget.label,
      onTap: widget.enabled ? widget.onConfirmed : null,
      child: GestureDetector(
        onTapDown: widget.enabled ? (_) => _c.forward() : null,
        onTapUp: (_) => _c.reverse(),
        onTapCancel: () => _c.reverse(),
        child: Opacity(
          opacity: widget.enabled ? 1 : .45,
          child: Container(
            height: 56,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFFC99A4E), Color(0xFFA77630)]),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xB3F8D183)),
            ),
            child: Stack(children: [
              AnimatedBuilder(
                animation: _c,
                builder: (_, _) => FractionallySizedBox(widthFactor: _c.value, child: Container(decoration: const BoxDecoration(gradient: VColors.goldGradient))),
              ),
              Center(
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  VIcon(widget.icon, size: 20, color: VColors.onGold, stroke: 2),
                  const SizedBox(width: 10),
                  Text(widget.label, style: VType.body(size: 15.5, weight: FontWeight.w800, color: VColors.onGold)),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------- medals
enum MedalTier { bronze, silver, gold, rune }

class VMedal extends StatelessWidget {
  const VMedal({super.key, required this.tier, required this.icon, this.size = 64, this.locked = false});
  final MedalTier tier;
  final VIcons icon;
  final double size;
  final bool locked;

  static const _metals = {
    MedalTier.bronze: [Color(0xFFF2C08F), Color(0xFFC27A45), Color(0xFF6E3C1A), Color(0xFFF6C9A0)],
    MedalTier.silver: [Color(0xFFFFFFFF), Color(0xFFB9B7B0), Color(0xFF5E5C57), Color(0xFFF1EFEA)],
    MedalTier.gold: [Color(0xFFFFF0B8), Color(0xFFE3A645), Color(0xFF7A4E14), Color(0xFFFFE39A)],
    MedalTier.rune: [Color(0xFFDDF6FC), Color(0xFF6FB3C8), Color(0xFF1F4A57), Color(0xFFC4EEF8)],
  };

  @override
  Widget build(BuildContext context) {
    final m = locked ? const [Color(0xFF6E6861), Color(0xFF3F3A35), Color(0xFF211E1B), Color(0xFF5E5750)] : _metals[tier]!;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(center: const Alignment(-.3, -.44), colors: [m[0], m[1], m[2]], stops: const [0, .45, 1]),
            boxShadow: [
              const BoxShadow(color: Color(0x8C000000), blurRadius: 10, offset: Offset(0, 4)),
              if (!locked) BoxShadow(color: m[1].withValues(alpha: .27), blurRadius: size / 4),
            ],
          ),
          child: Container(
            width: size * .72,
            height: size * .72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(center: Alignment(-.2, -.4), colors: [Color(0xFF3A2C1E), Color(0xFF150F0A)]),
              border: Border.all(color: m[3].withValues(alpha: .53), width: 1.5),
            ),
            child: VIcon(icon, size: size * .38, color: m[3], stroke: 1.8),
          ),
        ),
        if (locked)
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: size * .36,
              height: size * .36,
              alignment: Alignment.center,
              decoration: BoxDecoration(color: const Color(0xFF1A1512), shape: BoxShape.circle, border: Border.all(color: const Color(0xFF4A423B))),
              child: VIcon(VIcons.lock, size: size * .2, color: const Color(0xFF8C8277), stroke: 2),
            ),
          ),
      ]),
    );
  }
}

// ---------------------------------------------------------------- hero art
class VPortrait extends StatelessWidget {
  const VPortrait({super.key, required this.level, this.form = HeroForm.hero, this.size = 44, this.ring = true});
  final int level;
  final HeroForm form;
  final double size;
  final bool ring;
  @override
  Widget build(BuildContext context) {
    final c = VColors.level(level);
    return Container(
      width: size + (ring ? 8 : 0),
      height: size + (ring ? 8 : 0),
      alignment: Alignment.center,
      decoration: ring ? BoxDecoration(shape: BoxShape.circle, border: Border.all(color: c, width: 2)) : null,
      child: ClipOval(child: VArt.image(VArt.portrait(level, form), width: size, height: size, alignment: const Alignment(0, -.5))),
    );
  }
}

/// Hero standing on the backdrop of their level, with embers and a ground shadow.
class VHeroStage extends StatelessWidget {
  const VHeroStage({
    super.key,
    required this.level,
    this.form = HeroForm.hero,
    required this.height,
    required this.heroHeight,
    required this.heroTop,
    this.embers = true,
    this.companion,
    this.backdropLevel,
  });
  final int level;
  final HeroForm form;
  final double height;
  final double heroHeight;
  final double heroTop;
  final bool embers;
  final String? companion;
  final int? backdropLevel;

  @override
  Widget build(BuildContext context) {
    final heroW = heroHeight * 380 / 916;
    return SizedBox(
      height: height,
      child: Stack(clipBehavior: Clip.hardEdge, fit: StackFit.expand, children: [
        Positioned.fill(child: Opacity(opacity: .95, child: VArt.image(VArt.stage(backdropLevel ?? level), alignment: const Alignment(0, -.3)))),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xC70E0B09), Color(0x400E0B09), Color(0x1A0E0B09), Color(0x8C0E0B09), VColors.bg],
              stops: [0, .22, .5, .78, 1],
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment(0, ((heroTop + heroHeight / 2) / height) * 2 - 1),
              radius: .75,
              colors: const [Color(0xD90E0B09), Color(0x000E0B09)],
            ),
          ),
        ),
        if (embers) const VEmbers(opacity: .55),
        Positioned(
          top: heroTop + heroHeight - 26,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: heroW * 1.5,
              height: 44,
              decoration: const BoxDecoration(gradient: RadialGradient(colors: [Color(0xBF000000), Color(0x00000000)], stops: [0, .7])),
            ),
          ),
        ),
        Positioned(
          top: heroTop,
          left: 0,
          right: 0,
          child: Center(child: VArt.image(VArt.hero(level, form), width: heroW, height: heroHeight, fit: BoxFit.contain)),
        ),
        if (companion != null && VArt.paintedItems.contains(companion))
          Positioned(
            top: heroTop + heroHeight - heroHeight * .3,
            left: 0,
            right: 0,
            child: Center(
              child: Transform.translate(
                offset: Offset(-heroW * .72, 0),
                child: SizedBox(width: heroHeight * .28, height: heroHeight * .28, child: VItemArt(assetKey: companion!, slot: ItemSlot.companion, size: heroHeight * .28)),
              ),
            ),
          ),
      ]),
    );
  }
}

/// Item artwork: painted art where available, otherwise the SVG placeholder.
class VItemArt extends StatelessWidget {
  const VItemArt({super.key, required this.assetKey, required this.slot, this.size = 64});
  final String assetKey;
  final ItemSlot slot;
  final double size;
  @override
  Widget build(BuildContext context) {
    if (!VArt.paintedItems.contains(assetKey)) return ItemPreview(assetKey: assetKey, slot: slot, size: size);
    return ShaderMask(
      shaderCallback: (r) => const RadialGradient(colors: [Colors.white, Colors.white, Colors.transparent], stops: [0, .72, 1]).createShader(r),
      blendMode: BlendMode.dstIn,
      child: VArt.image(VArt.item(assetKey), width: size, height: size, fit: BoxFit.contain),
    );
  }
}

/// Reward artwork tile: remote image when set, else a styled token per type.
class VRewardArt extends StatelessWidget {
  const VRewardArt({super.key, required this.type, this.imageUrl, this.height = 112, this.radius = const BorderRadius.vertical(top: Radius.circular(15))});
  final RewardType type;
  final String? imageUrl;
  final double height;
  final BorderRadius radius;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl;
    Widget child;
    if (url != null && url.startsWith('http')) {
      child = Image.network(url, fit: BoxFit.cover, errorBuilder: (_, _, _) => _token());
    } else {
      child = _token();
    }
    return ClipRRect(borderRadius: radius, child: SizedBox(height: height, width: double.infinity, child: child));
  }

  Widget _token() {
    const warm = [Color(0xFF2A1F16), Color(0xFF18120E)];
    Widget glow(Widget c, {List<Color> bg = warm, Color g = VColors.gold}) => DecoratedBox(
          decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: bg)),
          child: DecoratedBox(
            decoration: BoxDecoration(gradient: RadialGradient(colors: [g.withValues(alpha: .22), g.withValues(alpha: 0)], radius: .65)),
            child: Center(child: c),
          ),
        );
    return switch (type) {
      RewardType.drink => glow(VCoin(size: height * .5)),
      RewardType.discount => glow(Text('%', style: VType.cinzel(size: height * .4, color: VColors.goldBright, weight: FontWeight.w800))),
      RewardType.priorityBooking =>
        glow(VIcon(VIcons.calendar, size: height * .38, color: VColors.frostBright, stroke: 1.5), bg: const [Color(0xFF1A2226), Color(0xFF12100E)], g: VColors.frost),
      RewardType.eventAccess => Stack(fit: StackFit.expand, children: [
          VArt.image(VArt.scene('hall')),
          const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x000E0B09), Color(0x990E0B09)]))),
          Center(child: VIcon(VIcons.music, size: height * .3, color: const Color(0xFFFFE2AE), stroke: 1.6)),
        ]),
      RewardType.merch => glow(VIcon(VIcons.shirt, size: height * .42, color: const Color(0xFFD9C6A4), stroke: 1.4), bg: const [Color(0xFF221A14), Color(0xFF141010)]),
    };
  }
}

/// Modal sheet with the design's handle and gold edge.
Future<T?> showVSheet<T>(BuildContext context, {required WidgetBuilder builder, bool scrollControlled = true}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: scrollControlled,
    useRootNavigator: true,
    useSafeArea: true,
    barrierColor: const Color(0xB8070504),
    backgroundColor: Colors.transparent,
    builder: (ctx) => Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF201813), Color(0xFF140F0C)], stops: [0, .4]),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        border: Border(top: BorderSide(color: VColors.ornament.withValues(alpha: .55))),
      ),
      child: SafeArea(
        top: false,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 5, margin: const EdgeInsets.only(top: 10, bottom: 10), decoration: BoxDecoration(color: const Color(0xFF4A3E34), borderRadius: BorderRadius.circular(5))),
          Flexible(child: builder(ctx)),
        ]),
      ),
    ),
  );
}
