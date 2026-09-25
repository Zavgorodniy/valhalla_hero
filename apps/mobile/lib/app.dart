import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:valhalla_core/valhalla_core.dart';

import 'router.dart';
import 'shared/locale.dart';

class ValhallaApp extends ConsumerWidget {
  const ValhallaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final locale = ref.watch(uiLocaleProvider);
    // number/date helpers without an explicit locale follow the UI language
    Intl.defaultLocale = locale;
    return MaterialApp.router(
      title: 'Valhalla Hero',
      debugShowCheckedModeBanner: false,
      theme: valhallaTheme(),
      routerConfig: router,
      builder: (context, child) => AnnotatedRegion<SystemUiOverlayStyle>(value: SystemUiOverlayStyle.light, child: child ?? const SizedBox.shrink()),
      locale: Locale(locale),
      supportedLocales: L10n.supportedLocales,
      localizationsDelegates: const [
        L10n.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
