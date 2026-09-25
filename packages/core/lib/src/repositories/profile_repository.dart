import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/enums.dart';
import '../models/models.dart';
import '../supabase/errors.dart';

class ProfileRepository {
  ProfileRepository(this._db);
  final SupabaseClient _db;

  String? get uid => _db.auth.currentUser?.id;

  /// Own profile, or null when the auth user has not completed onboarding yet.
  Future<Profile?> me() => guard(() async {
        final id = uid;
        if (id == null) return null;
        final row = await _db.from('profiles').select().eq('id', id).maybeSingle();
        return row == null ? null : Profile.fromJson(row);
      });

  Future<Profile> completeOnboarding({
    required String nickname,
    required DateTime birthDate,
    required String locale,
    HeroForm heroForm = HeroForm.hero,
  }) =>
      guard(() async {
        final row = await _db.rpc('complete_onboarding', params: {
          'p_nickname': nickname,
          'p_birth_date': _date(birthDate),
          'p_locale': locale,
          'p_hero_form': enumWire(heroForm),
        });
        return Profile.fromJson(Map<String, dynamic>.from(row as Map));
      });

  Future<Profile> update({
    String? nickname,
    String? locale,
    bool? leaderboardVisible,
    bool? pushMarketingConsent,
    bool? personalisedOffersConsent,
    HeroForm? heroForm,
  }) =>
      guard(() async {
        final patch = <String, dynamic>{
          if (heroForm != null) 'hero_form': enumWire(heroForm),
          if (nickname != null) 'nickname': nickname,
          if (locale != null) 'locale': locale,
          if (leaderboardVisible != null) 'leaderboard_visible': leaderboardVisible,
          if (pushMarketingConsent != null) 'push_marketing_consent': pushMarketingConsent,
          if (personalisedOffersConsent != null) 'personalised_offers_consent': personalisedOffersConsent,
          if (pushMarketingConsent != null || personalisedOffersConsent != null)
            'consents_updated_at': DateTime.now().toUtc().toIso8601String(),
        };
        final row = await _db.from('profiles').update(patch).eq('id', uid!).select().single();
        return Profile.fromJson(row);
      });

  Future<List<UserAchievement>> myAchievements() => guard(() async {
        final rows = await _db.from('user_achievements').select().eq('user_id', uid!);
        return rows.map(UserAchievement.fromJson).toList();
      });

  Future<List<Visit>> myVisits({int limit = 20}) => guard(() async {
        final rows = await _db.from('visits').select().eq('user_id', uid!).order('visited_at', ascending: false).limit(limit);
        return rows.map(Visit.fromJson).toList();
      });

  Future<List<CoinLedgerEntry>> coinLedger({int limit = 50}) => guard(() async {
        final rows = await _db.from('coin_ledger').select().eq('user_id', uid!).order('created_at', ascending: false).limit(limit);
        return rows.map(CoinLedgerEntry.fromJson).toList();
      });

  Future<List<XpLedgerEntry>> xpLedger({int limit = 50}) => guard(() async {
        final rows = await _db.from('xp_ledger').select().eq('user_id', uid!).order('created_at', ascending: false).limit(limit);
        return rows.map(XpLedgerEntry.fromJson).toList();
      });

  Future<List<AppNotification>> notifications({int limit = 50}) => guard(() async {
        final rows = await _db.from('notifications').select().eq('user_id', uid!).order('created_at', ascending: false).limit(limit);
        return rows.map(AppNotification.fromJson).toList();
      });

  Future<void> markAllRead() => guard(() async {
        await _db
            .from('notifications')
            .update({'read_at': DateTime.now().toUtc().toIso8601String()})
            .eq('user_id', uid!)
            .isFilter('read_at', null);
      });

  Future<void> registerDeviceToken(String token, String platform) => guard(() async {
        await _db.from('device_tokens').upsert({'user_id': uid!, 'token': token, 'platform': platform});
      });

  Future<Map<String, dynamic>> exportMyData() => guard(() async {
        final res = await _db.rpc('export_my_data');
        return Map<String, dynamic>.from(res as Map);
      });

  Future<void> deleteMyAccount() => guard(() async {
        await _db.rpc('delete_my_account');
        await _db.auth.signOut();
      });

  static String _date(DateTime d) =>
      '${d.year.toString().padLeft(4, '0')}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
}
