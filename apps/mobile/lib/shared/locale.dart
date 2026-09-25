import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valhalla_core/valhalla_core.dart';

/// Language chosen on this device (before login, or mirrored from the profile).
class AppLocaleNotifier extends StateNotifier<String> {
  AppLocaleNotifier() : super(supportedLanguage(PlatformDispatcher.instance.locale.languageCode)) {
    _load();
  }

  static const _key = 'app_locale';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_key);
    if (saved != null && appLanguageCodes.contains(saved)) state = saved;
  }

  Future<void> set(String code) async {
    state = supportedLanguage(code);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, state);
  }
}

final appLocaleProvider = StateNotifierProvider<AppLocaleNotifier, String>((ref) => AppLocaleNotifier());

/// The language the UI uses: the profile's once signed in, else the device choice.
final uiLocaleProvider = Provider<String>((ref) => ref.watch(profileProvider).valueOrNull?.locale ?? ref.watch(appLocaleProvider));

/// Changes the language everywhere (device + profile when signed in).
Future<void> setAppLanguage(WidgetRef ref, String code) async {
  await ref.read(appLocaleProvider.notifier).set(code);
  if (ref.read(profileProvider).valueOrNull != null) {
    await ref.read(profileProvider.notifier).updateProfile(locale: code);
  }
}
