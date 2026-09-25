import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';
import '../supabase/errors.dart';

class ReferenceRepository {
  ReferenceRepository(this._db);
  final SupabaseClient _db;

  Future<List<Venue>> venues({bool activeOnly = false}) => guard(() async {
        var q = _db.from('venues').select();
        if (activeOnly) q = q.eq('is_active', true);
        final rows = await q.order('name', ascending: true);
        return rows.map(Venue.fromJson).toList();
      });

  Future<List<Level>> levels() => guard(() async {
        final rows = await _db.from('levels').select().order('level', ascending: true);
        return rows.map(Level.fromJson).toList();
      });

  Future<EconomyConfig> economy() => guard(() async {
        final row = await _db.from('economy_config').select().eq('id', 1).single();
        return EconomyConfig.fromJson(row);
      });

  Future<List<Achievement>> achievements() => guard(() async {
        final rows = await _db.from('achievements').select().order('sort', ascending: true);
        return rows.map(Achievement.fromJson).toList();
      });

  Future<List<Item>> items({bool includeInactive = false}) => guard(() async {
        var q = _db.from('items').select();
        if (!includeInactive) q = q.eq('is_active', true);
        final rows = await q.order('sort', ascending: true);
        return rows.map(Item.fromJson).toList();
      });

  Future<List<Reward>> rewards({bool includeInactive = false}) => guard(() async {
        var q = _db.from('rewards').select();
        if (!includeInactive) q = q.eq('is_active', true);
        final rows = await q.order('sort', ascending: true);
        return rows.map(Reward.fromJson).toList();
      });
}
