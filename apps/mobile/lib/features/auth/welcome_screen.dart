import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/locale.dart';
import '../../shared/sheets.dart';
import 'auth_service.dart';

/// First screen for signed-out guests: the journey from Thrallin to Valkyrja,
/// then Apple / Google / email.
class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});
  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() fn) async {
    setState(() => _busy = true);
    try {
      await fn();
    } on ApiError catch (e) {
      if (mounted) showSnack(context, L10n.of(context).authError(e.message), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final auth = ref.read(authServiceProvider);
    Widget hero(int level, HeroForm form, double h, {double opacity = 1, bool glow = false}) {
      final w = h * 380 / 916;
      Widget img = VArt.image(VArt.hero(level, form), width: w, height: h, fit: BoxFit.contain);
      if (glow) {
        img = DecoratedBox(
          decoration: BoxDecoration(boxShadow: [BoxShadow(color: const Color(0xFFF5D282).withValues(alpha: .25), blurRadius: 40)]),
          child: img,
        );
      }
      return Opacity(opacity: opacity, child: img);
    }

    Widget tag(int level, String name) => Column(mainAxisSize: MainAxisSize.min, children: [
          VLevelBadge(level: level, size: 28),
          const SizedBox(height: 6),
          Text(name.toUpperCase(), style: VType.cinzel(size: 10.5, color: VColors.level(level), spacing: 1.2)),
        ]);

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        child: Stack(children: [
          Positioned(left: 0, right: 0, top: 0, height: 520, child: Opacity(opacity: .5, child: VArt.image(VArt.scene('hall')))),
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            height: 522,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x990E0B09), Color(0xB30E0B09), VColors.bg], stops: [0, .6, 1]),
              ),
            ),
          ),
          const Positioned(left: 0, right: 0, top: 0, height: 520, child: VEmbers(opacity: .6)),
          SafeArea(
            child: LayoutBuilder(builder: (context, c) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: c.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(children: [
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 340,
                        child: Stack(alignment: Alignment.bottomCenter, children: [
                          Positioned(left: 0, bottom: 58, child: hero(1, HeroForm.heroine, 240, opacity: .8)),
                          Positioned(right: 0, bottom: 58, child: hero(8, HeroForm.heroine, 250, glow: true)),
                          Positioned(bottom: 52, child: hero(4, HeroForm.hero, 290)),
                          Positioned(left: 0, bottom: 0, width: 110, child: tag(1, 'Thrallin')),
                          Positioned(bottom: 0, child: tag(4, 'Huskarl')),
                          Positioned(right: 0, bottom: 0, width: 110, child: tag(8, 'Valkyrja')),
                        ]),
                      ),
                      const SizedBox(height: 26),
                      Align(alignment: Alignment.centerLeft, child: VEyebrow(t.appName, color: VColors.gold)),
                      const SizedBox(height: 10),
                      Text(t.welcomeHeadline, style: VType.cinzel(size: 27, height: 1.22)),
                      const SizedBox(height: 10),
                      Text(t.welcomeBody, style: VType.body(size: 15, color: VColors.ash, height: 1.5)),
                      const SizedBox(height: 22),
                      _AppleButton(label: t.continueWithApple, onTap: _busy ? null : () => _run(auth.signInWithApple)),
                      const SizedBox(height: 10),
                      Row(children: [
                        Expanded(
                          child: _DarkButton(
                            onTap: _busy ? null : () => _run(auth.signInWithGoogle),
                            leading: Text('G', style: VType.body(size: 17, weight: FontWeight.w800, color: const Color(0xFF8AB4F8))),
                            label: 'Google',
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _DarkButton(
                            onTap: () => context.push('/login'),
                            leading: const VIcon(VIcons.mail, size: 19, color: VColors.bone, stroke: 1.8),
                            label: t.continueWithEmail,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 6),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(t.alreadyHaveAccount, style: VType.body(size: 14, color: VColors.ash)),
                        TextButton(onPressed: () => context.push('/login'), child: Text(t.signIn)),
                      ]),
                      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), border: Border.all(color: const Color(0xFF5A4C40))),
                          child: Text('18+', style: VType.body(size: 10, weight: FontWeight.w800, color: VColors.parchment)),
                        ),
                        const SizedBox(width: 8),
                        Text(t.adultsOnlyFooter, style: VType.body(size: 12, color: VColors.ash)),
                      ]),
                      const SizedBox(height: 16),
                    ]),
                  ),
                ),
              );
            }),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: GestureDetector(
                  onTap: () => showLanguageSheet(context, ref),
                  child: Container(
                    height: 36,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(color: VColors.bg.withValues(alpha: .7), borderRadius: BorderRadius.circular(99), border: Border.all(color: VColors.border)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const VIcon(VIcons.globe, size: 16, color: VColors.parchment, stroke: 1.8),
                      const SizedBox(width: 6),
                      Text(languageName(ref.watch(uiLocaleProvider)), style: VType.body(size: 13, weight: FontWeight.w800)),
                      const VIcon(VIcons.chevDown, size: 14, color: VColors.ash, stroke: 2),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class _AppleButton extends StatelessWidget {
  const _AppleButton({required this.label, this.onTap});
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
        color: const Color(0xFFF4EEE2),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: SizedBox(
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Icon(Icons.apple, size: 22, color: VColors.bg),
              const SizedBox(width: 8),
              Text(label, style: VType.body(size: 15, weight: FontWeight.w800, color: VColors.bg)),
            ]),
          ),
        ),
      );
}

class _DarkButton extends StatelessWidget {
  const _DarkButton({required this.leading, required this.label, this.onTap});
  final Widget leading;
  final String label;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) => Material(
        color: const Color(0xFF1F1814),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14), side: const BorderSide(color: VColors.border)),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: SizedBox(
            height: 50,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              leading,
              const SizedBox(width: 9),
              Text(label, style: VType.body(size: 15, weight: FontWeight.w700)),
            ]),
          ),
        ),
      );
}
