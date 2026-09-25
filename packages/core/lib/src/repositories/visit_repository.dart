import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';
import '../supabase/errors.dart';

class VisitRepository {
  VisitRepository(this._db);
  final SupabaseClient _db;

  Future<VisitClaim> submitClaim({required String venueId, required int amountCents, String? note}) => guard(() async {
        final row = await _db.rpc('submit_visit_claim', params: {
          'p_venue': venueId,
          'p_amount_cents': amountCents,
          'p_note': note,
        });
        return VisitClaim.fromJson(Map<String, dynamic>.from(row as Map));
      });

  Future<List<VisitClaim>> myClaims({int limit = 30}) => guard(() async {
        final rows = await _db
            .from('visit_claims')
            .select()
            .eq('user_id', _db.auth.currentUser!.id)
            .order('created_at', ascending: false)
            .limit(limit);
        return rows.map(VisitClaim.fromJson).toList();
      });

  /// Staff: pending claims across all venues, oldest first.
  Future<List<VisitClaim>> pendingClaims() => guard(() async {
        final rows = await _db
            .from('visit_claims')
            .select('*, profile:profiles!visit_claims_user_id_fkey(nickname, level, hero_form)')
            .eq('status', 'pending')
            .order('created_at', ascending: true);
        return rows.map(VisitClaim.fromJson).toList();
      });

  /// Admin: all claims (any status).
  Future<List<VisitClaim>> allClaims({int limit = 200}) => guard(() async {
        final rows = await _db
            .from('visit_claims')
            .select('*, profile:profiles!visit_claims_user_id_fkey(nickname, level)')
            .order('created_at', ascending: false)
            .limit(limit);
        return rows.map(VisitClaim.fromJson).toList();
      });

  Future<VisitClaim> review(String claimId, {required bool approve, String? reason}) => guard(() async {
        final row = await _db.rpc('review_visit_claim', params: {
          'p_claim': claimId,
          'p_approve': approve,
          'p_reason': reason,
        });
        return VisitClaim.fromJson(Map<String, dynamic>.from(row as Map));
      });

  Future<String> adminCreditVisit({required String userId, required String venueId, required int amountCents}) =>
      guard(() async {
        final res = await _db.rpc('admin_credit_visit', params: {
          'p_user': userId,
          'p_venue': venueId,
          'p_amount_cents': amountCents,
        });
        return res as String;
      });
}
