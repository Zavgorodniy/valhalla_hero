import 'package:json_annotation/json_annotation.dart';

@JsonEnum(fieldRename: FieldRename.snake)
enum UserRole { user, staff, manager, admin }

extension UserRoleX on UserRole {
  bool get isStaff => index >= UserRole.staff.index;
  bool get isManager => index >= UserRole.manager.index;
  bool get isAdmin => this == UserRole.admin;
}

@JsonEnum(fieldRename: FieldRename.snake)
enum ClaimStatus { pending, approved, rejected }

@JsonEnum(fieldRename: FieldRename.snake)
enum VisitSource { claim, manual, receipt }

@JsonEnum(fieldRename: FieldRename.snake)
enum XpReason { visit, streak, achievement, manual }

@JsonEnum(fieldRename: FieldRename.snake)
enum CoinReason { visit, achievement, manual, reward, item, expiry, refund }

@JsonEnum(fieldRename: FieldRename.snake)
enum ItemSlot { headgear, handItem, cape, companion, frame }

@JsonEnum(fieldRename: FieldRename.snake)
enum ItemRarity { common, rare, legendary }

@JsonEnum(fieldRename: FieldRename.snake)
enum ItemSource { shop, level, achievement, event }

@JsonEnum(fieldRename: FieldRename.snake)
enum RewardType { merch, drink, discount, priorityBooking, eventAccess }

@JsonEnum(fieldRename: FieldRename.snake)
enum VoucherStatus { active, redeemed, expired, cancelled }

@JsonEnum(fieldRename: FieldRename.snake)
enum PostType { news, event }

@JsonEnum(fieldRename: FieldRename.snake)
enum EventCategory { match, live, quiz, party, special }

@JsonEnum(fieldRename: FieldRename.snake)
enum CheckinStatus { pending, approved, rejected }

/// Base hero art: Held or Heldin. Purely cosmetic; progress is shared.
@JsonEnum(fieldRename: FieldRename.snake)
enum HeroForm { hero, heroine }

/// Database wire value of an enum (snake_case), for RPC arguments and filters.
String enumWire(Enum e) {
  final n = e.name;
  return n.replaceAllMapped(RegExp('[A-Z]'), (m) => '_${m[0]!.toLowerCase()}');
}
