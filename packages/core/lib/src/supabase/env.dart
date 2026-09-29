/// Build-time configuration from the repo's `.env` file:
/// `flutter run --dart-define-from-file=../../.env` (template: `.env.example`).
///
/// Without it the apps talk to the local Supabase stack from `supabase start`
/// (ports rebased to 544xx in supabase/config.toml).
class Env {
  Env._();

  // Local stack (`supabase start`): public demo values, used when unset.
  static const _localUrl = 'http://127.0.0.1:54421';
  static const _localAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0';

  // Set via `--dart-define-from-file=.env` (see .env.example) or --dart-define.
  static const _url = String.fromEnvironment('SUPABASE_URL');
  static const _anonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static String get supabaseUrl => _url.isEmpty ? _localUrl : _url;

  /// Falls back to the local demo key only for the local stack.
  static String get supabaseAnonKey {
    if (_anonKey.isNotEmpty) return _anonKey;
    if (isLocal) return _localAnonKey;
    throw StateError('SUPABASE_ANON_KEY is missing for $supabaseUrl – set it in .env');
  }

  /// Web client id for Google Sign-In (needed on Android/iOS for id tokens).
  static const googleWebClientId = String.fromEnvironment('GOOGLE_WEB_CLIENT_ID');
  static const googleIosClientId = String.fromEnvironment('GOOGLE_IOS_CLIENT_ID');

  static bool get isLocal => supabaseUrl.contains('127.0.0.1') || supabaseUrl.contains('localhost') || supabaseUrl.contains('192.168.');
}
