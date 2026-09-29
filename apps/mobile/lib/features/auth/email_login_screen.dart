import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'auth_service.dart';

class EmailLoginScreen extends ConsumerStatefulWidget {
  const EmailLoginScreen({super.key});
  @override
  ConsumerState<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends ConsumerState<EmailLoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      await ref.read(authServiceProvider).signInWithPassword(_email.text.trim(), _password.text);
    } on ApiError catch (e) {
      if (mounted) showSnack(context, L10n.of(context).authError(e.message), error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return VScreen(
      glow: VColors.gold,
      child: SafeArea(
        child: Column(children: [
          VTopBar(back: true, onBack: () => context.canPop() ? context.pop() : context.go('/welcome')),
          Expanded(
            child: ListView(padding: const EdgeInsets.fromLTRB(20, 12, 20, 32), children: [
              Text(t.emailSignInTitle, style: VType.cinzel(size: 27, height: 1.2)),
              const SizedBox(height: 24),
              _Label(t.email),
              TextField(
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofillHints: const [AutofillHints.email],
                style: VType.body(size: 16, weight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              _Label(t.password),
              TextField(
                controller: _password,
                obscureText: true,
                autofillHints: const [AutofillHints.password],
                style: VType.body(size: 16, weight: FontWeight.w600),
                onSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 24),
              VPrimaryButton(label: t.signIn, busy: _busy, onPressed: _submit),
              const SizedBox(height: 8),
              Center(child: TextButton(onPressed: () => context.push('/signup'), child: Text(t.newHereCreate))),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.parchment)),
      );
}
