import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/enums.dart';
import '../models/models.dart';
import '../repositories/admin_repository.dart';
import '../repositories/community_repository.dart';
import '../repositories/feed_repository.dart';
import '../repositories/leaderboard_repository.dart';
import '../repositories/profile_repository.dart';
import '../repositories/reference_repository.dart';
import '../repositories/shop_repository.dart';
import '../repositories/visit_repository.dart';

// ---------- infrastructure ----------
final supabaseProvider = Provider<SupabaseClient>((_) => Supabase.instance.client);

final authStateProvider = StreamProvider<AuthState>((ref) => ref.watch(supabaseProvider).auth.onAuthStateChange);

final currentUserProvider = Provider<User?>((ref) {
  ref.watch(authStateProvider);
  return ref.watch(supabaseProvider).auth.currentUser;
});

final referenceRepoProvider = Provider((ref) => ReferenceRepository(ref.watch(supabaseProvider)));
final profileRepoProvider = Provider((ref) => ProfileRepository(ref.watch(supabaseProvider)));
final visitRepoProvider = Provider((ref) => VisitRepository(ref.watch(supabaseProvider)));
final shopRepoProvider = Provider((ref) => ShopRepository(ref.watch(supabaseProvider)));
final feedRepoProvider = Provider((ref) => FeedRepository(ref.watch(supabaseProvider)));
final leaderboardRepoProvider = Provider((ref) => LeaderboardRepository(ref.watch(supabaseProvider)));
final adminRepoProvider = Provider((ref) => AdminRepository(ref.watch(supabaseProvider)));
final communityRepoProvider = Provider((ref) => CommunityRepository(ref.watch(supabaseProvider)));

// ---------- own profile ----------
class ProfileNotifier extends AsyncNotifier<Profile?> {
  @override
  Future<Profile?> build() async {
    final user = ref.watch(currentUserProvider);
    if (user == null) return null;
    return ref.read(profileRepoProvider).me();
  }

  Future<void> refresh() async {
    state = const AsyncLoading<Profile?>().copyWithPrevious(state);
    state = await AsyncValue.guard(() => ref.read(profileRepoProvider).me());
  }

  Future<void> updateProfile({
    String? nickname,
    String? locale,
    bool? leaderboardVisible,
    bool? pushMarketingConsent,
    bool? personalisedOffersConsent,
    HeroForm? heroForm,
  }) async {
    final p = await ref.read(profileRepoProvider).update(
          heroForm: heroForm,
          nickname: nickname,
          locale: locale,
          leaderboardVisible: leaderboardVisible,
          pushMarketingConsent: pushMarketingConsent,
          personalisedOffersConsent: personalisedOffersConsent,
        );
    state = AsyncData(p);
  }

  Future<void> completeOnboarding({required String nickname, required DateTime birthDate, required String locale, HeroForm heroForm = HeroForm.hero}) async {
    final p = await ref.read(profileRepoProvider).completeOnboarding(nickname: nickname, birthDate: birthDate, locale: locale, heroForm: heroForm);
    state = AsyncData(p);
  }
}

final profileProvider = AsyncNotifierProvider<ProfileNotifier, Profile?>(ProfileNotifier.new);

/// Locale code of the signed-in user ('de' | 'en'), falling back to German.
final localeCodeProvider = Provider<String>((ref) => ref.watch(profileProvider).valueOrNull?.locale ?? 'de');

// ---------- reference data ----------
final venuesProvider = FutureProvider<List<Venue>>((ref) => ref.watch(referenceRepoProvider).venues());
final activeVenuesProvider = FutureProvider<List<Venue>>((ref) => ref.watch(referenceRepoProvider).venues(activeOnly: true));
final levelsProvider = FutureProvider<List<Level>>((ref) => ref.watch(referenceRepoProvider).levels());
final economyProvider = FutureProvider<EconomyConfig>((ref) => ref.watch(referenceRepoProvider).economy());
final achievementsProvider = FutureProvider<List<Achievement>>((ref) => ref.watch(referenceRepoProvider).achievements());
final itemsProvider = FutureProvider<List<Item>>((ref) => ref.watch(referenceRepoProvider).items());
final allItemsProvider = FutureProvider<List<Item>>((ref) => ref.watch(referenceRepoProvider).items(includeInactive: true));
final rewardsProvider = FutureProvider<List<Reward>>((ref) => ref.watch(referenceRepoProvider).rewards());
final allRewardsProvider = FutureProvider<List<Reward>>((ref) => ref.watch(referenceRepoProvider).rewards(includeInactive: true));

/// Levels keyed by number for quick lookup.
final levelMapProvider = Provider<Map<int, Level>>((ref) {
  final levels = ref.watch(levelsProvider).valueOrNull ?? const [];
  return {for (final l in levels) l.level: l};
});

