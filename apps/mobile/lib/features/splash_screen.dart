import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

/// Brand wordmark: gold VALHALLA with a spaced HERO line.
class Wordmark extends StatelessWidget {
  const Wordmark({super.key, this.size = 46});
  final double size;
  @override
  Widget build(BuildContext context) {
    final line = Container(width: 42, height: 1, decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0x00B98A3E), VColors.ornament])));
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ShaderMask(
        shaderCallback: (r) => const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFEBB8), Color(0xFFE8AE4E), Color(0xFFA26F28)],
          stops: [0, .55, 1],
        ).createShader(r),
        child: Text('VALHALLA', style: VType.cinzel(size: size, spacing: size * .1, color: Colors.white, height: 1)),
      ),
      SizedBox(height: size * .18),
      Row(mainAxisSize: MainAxisSize.min, children: [
        line,
        const SizedBox(width: 12),
        Padding(
          padding: EdgeInsets.only(left: size * .27),
          child: Text('HERO', style: VType.cinzel(size: size * .39, weight: FontWeight.w600, spacing: size * .27, color: const Color(0xFFD9B878))),
        ),
        const SizedBox(width: 12),
        Transform.flip(flipX: true, child: line),
      ]),
    ]);
  }
}

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);
    final t = L10n.of(context);
    return Scaffold(
      backgroundColor: VColors.bg,
      body: Stack(fit: StackFit.expand, children: [
        ImageFiltered(imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3), child: Opacity(opacity: .8, child: VArt.image(VArt.scene('hall')))),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(center: Alignment(0, -.2), radius: .9, colors: [Color(0x260E0B09), Color(0xE00E0B09)], stops: [0, .8]),
          ),
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x800E0B09), Color(0x000E0B09), VColors.bg], stops: [0, .35, .95]),
          ),
        ),
        const VEmbers(opacity: .85),
        SafeArea(
          child: Column(children: [
            const Spacer(flex: 3),
            Container(
              width: 148,
              height: 148,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(34),
                boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .35), blurRadius: 60), const BoxShadow(color: Color(0xA6000000), blurRadius: 40, offset: Offset(0, 20))],
                border: Border.all(color: VColors.gold.withValues(alpha: .45)),
              ),
              clipBehavior: Clip.antiAlias,
              child: VArt.image(VArt.scene('icon')),
            ),
            const SizedBox(height: 28),
            const Wordmark(),
            const SizedBox(height: 26),
            Text(t.appTagline, style: VType.body(size: 16, weight: FontWeight.w600, color: const Color(0xFFD8CCB6))),
            const Spacer(flex: 2),
            if (profile.hasError) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text('${profile.error}', textAlign: TextAlign.center, style: VType.body(size: 12, color: VColors.ash)),
              ),
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                VGhostButton(label: t.retry, onPressed: () => ref.read(profileProvider.notifier).refresh()),
                VGhostButton(label: t.signOut, onPressed: () => ref.read(supabaseProvider).auth.signOut()),
              ]),
            ] else
              SizedBox(
                width: 132,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: const LinearProgressIndicator(minHeight: 3, color: VColors.goldBright, backgroundColor: Color(0xFF2A2019)),
                ),
              ),
            const SizedBox(height: 22),
            Text(safeRunes, style: VType.runes(size: 15, spacing: 6), textAlign: TextAlign.center),
            const SizedBox(height: 40),
          ]),
        ),
      ]),
    );
  }
}
