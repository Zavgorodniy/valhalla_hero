/// App languages: German and English first, Russian and Ukrainian, then the
/// most common tourist languages in Germany. Names are shown in the language itself.
const appLanguages = <(String, String)>[
  ('de', 'Deutsch'),
  ('en', 'English'),
  ('ru', 'Русский'),
  ('uk', 'Українська'),
  ('nl', 'Nederlands'),
  ('fr', 'Français'),
  ('it', 'Italiano'),
  ('es', 'Español'),
  ('pl', 'Polski'),
  ('tr', 'Türkçe'),
];

const appLanguageCodes = ['de', 'en', 'ru', 'uk', 'nl', 'fr', 'it', 'es', 'pl', 'tr'];

String languageName(String code) => appLanguages.firstWhere((l) => l.$1 == code, orElse: () => appLanguages.first).$2;

/// Best supported language for a device locale code, German as fallback.
String supportedLanguage(String? code) => appLanguageCodes.contains(code) ? code! : 'de';