// ---------- own data ----------
final myClaimsProvider = FutureProvider<List<VisitClaim>>((ref) => ref.watch(visitRepoProvider).myClaims());
final myVisitsProvider = FutureProvider<List<Visit>>((ref) => ref.watch(profileRepoProvider).myVisits());
final myAchievementsProvider = FutureProvider<List<UserAchievement>>((ref) => ref.watch(profileRepoProvider).myAchievements());
final myVouchersProvider = FutureProvider<List<Voucher>>((ref) => ref.watch(shopRepoProvider).myVouchers());
final myItemsProvider = FutureProvider<List<UserItem>>((ref) => ref.watch(shopRepoProvider).myItems());
final myEquipmentProvider = FutureProvider<List<Equipment>>((ref) => ref.watch(shopRepoProvider).myEquipment());
final myLikesProvider = FutureProvider<Set<String>>((ref) => ref.watch(feedRepoProvider).myLikes());
final notificationsProvider = FutureProvider<List<AppNotification>>((ref) => ref.watch(profileRepoProvider).notifications());
final coinLedgerProvider = FutureProvider<List<CoinLedgerEntry>>((ref) => ref.watch(profileRepoProvider).coinLedger());

final unreadCountProvider = Provider<int>((ref) =>
    ref.watch(notificationsProvider).valueOrNull?.where((n) => !n.isRead).length ?? 0);

/// Equipped items as {slot: assetKey} for the hero widget.
final myEquippedAssetsProvider = Provider<Map<ItemSlot, String>>((ref) {
  final eq = ref.watch(myEquipmentProvider).valueOrNull ?? const [];
  final items = ref.watch(itemsProvider).valueOrNull ?? const [];
  final byId = {for (final i in items) i.id: i};
  return {for (final e in eq) if (byId[e.itemId] != null) e.slot: byId[e.itemId]!.assetKey};
});

// ---------- shared feeds ----------
final feedProvider = FutureProvider<List<Post>>((ref) => ref.watch(feedRepoProvider).published());
final leaderboardProvider = FutureProvider<List<PublicProfile>>((ref) => ref.watch(leaderboardRepoProvider).top());
final myRankProvider = FutureProvider<PublicProfile?>((ref) => ref.watch(leaderboardRepoProvider).me());

// ---------- community ----------
final checkinFeedProvider = FutureProvider<List<FeedCheckin>>((ref) => ref.watch(communityRepoProvider).feed());
final myCheckinsProvider = FutureProvider<List<Checkin>>((ref) => ref.watch(communityRepoProvider).mine());
final playerCheckinsProvider = FutureProvider.family<List<FeedCheckin>, String>((ref, id) => ref.watch(communityRepoProvider).feedOf(id));

/// The guest's check-in that is waiting for moderation, if any.
final pendingCheckinProvider = Provider<Checkin?>((ref) =>
    (ref.watch(myCheckinsProvider).valueOrNull ?? const <Checkin>[]).where((c) => c.status == CheckinStatus.pending).firstOrNull);

/// Upcoming (and currently running) events, soonest first.
final upcomingEventsProvider = Provider<List<Post>>((ref) {
  final posts = ref.watch(feedProvider).valueOrNull ?? const <Post>[];
  final now = DateTime.now();
  return posts
      .where((p) => p.type == PostType.event && p.startsAt != null && (p.endsAt ?? p.startsAt!.add(const Duration(hours: 3))).isAfter(now))
      .toList()
    ..sort((a, b) => a.startsAt!.compareTo(b.startsAt!));
});

// ---------- staff / admin ----------
final checkinQueueProvider = FutureProvider<List<QueuedCheckin>>((ref) => ref.watch(communityRepoProvider).queue());
final pendingClaimsProvider = FutureProvider<List<VisitClaim>>((ref) => ref.watch(visitRepoProvider).pendingClaims());
final allClaimsProvider = FutureProvider<List<VisitClaim>>((ref) => ref.watch(visitRepoProvider).allClaims());
final adminStatsProvider = FutureProvider<AdminStats>((ref) => ref.watch(adminRepoProvider).stats());
final adminProfilesProvider = FutureProvider.family<List<Profile>, String>((ref, search) => ref.watch(adminRepoProvider).profiles(search: search));
final adminPostsProvider = FutureProvider<List<Post>>((ref) => ref.watch(feedRepoProvider).all());

/// Invalidate everything that changes after a visit credit / purchase / redemption.
void invalidateUserData(WidgetRef ref) {
  ref.invalidate(profileProvider);
  ref.invalidate(myClaimsProvider);
  ref.invalidate(myVisitsProvider);
  ref.invalidate(myAchievementsProvider);
  ref.invalidate(myVouchersProvider);
  ref.invalidate(myItemsProvider);
  ref.invalidate(myEquipmentProvider);
  ref.invalidate(notificationsProvider);
  ref.invalidate(coinLedgerProvider);
  ref.invalidate(leaderboardProvider);
  ref.invalidate(myRankProvider);
  ref.invalidate(rewardsProvider);
  ref.invalidate(myCheckinsProvider);
  ref.invalidate(checkinFeedProvider);
}
