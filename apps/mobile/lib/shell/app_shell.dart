import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';


/// Four tabs around a raised "Besuch" action: the core loop is one tap away.
class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.shell});
  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: VColors.bg,
      extendBody: true,
      body: shell,
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

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final bottom = MediaQuery.paddingOf(context).bottom;
    Widget tab(int i, VIcons icon, String label) {
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
              padding: const EdgeInsets.only(top: 10),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Stack(clipBehavior: Clip.none, alignment: Alignment.topCenter, children: [
                  VIcon(icon, size: 24, color: on ? VColors.goldBright : const Color(0xFF8F8475), stroke: on ? 1.9 : 1.7),
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

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: 66 + bottom,
          padding: EdgeInsets.only(left: 8, right: 8, bottom: bottom),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xFF16110D).withValues(alpha: .92), VColors.bg.withValues(alpha: .98)],
            ),
            border: const Border(top: BorderSide(color: VColors.border)),
          ),
          child: Stack(clipBehavior: Clip.none, children: [
            Positioned(
              left: 0,
              right: 0,
              top: -1,
              child: Container(
                height: 1,
                decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0x00B98A3E), Color(0x8CB98A3E), Color(0x00B98A3E)])),
              ),
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              tab(0, VIcons.held, t.tabHero),
              tab(1, VIcons.calendar, t.tabEvents),
              Expanded(child: _VisitButton(label: t.tabScan, onTap: onVisit)),
              tab(2, VIcons.saga, t.tabSaga),
              tab(3, VIcons.beute, t.tabShop),
            ]),
          ]),
        ),
      ),
    );
  }
}

class _VisitButton extends StatelessWidget {
  const _VisitButton({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        label: L10n.of(context).scanTitle,
        excludeSemantics: true,
        child: GestureDetector(
          onTap: () {
            HapticFeedback.mediumImpact();
            onTap();
          },
          child: OverflowBox(
            alignment: Alignment.topCenter,
            maxHeight: 120,
            child: Transform.translate(
            offset: const Offset(0, -20),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: VColors.goldGradient,
                  border: Border.all(color: VColors.bg, width: 3),
                  boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .3), blurRadius: 22, offset: const Offset(0, 6))],
                ),
                child: const Center(child: VIcon(VIcons.scan, size: 28, color: Color(0xFF2A1A08), stroke: 2.1)),
              ),
              const SizedBox(height: 4),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(label, maxLines: 1, style: VType.body(size: 11, weight: FontWeight.w800, color: VColors.goldBright)),
              ),
            ]),
          ),
          ),
        ),
      );
}
