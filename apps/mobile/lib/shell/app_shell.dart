import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shared/ui.dart';


/// Four tabs around the raised "Scannen" action: the core loop is one tap away.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: VColors.bg,
      extendBody: true,
      body: Stack(children: [shell, const StatusBarScrim()]),
      bottomNavigationBar: VTabBar(
        index: shell.currentIndex,
        onTab: (i) => shell.goBranch(i, initialLocation: i == shell.currentIndex),
        onVisit: () => context.push('/scan'),
      ),
    );
  }
}

class VTabBar extends StatelessWidget {
  const VTabBar({super.key, required this.index, required this.onTab, required this.onVisit});
  final int index;
  final ValueChanged<int> onTab;
  final VoidCallback onVisit;

  /// Room above the bar for the raised scan button (kept inside the bar's
  /// bounds so the whole button is painted and tappable).
  static const _raise = 24.0;
  static const _barHeight = 66.0;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final bottom = MediaQuery.paddingOf(context).bottom;
    Widget tab(int i, VTabIcons icon, String label) {
      final on = i == index;
      return Expanded(
        child: Semantics(
          button: true,
          selected: on,
          label: label,
          excludeSemantics: true,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              HapticFeedback.selectionClick();
              onTab(i);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 9),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
                  VTabIcon(icon, active: on),
                  if (on)
                    Positioned(
                      top: -10,
                      child: Container(
                        width: 18,
                        height: 2,
                        decoration: BoxDecoration(color: VColors.gold, borderRadius: BorderRadius.circular(2), boxShadow: const [BoxShadow(color: VColors.gold, blurRadius: 8)]),
                      ),
                    ),
                ]),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(label, maxLines: 1, style: VType.body(size: 11, weight: on ? FontWeight.w800 : FontWeight.w700, color: on ? VColors.bone : const Color(0xFF9A8F80))),
                  ),
                ),
              ]),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: _raise + _barHeight + bottom,
      child: Stack(clipBehavior: Clip.none, children: [
        // bar surface: frosted, with a soft shadow above it
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          height: _barHeight + bottom,
          child: DecoratedBox(
            decoration: const BoxDecoration(boxShadow: [BoxShadow(color: Color(0x73000000), blurRadius: 30, offset: Offset(0, -12))]),
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color(0xFF16110D).withValues(alpha: .96), VColors.bg.withValues(alpha: .98)],
                    ),
                    border: const Border(top: BorderSide(color: VColors.border)),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: _raise - 1,
          child: Container(
            height: 1,
            decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0x00B98A3E), Color(0x8CB98A3E), Color(0x00B98A3E)])),
          ),
        ),
        Positioned(
          left: 8,
          right: 8,
          top: _raise,
          height: _barHeight,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            tab(0, VTabIcons.held, t.tabHero),
            tab(1, VTabIcons.events, t.tabEvents),
            const Spacer(),
            tab(2, VTabIcons.saga, t.tabSaga),
            tab(3, VTabIcons.beute, t.tabShop),
          ]),
        ),
        // raised scan action over the middle slot
        Positioned(
          left: 8,
          right: 8,
          top: 0,
          height: _raise + _barHeight,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Spacer(flex: 2),
            Expanded(child: _ScanButton(label: t.tabScan, onTap: onVisit)),
            const Spacer(flex: 2),
          ]),
        ),
      ]),
    );
  }
}

class _ScanButton extends StatelessWidget {
  const _ScanButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: L10n.of(context).scanTitle,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            HapticFeedback.mediumImpact();
            onTap();
          },
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF8D183), Color(0xFFE7AB4C), Color(0xFFC98B30)],
                ),
                border: Border.all(color: VColors.bg, width: 3),
                boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .22), blurRadius: 28, offset: const Offset(0, 10))],
              ),
              foregroundDecoration: const _Bevel(),
              child: const Center(child: VAddGlyph()),
            ),
            // label on the same line as the other tabs' labels
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(label, maxLines: 1, style: VType.body(size: 11, weight: FontWeight.w800, color: VColors.goldBright, spacing: .2)),
            ),
          ]),
        ),
      );
}

/// Inset bevel of the scan button: a light rim on top, a darker one below.
class _Bevel extends Decoration {
  const _Bevel();
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) => _BevelPainter();
}

class _BevelPainter extends BoxPainter {
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final size = configuration.size!;
    final rect = (offset & size).deflate(4);
    canvas.drawArc(rect, 3.6, 2.2, false, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xBFFFF4D6));
    canvas.drawArc(rect.deflate(.5), .5, 2.1, false, Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = const Color(0x596E400A));
  }
}
