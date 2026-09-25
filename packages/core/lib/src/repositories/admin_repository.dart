import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/enums.dart';
import '../models/models.dart';
import '../supabase/errors.dart';

class AdminRepository {
  AdminRepository(this._db);
  final SupabaseClient _db;

  Future<AdminStats> stats() => guard(() async {
        final res = await _db.rpc('admin_stats');
        return AdminStats.fromJson(Map<String, dynamic>.from(res as Map));
      });

  Future<List<Profile>> profiles({String? search, int limit = 200}) => guard(() async {
        var q = _db.from('profiles').select();
        if (search != null && search.isNotEmpty) q = q.ilike('nickname', '%$search%');
        final rows = await q.order('xp', ascending: false).limit(limit);
        return rows.map(Profile.fromJson).toList();
      });

  Future<void> setRole(String userId, UserRole role) =>
      guard(() => _db.from('profiles').update({'role': enumWire(role)}).eq('id', userId));

  Future<Reward> upsertReward(Map<String, dynamic> data) => guard(() async {
        final row = await _db.from('rewards').upsert(data).select().single();
        return Reward.fromJson(row);
      });

  Future<Item> upsertItem(Map<String, dynamic> data) => guard(() async {
        final row = await _db.from('items').upsert(data).select().single();
        return Item.fromJson(row);
      });

  Future<Venue> upsertVenue(Map<String, dynamic> data) => guard(() async {
        final row = await _db.from('venues').upsert(data).select().single();
        return Venue.fromJson(row);
      });

  Future<EconomyConfig> updateEconomy(EconomyConfig cfg) => guard(() async {
        final row = await _db
            .from('economy_config')
            .update({
              'xp_per_visit': cfg.xpPerVisit,
              'coins_per_euro': cfg.coinsPerEuro,
              'daily_coin_cap': cfg.dailyCoinCap,
              'coin_expiry_months': cfg.coinExpiryMonths,
              'onboard_window_days': cfg.onboardWindowDays,
              'streak_bonus_xp': cfg.streakBonusXp,
              'updated_at': DateTime.now().toUtc().toIso8601String(),
            })
            .eq('id', 1)
            .select()
            .single();
        return EconomyConfig.fromJson(row);
      });

  Future<void> updateLevel(Level level) => guard(() => _db.from('levels').update({
        'name': level.name,
        'xp_threshold': level.xpThreshold,
        'coin_multiplier': level.coinMultiplier,
        'tagline_de': level.taglineDe,
        'tagline_en': level.taglineEn,
      }).eq('level', level.level));
}
