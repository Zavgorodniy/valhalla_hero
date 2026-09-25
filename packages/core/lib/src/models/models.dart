// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import 'enums.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
abstract class Venue with _$Venue {
  const factory Venue({
    required String id,
    required String slug,
    required String name,
    String? address,
    String? city,
    String? imageUrl,
    @Default(true) bool isActive,
  }) = _Venue;
  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);
}

@freezed
abstract class EconomyConfig with _$EconomyConfig {
  const factory EconomyConfig({
    @Default(1) int id,
    required int xpPerVisit,
    required num coinsPerEuro,
    required int dailyCoinCap,
    required int coinExpiryMonths,
    required int onboardWindowDays,
    required int streakBonusXp,
  }) = _EconomyConfig;
  factory EconomyConfig.fromJson(Map<String, dynamic> json) => _$EconomyConfigFromJson(json);
}

@freezed
abstract class Level with _$Level {
  const factory Level({
    required int level,
    required String name,
    String? nameFemale,
    required int xpThreshold,
    required num coinMultiplier,
    required String heroAsset,
    String? taglineDe,
    String? taglineEn,
  }) = _Level;
  const Level._();
  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  String tagline(String locale) => (locale == 'de' ? taglineDe : taglineEn) ?? taglineEn ?? '';

  /// Level name for the chosen hero form (Huskarl / Huskarlin).
  String nameFor(HeroForm form) => form == HeroForm.heroine ? (nameFemale ?? name) : name;
}

@freezed
abstract class Profile with _$Profile {
  const factory Profile({
    required String id,
    required String nickname,
    @Default(UserRole.user) UserRole role,
    required DateTime birthDate,
    @Default('de') String locale,
    @Default(true) bool leaderboardVisible,
    @Default(false) bool pushMarketingConsent,
    @Default(false) bool personalisedOffersConsent,
    @Default(HeroForm.hero) HeroForm heroForm,
    @Default(0) int xp,
    @Default(1) int level,
    @Default(0) int coinBalance,
    @Default(0) int visitCount,
    DateTime? lastVisitAt,
    @Default(0) int currentStreakWeeks,
    @Default(0) int longestStreakWeeks,
    DateTime? createdAt,
  }) = _Profile;
  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
}

@freezed
abstract class VisitClaim with _$VisitClaim {
  const factory VisitClaim({
    required String id,
    required String userId,
    required String venueId,
    required int amountCents,
    String? note,
    @Default(ClaimStatus.pending) ClaimStatus status,
    String? reviewedBy,
    DateTime? reviewedAt,
    String? rejectReason,
    required DateTime createdAt,
    /// Present when selected with `profile:profiles(nickname, level)`.
    ClaimProfile? profile,
  }) = _VisitClaim;
  factory VisitClaim.fromJson(Map<String, dynamic> json) => _$VisitClaimFromJson(json);
}

@freezed
abstract class ClaimProfile with _$ClaimProfile {
  const factory ClaimProfile({required String nickname, @Default(1) int level, @Default(HeroForm.hero) HeroForm heroForm}) = _ClaimProfile;
  factory ClaimProfile.fromJson(Map<String, dynamic> json) => _$ClaimProfileFromJson(json);
}

@freezed
abstract class Visit with _$Visit {
  const factory Visit({
    required String id,
    required String userId,
    required String venueId,
    required int amountCents,
    required VisitSource source,
    required DateTime visitedAt,
  }) = _Visit;
  factory Visit.fromJson(Map<String, dynamic> json) => _$VisitFromJson(json);
}

@freezed
abstract class Achievement with _$Achievement {
  const factory Achievement({
    required String key,
    required String nameDe,
    required String nameEn,
    required String descriptionDe,
    required String descriptionEn,
    required String icon,
    @Default(0) int xpReward,
    @Default(0) int coinReward,
    @Default(0) int sort,
  }) = _Achievement;
  const Achievement._();
  factory Achievement.fromJson(Map<String, dynamic> json) => _$AchievementFromJson(json);

  String name(String locale) => locale == 'de' ? nameDe : nameEn;
  String description(String locale) => locale == 'de' ? descriptionDe : descriptionEn;
}

@freezed
abstract class UserAchievement with _$UserAchievement {
  const factory UserAchievement({
    required String userId,
    required String achievementKey,
    required DateTime unlockedAt,
  }) = _UserAchievement;
  factory UserAchievement.fromJson(Map<String, dynamic> json) => _$UserAchievementFromJson(json);
}

@freezed
abstract class Item with _$Item {
  const factory Item({
    required String id,
    required ItemSlot slot,
    required String nameDe,
    required String nameEn,
    String? descriptionDe,
    String? descriptionEn,
    @Default(ItemRarity.common) ItemRarity rarity,
    required String assetKey,
    required ItemSource source,
    int? priceCoins,
    int? unlockLevel,
    String? unlockAchievementKey,
    @Default(true) bool isActive,
    @Default(0) int sort,
  }) = _Item;
  const Item._();
  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  String name(String locale) => locale == 'de' ? nameDe : nameEn;
  String? description(String locale) => locale == 'de' ? descriptionDe : descriptionEn;
}

@freezed
abstract class UserItem with _$UserItem {
  const factory UserItem({
    required String userId,
    required String itemId,
    required ItemSource source,
    required DateTime acquiredAt,
  }) = _UserItem;
  factory UserItem.fromJson(Map<String, dynamic> json) => _$UserItemFromJson(json);
}

