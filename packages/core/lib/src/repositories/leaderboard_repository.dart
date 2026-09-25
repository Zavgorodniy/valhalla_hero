import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';
import '../supabase/errors.dart';

class LeaderboardRepository {
  LeaderboardRepository(this._db);
  final SupabaseClient _db;

  Future<List<PublicProfile>> top({int limit = 100}) => guard(() async {
        final rows = await _db.from('public_profiles').select().order('rank', ascending: true).limit(limit);
        return rows.map(PublicProfile.fromJson).toList();
      });

  Future<PublicProfile?> me() => guard(() async {
        final row = await _db.from('public_profiles').select().eq('id', _db.auth.currentUser!.id).maybeSingle();
        return row == null ? null : PublicProfile.fromJson(row);
      });
}
