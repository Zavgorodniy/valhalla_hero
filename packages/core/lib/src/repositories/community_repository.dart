import 'dart:typed_data';

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/models.dart';
import '../supabase/errors.dart';

/// Photo check-ins (Saga), receipt redemption and feedback.
class CommunityRepository {
  CommunityRepository(this._db);
  final SupabaseClient _db;
  String get _uid => _db.auth.currentUser!.id;

  static const bucket = 'checkins';

  String photoUrl(String path) => _db.storage.from(bucket).getPublicUrl(path);

  // ---- feed ----
  Future<List<FeedCheckin>> feed({int limit = 60}) => guard(() async {
        final rows = await _db.from('checkin_feed').select().order('created_at', ascending: false).limit(limit);
        return rows.map(FeedCheckin.fromJson).toList();
      });

  Future<List<FeedCheckin>> feedOf(String userId, {int limit = 30}) => guard(() async {
        final rows = await _db.from('checkin_feed').select().eq('user_id', userId).order('created_at', ascending: false).limit(limit);
        return rows.map(FeedCheckin.fromJson).toList();
      });

  /// Own check-ins, newest first (includes pending and rejected).
  Future<List<Checkin>> mine({int limit = 20}) => guard(() async {
        final rows = await _db.from('checkins').select().eq('user_id', _uid).order('created_at', ascending: false).limit(limit);
        return rows.map(Checkin.fromJson).toList();
      });

  /// Uploads the photo and submits it for moderation (one pending at a time).
  Future<Checkin> submit({required Uint8List bytes, required String extension, String? caption, String? eventId}) => guard(() async {
        final ext = extension.toLowerCase().replaceAll('.', '');
        final path = '$_uid/${DateTime.now().millisecondsSinceEpoch}.$ext';
        await _db.storage.from(bucket).uploadBinary(
              path,
              bytes,
              fileOptions: FileOptions(contentType: ext == 'png' ? 'image/png' : (ext == 'webp' ? 'image/webp' : 'image/jpeg')),
            );
        try {
          final row = await _db.rpc('submit_checkin', params: {'p_photo_path': path, 'p_caption': caption, 'p_event': eventId});
          return Checkin.fromJson(Map<String, dynamic>.from(row as Map));
        } catch (_) {
          await _db.storage.from(bucket).remove([path]);
          rethrow;
        }
      });

  Future<void> withdraw(Checkin c) => guard(() async {
        await _db.rpc('withdraw_checkin', params: {'p_checkin': c.id});
        await _db.storage.from(bucket).remove([c.photoPath]);
      });

  /// Returns the new liked state.
  Future<bool> toggleLike(String checkinId) => guard(() async {
        final res = await _db.rpc('toggle_checkin_like', params: {'p_checkin': checkinId});
        return res as bool;
      });

  // ---- staff ----
  Future<List<QueuedCheckin>> queue() => guard(() async {
        final rows = await _db.from('checkin_queue').select().order('created_at', ascending: true);
        return rows.map(QueuedCheckin.fromJson).toList();
      });

  Future<void> review(String checkinId, {required bool approve, String? reason}) =>
      guard(() => _db.rpc('review_checkin', params: {'p_checkin': checkinId, 'p_approve': approve, 'p_reason': reason}));

  // ---- receipts ----
  Future<ReceiptResult> redeemReceipt(String payload) => guard(() async {
        final res = await _db.rpc('redeem_receipt', params: {'p_payload': payload});
        return ReceiptResult.fromJson(Map<String, dynamic>.from(res as Map));
      });

  // ---- feedback ----
  Future<void> sendFeedback(String message, Map<String, dynamic> context) =>
      guard(() => _db.from('feedback').insert({'user_id': _uid, 'message': message, 'context': context}));
}