@freezed
abstract class Equipment with _$Equipment {
  const factory Equipment({
    required String userId,
    required ItemSlot slot,
    required String itemId,
  }) = _Equipment;
  factory Equipment.fromJson(Map<String, dynamic> json) => _$EquipmentFromJson(json);
}

@freezed
abstract class Reward with _$Reward {
  const factory Reward({
    required String id,
    required RewardType type,
    required String nameDe,
    required String nameEn,
    String? descriptionDe,
    String? descriptionEn,
    String? imageUrl,
    required int priceCoins,
    int? stock,
    @Default(30) int validityDays,
    String? venueId,
    @Default(true) bool isActive,
    @Default(0) int sort,
  }) = _Reward;
  const Reward._();
  factory Reward.fromJson(Map<String, dynamic> json) => _$RewardFromJson(json);

  String name(String locale) => locale == 'de' ? nameDe : nameEn;
  String? description(String locale) => locale == 'de' ? descriptionDe : descriptionEn;
  bool get soldOut => stock != null && stock! <= 0;
}

@freezed
abstract class Voucher with _$Voucher {
  const factory Voucher({
    required String id,
    required String userId,
    required String rewardId,
    required String code,
    @Default(VoucherStatus.active) VoucherStatus status,
    required int pricePaid,
    required DateTime expiresAt,
    DateTime? redeemedAt,
    required DateTime createdAt,
    /// Present when selected with `reward:rewards(*)`.
    Reward? reward,
  }) = _Voucher;
  const Voucher._();
  factory Voucher.fromJson(Map<String, dynamic> json) => _$VoucherFromJson(json);

  VoucherStatus get effectiveStatus =>
      status == VoucherStatus.active && expiresAt.isBefore(DateTime.now()) ? VoucherStatus.expired : status;
}

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String id,
    @Default(PostType.news) PostType type,
    required String title,
    required String body,
    String? imageUrl,
    String? venueId,
    DateTime? startsAt,
    DateTime? publishedAt,
    String? authorId,
    @Default(0) int likeCount,
    required DateTime createdAt,
  }) = _Post;
  const Post._();
  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  bool get isPublished => publishedAt != null;
}

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    required String id,
    required String userId,
    required String type,
    required String titleDe,
    required String titleEn,
    String? bodyDe,
    String? bodyEn,
    @Default({}) Map<String, dynamic> data,
    DateTime? readAt,
    required DateTime createdAt,
  }) = _AppNotification;
  const AppNotification._();
  factory AppNotification.fromJson(Map<String, dynamic> json) => _$AppNotificationFromJson(json);

  String title(String locale) => locale == 'de' ? titleDe : titleEn;
  String? body(String locale) => locale == 'de' ? bodyDe : bodyEn;
  bool get isRead => readAt != null;
}

@freezed
abstract class PublicProfile with _$PublicProfile {
  const factory PublicProfile({
    required String id,
    required String nickname,
    @Default(0) int xp,
    @Default(1) int level,
    @Default(0) int visitCount,
    @Default(0) int currentStreakWeeks,
    @Default(false) bool onBoard,
    @Default({}) Map<String, String> equipped,
    @Default(0) int rank,
    @Default(HeroForm.hero) HeroForm heroForm,
  }) = _PublicProfile;
  factory PublicProfile.fromJson(Map<String, dynamic> json) => _$PublicProfileFromJson(json);
}

@freezed
abstract class CoinLedgerEntry with _$CoinLedgerEntry {
  const factory CoinLedgerEntry({
    required int id,
    required int amount,
    @Default(0) int remaining,
    required CoinReason reason,
    String? refId,
    DateTime? expiresAt,
    required DateTime createdAt,
  }) = _CoinLedgerEntry;
  factory CoinLedgerEntry.fromJson(Map<String, dynamic> json) => _$CoinLedgerEntryFromJson(json);
}

@freezed
abstract class XpLedgerEntry with _$XpLedgerEntry {
  const factory XpLedgerEntry({
    required int id,
    required int amount,
    required XpReason reason,
    String? refId,
    required DateTime createdAt,
  }) = _XpLedgerEntry;
  factory XpLedgerEntry.fromJson(Map<String, dynamic> json) => _$XpLedgerEntryFromJson(json);
}

@freezed
abstract class AdminStats with _$AdminStats {
  const factory AdminStats({
    @Default(0) int users,
    @Default(0) int usersOnBoard,
    @JsonKey(name: 'visits_30d') @Default(0) int visits30d,
    @JsonKey(name: 'revenue_30d_cents') @Default(0) int revenue30dCents,
    @Default(0) int pendingClaims,
    @Default(0) int coinsOutstanding,
    @Default(0) int vouchersActive,
    @JsonKey(name: 'vouchers_redeemed_30d') @Default(0) int vouchersRedeemed30d,
  }) = _AdminStats;
  factory AdminStats.fromJson(Map<String, dynamic> json) => _$AdminStatsFromJson(json);
}

/// Result of `lookup_voucher` RPC for staff.
@freezed
abstract class VoucherLookup with _$VoucherLookup {
  const factory VoucherLookup({
    required Voucher voucher,
    required Reward reward,
    required ClaimProfile user,
  }) = _VoucherLookup;
  factory VoucherLookup.fromJson(Map<String, dynamic> json) => _$VoucherLookupFromJson(json);
}
