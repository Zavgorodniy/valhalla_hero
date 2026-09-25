import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

enum ItemState { equipped, owned, buyable, locked }

ItemState itemState(Item item, {required Set<String> owned, required Set<String> equipped}) {
  if (equipped.contains(item.id)) return ItemState.equipped;
  if (owned.contains(item.id)) return ItemState.owned;
  if (item.source == ItemSource.shop) return ItemState.buyable;
  return ItemState.locked;
}

/// Tile of the wardrobe grid: art, rarity, and what the guest can do with it.
class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item, required this.state, required this.lockText, required this.locale, this.selected = false, this.onTap});
  final Item item;
  final ItemState state;
  final String lockText;
  final String locale;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final c = VColors.rarity(item.rarity);
    final locked = state == ItemState.locked;
    final status = switch (state) {
      ItemState.equipped => Row(mainAxisSize: MainAxisSize.min, children: [
          const VIcon(VIcons.check, size: 13, color: VColors.moss, stroke: 2.6),
          const SizedBox(width: 4),
          Text(t.equipped, style: VType.body(size: 11.5, weight: FontWeight.w800, color: VColors.moss)),
        ]),
      ItemState.owned => Text(t.owned, style: VType.body(size: 11.5, weight: FontWeight.w800, color: VColors.ash)),
      ItemState.buyable => Row(mainAxisSize: MainAxisSize.min, children: [
          const VCoin(size: 14),
          const SizedBox(width: 5),
          Text(vNum(item.priceCoins ?? 0), style: VType.body(size: 11.5, weight: FontWeight.w800, color: VColors.goldBright, tabular: true)),
        ]),
      ItemState.locked => Row(mainAxisSize: MainAxisSize.min, children: [
          const VIcon(VIcons.lock, size: 12, color: VColors.ash, stroke: 2),
          const SizedBox(width: 4),
          Flexible(child: Text(lockText, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 11.5, weight: FontWeight.w800, color: VColors.ash))),
        ]),
    };
    return Semantics(
      button: true,
      selected: selected,
      label: item.name(locale),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF221A14), Color(0xFF161110)]),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: selected ? VColors.goldBright : VColors.border, width: selected ? 1.5 : 1),
            boxShadow: selected ? [BoxShadow(color: VColors.gold.withValues(alpha: .25), blurRadius: 20)] : null,
          ),
          child: Stack(children: [
            Positioned(left: 0, right: 0, bottom: 0, child: Container(height: 3, color: c.withValues(alpha: .85))),
            Positioned(top: 9, left: 9, child: Transform.rotate(angle: .785, child: Container(width: 7, height: 7, color: c))),
            if (state == ItemState.equipped)
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(color: VColors.moss, shape: BoxShape.circle),
                  child: const Center(child: VIcon(VIcons.check, size: 12, color: Color(0xFF101A0B), stroke: 3)),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 10, 6, 10),
              child: Column(children: [
                Expanded(
                  child: Opacity(
                    opacity: locked ? .45 : 1,
                    child: Center(child: VItemArt(assetKey: item.assetKey, slot: item.slot, size: 70)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(item.name(locale),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: VType.body(size: 12.5, weight: FontWeight.w800, height: 1.2, color: locked ? const Color(0xFFB9AD9B) : VColors.bone)),
                const SizedBox(height: 4),
                status,
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Buy / equip / unequip, shared by the hero screen and the shop.
class ItemActions {
  static Future<bool> buyAndEquip(BuildContext context, WidgetRef ref, Item item) async {
    final t = L10n.of(context);
    try {
      await ref.read(shopRepoProvider).purchaseItem(item.id);
      await ref.read(shopRepoProvider).equip(item.id);
      invalidateUserData(ref);
      if (context.mounted) showSnack(context, t.purchaseDone);
      return true;
    } on ApiError catch (e) {
      if (context.mounted) showSnack(context, e.code == ApiErrorCode.insufficientCoins ? t.insufficientCoins : e.message, error: true);
      return false;
    }
  }

  static Future<void> equip(WidgetRef ref, Item item) async {
    await ref.read(shopRepoProvider).equip(item.id);
    ref.invalidate(myEquipmentProvider);
    ref.invalidate(leaderboardProvider);
  }

  static Future<void> unequip(WidgetRef ref, ItemSlot slot) async {
    await ref.read(shopRepoProvider).unequip(slot);
    ref.invalidate(myEquipmentProvider);
    ref.invalidate(leaderboardProvider);
  }
}

/// Bottom bar describing the selected item and its one action.
class ItemActionBar extends ConsumerStatefulWidget {
  const ItemActionBar({super.key, required this.item, required this.state, required this.lockText});
  final Item item;
  final ItemState state;
  final String lockText;
  @override
  ConsumerState<ItemActionBar> createState() => _ItemActionBarState();
}

class _ItemActionBarState extends ConsumerState<ItemActionBar> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() fn) async {
    setState(() => _busy = true);
    try {
      await fn();
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.message, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final coins = ref.watch(profileProvider).valueOrNull?.coinBalance ?? 0;
    final item = widget.item;
    final price = item.priceCoins ?? 0;
    Widget? action;
    String sub = t.cosmeticOnly;
    switch (widget.state) {
      case ItemState.equipped:
        action = SizedBox(width: 118, child: VSecondaryButton(label: t.unequip, height: 48, onPressed: _busy ? null : () => _run(() => ItemActions.unequip(ref, item.slot))));
      case ItemState.owned:
        action = SizedBox(width: 118, child: VPrimaryButton(label: t.equip, height: 48, busy: _busy, onPressed: () => _run(() => ItemActions.equip(ref, item))));
      case ItemState.buyable:
        if (coins >= price) {
          action = SizedBox(
            width: 150,
            child: VPrimaryButton(
              label: vNum(price),
              leading: const VCoin(size: 18),
              height: 48,
              busy: _busy,
              onPressed: () => _run(() => ItemActions.buyAndEquip(context, ref, item)),
            ),
          );
        } else {
          sub = t.missingCoins(vNum(price - coins));
        }
      case ItemState.locked:
        sub = widget.lockText;
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Color(0xFF1C1511), Color(0xFF130F0C)]),
        border: Border(top: BorderSide(color: VColors.ornament.withValues(alpha: .45))),
      ),
      child: Row(children: [
        VItemArt(assetKey: item.assetKey, slot: item.slot, size: 46),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(item.name(locale), maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 15, weight: FontWeight.w800)),
            const SizedBox(height: 4),
            Row(children: [
              VRarityChip(rarity: item.rarity, label: rarityName(t, item.rarity), small: true),
              if (widget.state == ItemState.locked || sub != t.cosmeticOnly) ...[
                const SizedBox(width: 6),
                Flexible(child: Text(sub, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash))),
              ],
            ]),
          ]),
        ),
        if (action != null) ...[const SizedBox(width: 10), action],
      ]),
    );
  }
}
