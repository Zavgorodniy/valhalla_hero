import 'dart:convert';
import 'dart:io' show Platform;
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:valhalla_core/valhalla_core.dart';

final authServiceProvider = Provider((ref) => AuthService(ref.watch(supabaseProvider)));

class AuthService {
  AuthService(this._db);
  final SupabaseClient _db;

  /// Sign in with Apple is native on iOS only (Android would need a web flow
  /// with a Services ID); App Review requires it there next to Google.
  static bool get appleAvailable => Platform.isIOS;

  /// Google needs OAuth client ids (web id for Supabase, plus the iOS id on iOS).
  /// Where Supabase sends email links (confirmation, magic link). Registered as
  /// URL scheme on iOS/Android; must be in the project's Redirect URLs.
  static const redirectUrl = 'valhallahero://login-callback';

  static bool get googleAvailable => Env.googleWebClientId.isNotEmpty && (!Platform.isIOS || Env.googleIosClientId.isNotEmpty);

  Future<void> signInWithPassword(String email, String password) =>
      guard(() => _db.auth.signInWithPassword(email: email, password: password));

  /// Email sign-up. Profile is created server-side from the metadata.
  Future<void> signUp({
    required String email,
    required String password,
    required String nickname,
    required DateTime birthDate,
    required String locale,
    HeroForm heroForm = HeroForm.hero,
  }) =>
      guard(() => _db.auth.signUp(email: email, password: password, emailRedirectTo: redirectUrl, data: {
            'nickname': nickname,
            'birth_date': _date(birthDate),
            'locale': locale,
            'hero_form': enumWire(heroForm),
          }));

  Future<void> signInWithGoogle() => guard(() async {
        final google = GoogleSignIn(
          clientId: Env.googleIosClientId.isEmpty ? null : Env.googleIosClientId,
          serverClientId: Env.googleWebClientId.isEmpty ? null : Env.googleWebClientId,
        );
        final GoogleSignInAccount? account;
        try {
          account = await google.signIn();
        } on PlatformException catch (e) {
          if (e.code == GoogleSignIn.kSignInCanceledError) return;
          rethrow;
        }
        if (account == null) return; // cancelled
        final auth = await account.authentication;
        final idToken = auth.idToken;
        if (idToken == null) throw ApiError(ApiErrorCode.unknown, 'Google id token missing (configure GOOGLE_WEB_CLIENT_ID)');
        await _db.auth.signInWithIdToken(provider: OAuthProvider.google, idToken: idToken, accessToken: auth.accessToken);
      });

  Future<void> signInWithApple() => guard(() async {
        final rawNonce = _nonce();
        final hashed = sha256.convert(utf8.encode(rawNonce)).toString();
        final AuthorizationCredentialAppleID cred;
        try {
          cred = await SignInWithApple.getAppleIDCredential(
            scopes: [AppleIDAuthorizationScopes.email, AppleIDAuthorizationScopes.fullName],
            nonce: hashed,
          );
        } on SignInWithAppleAuthorizationException catch (e) {
          if (e.code == AuthorizationErrorCode.canceled) return;
          rethrow;
        }
        final idToken = cred.identityToken;
        if (idToken == null) throw ApiError(ApiErrorCode.unknown, 'Apple id token missing');
        await _db.auth.signInWithIdToken(provider: OAuthProvider.apple, idToken: idToken, nonce: rawNonce);
      });

  Future<void> signOut() => _db.auth.signOut();

  static String _nonce([int length = 32]) {
    const chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final r = Random.secure();
    return List.generate(length, (_) => chars[r.nextInt(chars.length)]).join();
  }

  static String _date(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}

/// True when the date is at least 18 years ago.
bool isAdult(DateTime birth) {
  final now = DateTime.now();
  final cutoff = DateTime(now.year - 18, now.month, now.day);
  return !birth.isAfter(cutoff);
}
