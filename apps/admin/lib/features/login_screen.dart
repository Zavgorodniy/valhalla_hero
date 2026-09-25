import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _email = TextEditingController(text: Env.isLocal ? 'admin@valhalla.demo' : '');
  final _password = TextEditingController(text: Env.isLocal ? 'Valhalla123!' : '');
  bool _busy = false;

  Future<void> _submit() async {
    setState(() => _busy = true);
    try {
      await guard(() => ref.read(supabaseProvider).auth.signInWithPassword(email: _email.text.trim(), password: _password.text));
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.message, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 360,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                const Icon(Icons.shield, color: VColors.gold, size: 40),
                const SizedBox(height: 8),
                const Text('VALHALLA ADMIN', textAlign: TextAlign.center, style: TextStyle(color: VColors.gold, letterSpacing: 3, fontWeight: FontWeight.w700, fontSize: 18)),
                const SizedBox(height: 24),
                TextField(controller: _email, decoration: InputDecoration(labelText: t.email)),
                const SizedBox(height: 12),
                TextField(controller: _password, obscureText: true, decoration: InputDecoration(labelText: t.password), onSubmitted: (_) => _submit()),
                const SizedBox(height: 20),
                FilledButton(onPressed: _busy ? null : _submit, child: Text(t.signIn)),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
