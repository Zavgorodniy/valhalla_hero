import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/enums.dart';
import '../models/models.dart';
import '../supabase/errors.dart';

class FeedRepository {
  FeedRepository(this._db);
  final SupabaseClient _db;

  Future<List<Post>> published({int limit = 50}) => guard(() async {
        final rows = await _db
            .from('posts')
            .select()
            .not('published_at', 'is', null)
            .order('published_at', ascending: false)
            .limit(limit);
        return rows.map(Post.fromJson).toList();
      });

  Future<Set<String>> myLikes() => guard(() async {
        final rows = await _db.from('post_likes').select('post_id').eq('user_id', _db.auth.currentUser!.id);
        return rows.map((r) => r['post_id'] as String).toSet();
      });

  /// Returns the new liked state.
  Future<bool> toggleLike(String postId) => guard(() async {
        final res = await _db.rpc('toggle_post_like', params: {'p_post': postId});
        return res as bool;
      });

  // ---- admin / manager ----
  Future<List<Post>> all() => guard(() async {
        final rows = await _db.from('posts').select().order('created_at', ascending: false);
        return rows.map(Post.fromJson).toList();
      });

  Future<Post> upsert({
    String? id,
    required PostType type,
    required String title,
    required String body,
    String? imageUrl,
    String? venueId,
    DateTime? startsAt,
    DateTime? endsAt,
    EventCategory? category,
    bool publish = false,
  }) =>
      guard(() async {
        final data = <String, dynamic>{
          if (id != null) 'id': id,
          'type': enumWire(type),
          'title': title,
          'body': body,
          'image_url': imageUrl,
          'venue_id': venueId,
          'starts_at': startsAt?.toUtc().toIso8601String(),
          'ends_at': endsAt?.toUtc().toIso8601String(),
          'category': category == null ? null : enumWire(category),
          'published_at': publish ? DateTime.now().toUtc().toIso8601String() : null,
          'author_id': _db.auth.currentUser!.id,
        };
        final row = await _db.from('posts').upsert(data).select().single();
        return Post.fromJson(row);
      });

  Future<void> delete(String id) => guard(() => _db.from('posts').delete().eq('id', id));
}
