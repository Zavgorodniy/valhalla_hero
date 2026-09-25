import 'package:supabase_flutter/supabase_flutter.dart';

/// Typed errors raised by server RPCs (see supabase/migrations/*_functions.sql).
enum ApiErrorCode {
  insufficientCoins,
  outOfStock,
  rewardUnavailable,
  itemUnavailable,
  alreadyOwned,
  notOwned,
  tooManyPending,
  alreadyReviewed,
  forbidden,
  notFound,
  voucherNotActive,
  voucherExpired,
  ageRestricted,
  nicknameTaken,
  receiptUsed,
  receiptInvalid,
  receiptTooOld,
  receiptUnknownVenue,
  receiptDailyLimit,
  checkinPending,
  checkinInvalid,
  unknown,
}

class ApiError implements Exception {
  ApiError(this.code, this.message);
  final ApiErrorCode code;
  final String message;

  static ApiError from(Object e) {
    if (e is ApiError) return e;
    if (e is PostgrestException) {
      final m = e.message;
      if (m.contains('profiles_nickname_key')) return ApiError(ApiErrorCode.nicknameTaken, m);
      for (final code in ApiErrorCode.values) {
        if (m.contains(_wire(code))) return ApiError(code, m);
      }
      return ApiError(ApiErrorCode.unknown, m);
    }
    if (e is AuthException) return ApiError(ApiErrorCode.unknown, e.message);
    return ApiError(ApiErrorCode.unknown, e.toString());
  }

  static String _wire(ApiErrorCode c) =>
      c.name.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]}').toUpperCase();

  @override
  String toString() => 'ApiError(${code.name}: $message)';
}

/// Runs [fn] and converts any thrown Supabase error into an [ApiError].
Future<T> guard<T>(Future<T> Function() fn) async {
  try {
    return await fn();
  } catch (e) {
    throw ApiError.from(e);
  }
}
