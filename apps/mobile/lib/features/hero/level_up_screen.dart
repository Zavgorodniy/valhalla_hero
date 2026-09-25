import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'item_tile.dart';

/// Full-screen celebration when a new level is reached.
class LevelUpScreen extends ConsumerStatefulWidget {
  const LevelUpScreen({super.key, this.from});
  final int? from;
  @override
  ConsumerState<LevelUpScreen> createState() => _LevelUpScreenState();
}

class _LevelUpScreenState extends ConsumerState<LevelUpScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(vsync: this, duration: const Duration(seconds: 24))..repeat();
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    HapticFeedback.heavyImpact();
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final profile = ref.watch(profileProvider).valueOrNull;
    final levels = ref.watch(levelMapProvider);
    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    if (profile == null) return const SizedBox.shrink();
    final lvl = profile.level;
    final from = widget.from ?? math.max(1, lvl - 1);
    final form = profile.heroForm;
    final c = VColors.level(lvl);
    final name = levelName(levels, lvl, form);
    final level = levels[lvl];
    final before = levels[from];
    final unlocked = items.where((i) => i.source == ItemSource.level && i.unlockLevel == lvl).toList();
    final newItem = unlocked.firstOrNull;
    const scenes = ['', 'Küste', 'Dorf', 'Fjord', 'Langhaus-Tor', 'Sturm', 'Große Halle', 'Festung', 'Walhalla'];

    Widget row(Widget thumb, String title, String sub, [Widget? trailing]) => Row(children: [
          thumb,
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: VType.body(size: 14.5, weight: FontWeight.w800)),
              Text(sub, style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
            ]),
          ),
          ?trailing,
        ]);
    Widget box(Widget child, Color border) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: const Color(0xFF241A10), borderRadius: BorderRadius.circular(12), border: Border.all(color: border)),
          clipBehavior: Clip.antiAlias,
          child: Center(child: child),
        );

    return Scaffold(
      backgroundColor: VColors.bg,
      body: Stack(fit: StackFit.expand, children: [
        Opacity(opacity: .9, child: VArt.image(VArt.stage(lvl))),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xB30E0B09), Color(0x4D0E0B09), Color(0x8C0E0B09), VColors.bg],
              stops: [0, .3, .55, .72],
            ),
          ),
        ),
        SafeArea(
          child: LayoutBuilder(builder: (context, box0) {
            const ringCy = 250.0;
            return Stack(children: [
              Positioned(
                left: 0,
                right: 0,
                top: ringCy - 190,
                child: Center(
                  child: Container(
                    width: 380,
                    height: 380,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(colors: [c.withValues(alpha: .45), c.withValues(alpha: .15), c.withValues(alpha: 0)], stops: const [0, .42, .68]),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: ringCy - 176,
                child: Center(
                  child: RotationTransition(
                    turns: _c,
                    child: SizedBox(width: 352, height: 352, child: CustomPaint(painter: _RuneRing(color: Color.lerp(c, VColors.goldBright, .4)!))),
                  ),
                ),
              ),
              const Positioned.fill(child: VEmbers(opacity: 1)),
              Positioned(
                top: 6,
                right: 8,
                child: VRoundButton(icon: VIcons.close, tooltip: t.close, onTap: () => context.go('/hero')),
              ),
              Positioned(left: 0, right: 0, top: 18, child: Center(child: VEyebrow(t.levelReached(romanLevel(lvl)).replaceAll('!', ''), color: Color.lerp(c, Colors.white, .45)!, size: 13))),
              Positioned(
                left: 0,
                right: 0,
                top: 50,
                child: Center(child: VArt.image(VArt.hero(lvl, form), height: 370, width: 370 * 380 / 916, fit: BoxFit.contain)),
              ),
              Positioned(
                left: 20,
                right: 20,
                top: 420,
                bottom: 0,
                child: SingleChildScrollView(
                  child: Column(children: [
                    ShaderMask(
                      shaderCallback: (r) => LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [const Color(0xFFFFE3B0), Color.lerp(c, VColors.goldBright, .3)!, Color.lerp(c, Colors.black, .2)!],
                      ).createShader(r),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(name.toUpperCase(), style: VType.cinzel(size: 44, weight: FontWeight.w800, spacing: 3, color: Colors.white, height: 1)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (level != null) Text(level.tagline(locale), style: VType.body(size: 15, weight: FontWeight.w600, color: const Color(0xFFE3CDB0))),
                    const SizedBox(height: 18),
                    VCard(
                      padding: const EdgeInsets.all(14),
                      child: Column(children: [
                        if (level != null)
                          row(
                            box(const VCoin(size: 24), VColors.gold.withValues(alpha: .4)),
                            t.coinBonus(multiplierText(level.coinMultiplier, locale)),
                            t.coinBonusSub(multiplierText(before?.coinMultiplier ?? 1, locale)),
                          ),
                        for (final it in unlocked) ...[
                          const Divider(height: 20),
                          row(
                            box(VItemArt(assetKey: it.assetKey, slot: it.slot, size: 36), VColors.rarity(it.rarity).withValues(alpha: .45)),
                            it.name(locale),
                            t.newGear,
                            VRarityChip(rarity: it.rarity, label: rarityName(t, it.rarity), small: true),
                          ),
                        ],
                        const Divider(height: 20),
                        row(box(VArt.image(VArt.stage(lvl), width: 40, height: 40), c.withValues(alpha: .5)), t.newBackdrop, scenes[lvl.clamp(1, 8)]),
                      ]),
                    ),
                    const SizedBox(height: 16),
                    Row(children: [
                      Expanded(
                        child: VPrimaryButton(
                          label: newItem == null ? t.continueLabel : t.equipItem(newItem.name(locale)),
                          icon: newItem == null ? null : slotIcon(newItem.slot),
                          busy: _busy,
                          onPressed: () async {
                            if (newItem == null) return context.go('/hero');
                            setState(() => _busy = true);
                            try {
                              await ItemActions.equip(ref, newItem);
                            } finally {
                              if (context.mounted) context.go('/hero');
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      VRoundButton(icon: VIcons.share, tooltip: t.shareLevel, size: 54, background: VColors.surface2, onTap: () => Share.share(t.shareLevelText(name))),
                    ]),
                    if (newItem != null) VGhostButton(label: t.later, onPressed: () => context.go('/hero')),
                    const SizedBox(height: 16),
                  ]),
                ),
              ),
            ]);
          }),
        ),
      ]),
    );
  }
}

class _RuneRing extends CustomPainter {
  _RuneRing({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final r = size.width / 2;
    canvas.drawCircle(center, r, Paint()
      ..color = color.withValues(alpha: .5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);
    canvas.drawCircle(center, r, Paint()
      ..color = color.withValues(alpha: .35)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12));
    final dash = Paint()
      ..color = color.withValues(alpha: .45)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    const n = 48;
    for (var i = 0; i < n; i += 2) {
      canvas.drawArc(Rect.fromCircle(center: center, radius: r - 36), i * 2 * math.pi / n, math.pi / n, false, dash);
    }
    final runes = safeRunes.replaceAll(' ', '');
    final glyphs = (runes + runes).characters.take(24).toList();
    for (var i = 0; i < glyphs.length; i++) {
      final a = i / glyphs.length * 2 * math.pi;
      final tp = TextPainter(
        text: TextSpan(text: glyphs[i], style: VType.runes(size: 15, color: color.withValues(alpha: .8), spacing: 0)),
        textDirection: TextDirection.ltr,
      )..layout();
      canvas.save();
      canvas.translate(center.dx + (r - 18) * math.sin(a), center.dy - (r - 18) * math.cos(a));
      canvas.rotate(a);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant _RuneRing old) => old.color != color;
}
