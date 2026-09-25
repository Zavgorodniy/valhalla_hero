import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

/// Space reserved at the bottom of tab screens for the floating tab bar.
const kTabBarSpace = 120.0;

/// Top bar laid over screens (no Material AppBar): back button, title, actions.
class VTopBar extends StatelessWidget {
  const VTopBar({super.key, this.title, this.back = false, this.onBack, this.actions = const [], this.leading});
  final String? title;
  final bool back;
  final VoidCallback? onBack;
  final List<Widget> actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: Row(children: [
        const SizedBox(width: 8),
        if (back)
          VRoundButton(
            icon: VIcons.chevLeft,
            tooltip: MaterialLocalizations.of(context).backButtonTooltip,
            onTap: onBack ?? () => context.canPop() ? context.pop() : context.go('/home'),
          )
        else
          const SizedBox(width: 8),
        ?leading,
        if (title != null)
          Expanded(child: Padding(padding: const EdgeInsets.only(left: 6), child: Text(title!, overflow: TextOverflow.ellipsis, style: VType.title(size: 21))))
        else
          const Spacer(),
        ...actions,
        const SizedBox(width: 8),
      ]),
    );
  }
}

/// Short code shown to guests and staff to match a visit claim (#4F2).
String claimCode(String claimId) => '#${claimId.replaceAll('-', '').substring(0, 3).toUpperCase()}';

String levelName(Map<int, Level> levels, int level, HeroForm form) => levels[level]?.nameFor(form) ?? romanLevel(level);

bool isOnBoard(DateTime? lastVisit, int windowDays) =>
    lastVisit != null && lastVisit.isAfter(DateTime.now().subtract(Duration(days: windowDays)));

DateTime weekStart(DateTime d) {
  final local = d.toLocal();
  return DateTime(local.year, local.month, local.day).subtract(Duration(days: local.weekday - 1));
}

int isoWeek(DateTime d) {
  final thursday = d.add(Duration(days: 4 - d.weekday));
  final firstJan = DateTime(thursday.year, 1, 1);
  return 1 + thursday.difference(firstJan).inDays ~/ 7;
}

String multiplierText(num m, String locale) {
  final s = m.toStringAsFixed(2);
  return locale == 'de' ? s.replaceAll('.', ',') : s;
}

String slotName(L10n t, ItemSlot s) => switch (s) {
      ItemSlot.headgear => t.slotHeadgear,
      ItemSlot.handItem => t.slotHandItem,
      ItemSlot.cape => t.slotCape,
      ItemSlot.companion => t.slotCompanion,
      ItemSlot.frame => t.slotFrame,
    };

VIcons slotIcon(ItemSlot s) => switch (s) {
      ItemSlot.headgear => VIcons.held,
      ItemSlot.handItem => VIcons.axe,
      ItemSlot.cape => VIcons.cape,
      ItemSlot.companion => VIcons.raven,
      ItemSlot.frame => VIcons.frame,
    };

String rarityName(L10n t, ItemRarity r) => switch (r) { ItemRarity.common => t.rarityCommon, ItemRarity.rare => t.rarityRare, ItemRarity.legendary => t.rarityLegendary };

String rewardTypeName(L10n t, RewardType type) => switch (type) {
      RewardType.merch => t.rewardTypeMerch,
      RewardType.drink => t.rewardTypeDrink,
      RewardType.discount => t.rewardTypeDiscount,
      RewardType.priorityBooking => t.rewardTypePriorityBooking,
      RewardType.eventAccess => t.rewardTypeEventAccess,
    };

MedalTier medalTier(Achievement a) {
  if (a.key.startsWith('level_')) return MedalTier.rune;
  if (a.xpReward >= 250) return MedalTier.gold;
  if (a.xpReward >= 80) return MedalTier.silver;
  return MedalTier.bronze;
}

/// Progress towards an achievement from profile counters, when derivable.
(int, int)? achievementProgress(String key, Profile p) {
  final visits = RegExp(r'^visits_(\d+)$').firstMatch(key);
  if (visits != null) return (p.visitCount, int.parse(visits[1]!));
  final streak = RegExp(r'^streak_(\d+)w$').firstMatch(key);
  if (streak != null) return (p.longestStreakWeeks, int.parse(streak[1]!));
  final level = RegExp(r'^level_(\d+)$').firstMatch(key);
  if (level != null) return (p.level, int.parse(level[1]!));
  return null;
}

/// Why a locked item is locked, in words.
String unlockText(L10n t, Item item, List<Achievement> achievements, String locale) => switch (item.source) {
      ItemSource.shop => '',
      ItemSource.level => t.unlockAtLevel(item.unlockLevel ?? 1),
      ItemSource.achievement => t.unlockByAchievement(achievements.where((a) => a.key == item.unlockAchievementKey).firstOrNull?.name(locale) ?? '…'),
      ItemSource.event => t.unlockByEvent,
    };

Widget vLoading() => const Center(child: SizedBox(width: 26, height: 26, child: CircularProgressIndicator(strokeWidth: 2.4)));

/// Standard screen scaffold with the night-hall background.
class VScreen extends StatelessWidget {
  const VScreen({super.key, required this.child, this.glow});
  final Widget child;
  final Color? glow;
  @override
  Widget build(BuildContext context) => Scaffold(backgroundColor: VColors.bg, body: VBackground(glow: glow, child: child));
}

String dayAbbrev(L10n t, int weekday) => switch (weekday) {
      1 => t.dayMon,
      2 => t.dayTue,
      3 => t.dayWed,
      4 => t.dayThu,
      5 => t.dayFri,
      6 => t.daySat,
      _ => t.daySun,
    };
