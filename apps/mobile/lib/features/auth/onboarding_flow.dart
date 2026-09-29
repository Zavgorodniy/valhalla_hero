import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'auth_service.dart';

enum OnboardingMode { emailSignup, completeProfile }

/// Email sign-up (account → age & consents → hero) or, after a social login,
/// the last two steps only. The hero step picks Held/Heldin and the name.
class OnboardingFlow extends ConsumerStatefulWidget {
  const OnboardingFlow({super.key, required this.mode});
  final OnboardingMode mode;
  @override
  ConsumerState<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends ConsumerState<OnboardingFlow> {
  late int _step = widget.mode == OnboardingMode.emailSignup ? 0 : 1;
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _day = TextEditingController();
  final _month = TextEditingController();
  final _year = TextEditingController();
  final _nick = TextEditingController();
  bool _terms = false;
  bool _pushConsent = false;
  bool _offersConsent = false;
  HeroForm _form = HeroForm.hero;
  bool _busy = false;

  int get _total => widget.mode == OnboardingMode.emailSignup ? 3 : 2;
  int get _stepNo => widget.mode == OnboardingMode.emailSignup ? _step + 1 : _step;

  @override
  void dispose() {
    for (final c in [_email, _password, _day, _month, _year, _nick]) {
      c.dispose();
    }
    super.dispose();
  }

  DateTime? get _birth {
    final d = int.tryParse(_day.text), m = int.tryParse(_month.text), y = int.tryParse(_year.text);
    if (d == null || m == null || y == null || y < 1900 || m < 1 || m > 12 || d < 1 || d > 31) return null;
    final date = DateTime(y, m, d);
    return date.month == m ? date : null;
  }

  bool get _accountValid => _email.text.contains('@') && _password.text.length >= 8;
  bool get _ageValid => _birth != null && isAdult(_birth!) && _terms;
  bool get _heroValid => _nick.text.trim().length >= 3 && _nick.text.trim().length <= 20;

  void _back() {
    if (_step > (widget.mode == OnboardingMode.emailSignup ? 0 : 1)) {
      setState(() => _step--);
    } else if (widget.mode == OnboardingMode.emailSignup) {
      context.canPop() ? context.pop() : context.go('/welcome');
    } else {
      ref.read(authServiceProvider).signOut();
    }
  }

  Future<void> _finish() async {
    final t = L10n.of(context);
    final locale = supportedLanguage(Localizations.localeOf(context).languageCode);
    setState(() => _busy = true);
    try {
      if (widget.mode == OnboardingMode.emailSignup) {
        await ref.read(authServiceProvider).signUp(
              email: _email.text.trim(),
              password: _password.text,
              nickname: _nick.text.trim(),
              birthDate: _birth!,
              locale: locale,
              heroForm: _form,
            );
        // projects with email confirmation return no session until the link is opened
        if (ref.read(supabaseProvider).auth.currentSession == null) {
          if (mounted) await _confirmEmail(_email.text.trim());
          return;
        }
        if (_pushConsent || _offersConsent) {
          await ref.read(profileRepoProvider).update(pushMarketingConsent: _pushConsent, personalisedOffersConsent: _offersConsent);
          ref.invalidate(profileProvider);
        }
      } else {
        final notifier = ref.read(profileProvider.notifier);
        await notifier.completeOnboarding(nickname: _nick.text.trim(), birthDate: _birth!, locale: locale, heroForm: _form);
        if (_pushConsent || _offersConsent) {
          await notifier.updateProfile(pushMarketingConsent: _pushConsent, personalisedOffersConsent: _offersConsent);
        }
      }
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.code == ApiErrorCode.ageRestricted ? t.ageGateError : t.authError(e.message), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirmEmail(String email) async {
    final t = L10n.of(context);
    await showVSheet<void>(
      context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const VIcon(VIcons.mail, size: 44, color: VColors.goldBright, stroke: 1.6),
          const SizedBox(height: 14),
          Text(t.signupConfirmTitle, textAlign: TextAlign.center, style: VType.cinzel(size: 22)),
          const SizedBox(height: 10),
          Text(t.signupConfirmBody(email), textAlign: TextAlign.center, style: VType.body(size: 15, color: VColors.ash, height: 1.45)),
          const SizedBox(height: 20),
          VPrimaryButton(label: t.gotIt, onPressed: () => Navigator.pop(ctx)),
        ]),
      ),
    );
    if (mounted) context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return VScreen(
      glow: VColors.gold,
      child: SafeArea(
        child: Column(children: [
          VTopBar(
            back: true,
            onBack: _back,
            actions: [
              Text(t.stepOf(_stepNo, _total), style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.ash, tabular: true)),
              const SizedBox(width: 8),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              for (var i = 1; i <= _total; i++) ...[
                if (i > 1) const SizedBox(width: 6),
                Expanded(
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 4,
                    decoration: BoxDecoration(
                      color: i <= _stepNo ? VColors.gold : const Color(0xFF2E251E),
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: i == _stepNo ? [BoxShadow(color: VColors.gold.withValues(alpha: .5), blurRadius: 8)] : null,
                    ),
                  ),
                ),
              ],
            ]),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(key: ValueKey(_step), child: switch (_step) { 0 => _account(t), 1 => _age(t), _ => _hero(t) }),
            ),
          ),
        ]),
      ),
    );
  }

  // ---------------------------------------------------------------- step 0
  Widget _account(L10n t) => ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 32), children: [
        Text(t.createAccount, style: VType.cinzel(size: 27, height: 1.2)),
        const SizedBox(height: 22),
        _label(t.email),
        TextField(controller: _email, keyboardType: TextInputType.emailAddress, autocorrect: false, onChanged: (_) => setState(() {}), style: VType.body(size: 16, weight: FontWeight.w600)),
        const SizedBox(height: 16),
        _label(t.password),
        TextField(controller: _password, obscureText: true, onChanged: (_) => setState(() {}), style: VType.body(size: 16, weight: FontWeight.w600)),
        const SizedBox(height: 6),
        Text('≥ 8', style: VType.body(size: 12, color: VColors.ash)),
        const SizedBox(height: 24),
        VPrimaryButton(label: t.continueLabel, onPressed: _accountValid ? () => setState(() => _step = 1) : null),
      ]);

  // ---------------------------------------------------------------- step 1
  Widget _age(L10n t) {
    final birth = _birth;
    final complete = _year.text.length == 4;
    Widget dob(TextEditingController c, String label, double w, int max, {bool last = false}) => SizedBox(
          width: w,
          child: TextField(
            controller: c,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(max)],
            textInputAction: last ? TextInputAction.done : TextInputAction.next,
            style: VType.body(size: 20, weight: FontWeight.w800, tabular: true),
            decoration: InputDecoration(hintText: label, contentPadding: const EdgeInsets.symmetric(vertical: 16)),
            onChanged: (v) {
              if (v.length == max && !last) FocusScope.of(context).nextFocus();
              setState(() {});
            },
          ),
        );
    final slash = Text('/', style: VType.body(size: 20, color: VColors.ash2));
    return ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 32), children: [
      Text(t.beforeYouEnter, style: VType.cinzel(size: 27, height: 1.2)),
      const SizedBox(height: 10),
      Text(t.ageBody, style: VType.body(size: 15, color: VColors.ash, height: 1.5)),
      const SizedBox(height: 24),
      _label(t.birthDate),
      Row(children: [
        dob(_day, 'TT', 84, 2),
        const SizedBox(width: 10),
        slash,
        const SizedBox(width: 10),
        dob(_month, 'MM', 84, 2),
        const SizedBox(width: 10),
        slash,
        const SizedBox(width: 10),
        Expanded(child: dob(_year, 'JJJJ', 128, 4, last: true)),
      ]),
      const SizedBox(height: 10),
      if (complete && birth != null && isAdult(birth))
        Row(children: [const VIcon(VIcons.check, size: 16, color: VColors.moss, stroke: 2.4), const SizedBox(width: 7), Text(t.ageOk, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.moss))])
      else if (complete)
        Text(t.ageGateError, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.bloodText)),
      const SizedBox(height: 26),
      VEyebrow(t.consentsTitle),
      const SizedBox(height: 6),
      _consentRow(
        title: t.termsAccept,
        control: Checkbox(value: _terms, onChanged: (v) => setState(() => _terms = v ?? false)),
        leading: true,
      ),
      _consentRow(title: t.eventsNews, caption: t.eventsNewsConsentCaption, control: Switch(value: _pushConsent, onChanged: (v) => setState(() => _pushConsent = v))),
      _consentRow(title: t.personalOffers, caption: t.offersConsentCaption, control: Switch(value: _offersConsent, onChanged: (v) => setState(() => _offersConsent = v))),
      Container(
        padding: const EdgeInsets.only(top: 10),
        decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xB33A302A)))),
        child: Text(t.consentsFootnote, style: VType.body(size: 12.5, color: VColors.ash, height: 1.45)),
      ),
      const SizedBox(height: 26),
      VPrimaryButton(label: t.continueLabel, onPressed: _ageValid ? () => setState(() => _step = 2) : null),
    ]);
  }

  Widget _consentRow({required String title, String? caption, required Widget control, bool leading = false}) {
    final text = Expanded(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: VType.body(size: 15, weight: FontWeight.w700, height: 1.35)),
        if (caption != null) Padding(padding: const EdgeInsets.only(top: 3), child: Text(caption, style: VType.body(size: 13, color: VColors.ash, height: 1.4))),
      ]),
    );
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xB33A302A)))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: leading ? [control, const SizedBox(width: 6), text] : [text, const SizedBox(width: 12), control]),
    );
  }

  // ---------------------------------------------------------------- step 2
  Widget _hero(L10n t) {
    Widget form(HeroForm f, String label, String levelName) {
      final sel = _form == f;
      return Expanded(
        child: Semantics(
          button: true,
          selected: sel,
          label: label,
          child: GestureDetector(
            onTap: () {
              HapticFeedback.selectionClick();
              setState(() => _form = f);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 290,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xFF120E0B),
                border: Border.all(color: sel ? VColors.goldBright : VColors.border, width: sel ? 1.5 : 1),
                boxShadow: sel ? [BoxShadow(color: VColors.gold.withValues(alpha: .25), blurRadius: 24)] : null,
              ),
              child: Stack(fit: StackFit.expand, children: [
                Opacity(opacity: .85, child: VArt.image(VArt.stage(1))),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0x330E0B09), Color(0x330E0B09), Color(0xF20E0B09)], stops: [0, .45, .9]),
                  ),
                ),
                Positioned(top: 12, left: 0, right: 0, height: 226, child: VArt.image(VArt.hero(1, f), fit: BoxFit.contain)),
                Positioned(
                  top: 10,
                  right: 10,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: sel ? VColors.goldGradient : null,
                      border: sel ? null : Border.all(color: const Color(0xFF5A4C40), width: 1.5),
                    ),
                    child: sel ? const Center(child: VIcon(VIcons.check, size: 14, color: VColors.onGold, stroke: 3)) : null,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 14,
                  child: Column(children: [
                    Text(label, style: VType.body(size: 16, weight: FontWeight.w800)),
                    Text('I · ${levelName.toUpperCase()}', style: VType.cinzel(size: 11, color: VColors.level(1), spacing: 1.3)),
                  ]),
                ),
              ]),
            ),
          ),
        ),
      );
    }

    final nickOk = _heroValid;
    return ListView(padding: const EdgeInsets.fromLTRB(20, 24, 20, 32), children: [
      Text(t.heroAwakes, style: VType.cinzel(size: 27, height: 1.15)),
      const SizedBox(height: 6),
      Text(t.chooseForm, style: VType.body(size: 14.5, color: VColors.ash, height: 1.5)),
      const SizedBox(height: 18),
      Row(children: [form(HeroForm.hero, t.heroFormHero, 'Thrall'), const SizedBox(width: 12), form(HeroForm.heroine, t.heroFormHeroine, 'Thrallin')]),
      const SizedBox(height: 22),
      _label(t.heroNameLabel),
      TextField(
        controller: _nick,
        maxLength: 20,
        onChanged: (_) => setState(() {}),
        style: VType.cinzel(size: 20),
        decoration: InputDecoration(
          counterText: '',
          suffixIcon: nickOk ? const Padding(padding: EdgeInsets.all(14), child: VIcon(VIcons.check, size: 20, color: VColors.moss, stroke: 2.4)) : null,
        ),
      ),
      const SizedBox(height: 8),
      Text(t.heroNameHint, style: VType.body(size: 12.5, color: VColors.ash)),
      const SizedBox(height: 22),
      Row(children: [
        for (var i = 1; i <= 8; i++) ...[
          if (i > 1) const Expanded(child: Divider(color: VColors.border)),
          Container(
            width: i == 1 ? 26 : 20,
            height: i == 1 ? 26 : 20,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == 1 ? const Color(0xFF2A2119) : const Color(0xFF171210),
              border: Border.all(color: i == 1 ? VColors.level(1) : VColors.border, width: i == 1 ? 1.5 : 1),
            ),
            child: Text(romanLevel(i), style: VType.cinzel(size: i == 1 ? 10 : 8, color: i == 1 ? VColors.level(1) : const Color(0xFF6D6358))),
          ),
        ],
      ]),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(_form == HeroForm.heroine ? 'Thrallin' : 'Thrall', style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.level(1))),
        Text(t.eightLevels, style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.ash)),
        Text(_form == HeroForm.heroine ? 'Valkyrja' : 'Einherjar', style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.ash)),
      ]),
      const SizedBox(height: 26),
      VPrimaryButton(label: t.startJourney, icon: VIcons.ship, busy: _busy, onPressed: nickOk && _ageValid ? _finish : null),
    ]);
  }

  Widget _label(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.parchment)));
}
