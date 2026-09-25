import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import '../hero/item_tile.dart';

/// Coins that expire within 30 days: (sum, earliest date).
final expiringCoinsProvider = Provider<(int, DateTime)?>((ref) {
  final ledger = ref.watch(coinLedgerProvider).valueOrNull ?? const <CoinLedgerEntry>[];
  final soon = DateTime.now().add(const Duration(days: 30));
  final entries = ledger.where((e) => e.remaining > 0 && e.expiresAt != null && e.expiresAt!.isBefore(soon)).toList();
  if (entries.isEmpty) return null;
  entries.sort((a, b) => a.expiresAt!.compareTo(b.expiresAt!));
  return (entries.fold(0, (s, e) => s + e.remaining), entries.first.expiresAt!);
});

/// Beute: rewards to redeem, cosmetic gear, and the guest's vouchers.
class ShopScreen extends ConsumerStatefulWidget {
  const ShopScreen({super.key, this.initialSegment = 0});
  final int initialSegment;
  @override
  ConsumerState<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends ConsumerState<ShopScreen> {
  late int _seg = widget.initialSegment.clamp(0, 2);
  RewardType? _filter;
  String? _selectedItem;

  @override
  void didUpdateWidget(covariant ShopScreen old) {
    super.didUpdateWidget(old);
    if (old.initialSegment != widget.initialSegment) _seg = widget.initialSegment.clamp(0, 2);
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final profile = ref.watch(profileProvider).valueOrNull;
    final coins = profile?.coinBalance ?? 0;
    final expiring = ref.watch(expiringCoinsProvider);
    final activeVouchers = (ref.watch(myVouchersProvider).valueOrNull ?? const <Voucher>[]).where((v) => v.effectiveStatus == VoucherStatus.active).length;

    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    final owned = (ref.watch(myItemsProvider).valueOrNull ?? const <UserItem>[]).map((i) => i.itemId).toSet();
    final equipped = (ref.watch(myEquipmentProvider).valueOrNull ?? const <Equipment>[]).map((e) => e.itemId).toSet();
    final achievements = ref.watch(achievementsProvider).valueOrNull ?? const <Achievement>[];
    final selected = _seg == 1 ? items.where((i) => i.id == _selectedItem).firstOrNull : null;
    final shopItems = _seg == 1 ? _shopOrder(items, owned, equipped) : const <Item>[];

    return Scaffold(
      backgroundColor: VColors.bg,
      body: VBackground(
        glow: VColors.gold,
        child: Stack(children: [
          RefreshIndicator(
            color: VColors.gold,
            onRefresh: () async => invalidateUserData(ref),
            child: CustomScrollView(slivers: [
              SliverSafeArea(
                bottom: false,
                sliver: SliverToBoxAdapter(
                  child: VTopBar(title: t.tabShop, actions: [
                    VRoundButton(icon: VIcons.ticket, tooltip: t.myVouchers, dot: activeVouchers > 0, onTap: () => setState(() => _seg = 2)),
                  ]),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
                sliver: SliverToBoxAdapter(
                  child: VOrnateCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(children: [
                      Row(children: [
                        const VCoin(size: 46),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(t.yourBalance, style: VType.body(size: 12, weight: FontWeight.w700, color: VColors.ash)),
                            Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                              Text(vNum(coins), style: VType.cinzel(size: 32, height: 1.1)),
                              const SizedBox(width: 6),
                              Text(t.coinsWord, style: VType.body(size: 14, weight: FontWeight.w700, color: VColors.ash)),
                            ]),
                          ]),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/coins'),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(children: [
                              Text(t.coinPurse, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.gold)),
                              const VIcon(VIcons.chevRight, size: 16, color: VColors.gold, stroke: 2),
                            ]),
                          ),
                        ),
                      ]),
                      if (expiring != null) ...[
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => context.push('/coins'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            decoration: BoxDecoration(color: VColors.amber.withValues(alpha: .1), borderRadius: BorderRadius.circular(10), border: Border.all(color: VColors.amber.withValues(alpha: .35))),
                            child: Row(children: [
                              const VIcon(VIcons.hourglass, size: 15, color: VColors.amber, stroke: 1.9),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(t.coinsExpireSoon(expiring.$1, formatDate(expiring.$2, locale: locale)),
                                    style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.amber)),
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ]),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
                sliver: SliverToBoxAdapter(
                  child: VSegmented(
                    labels: [t.rewards, t.gear, activeVouchers > 0 ? '${t.segVouchers} · $activeVouchers' : t.segVouchers],
                    index: _seg,
                    onChanged: (i) => setState(() {
                      _seg = i;
                      _selectedItem = null;
                    }),
                  ),
                ),
              ),
              if (_seg == 0) ..._rewards(t, locale, coins),
              if (_seg == 1)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10, mainAxisExtent: 150),
                    itemCount: shopItems.length,
                    itemBuilder: (_, i) {
                      final it = shopItems[i];
                      return ItemTile(
                        item: it,
                        state: itemState(it, owned: owned, equipped: equipped),
                        lockText: unlockText(t, it, achievements, locale),
                        locale: locale,
                        selected: it.id == _selectedItem,
                        onTap: () => setState(() => _selectedItem = _selectedItem == it.id ? null : it.id),
                      );
                    },
                  ),
                ),
              if (_seg == 2) const _Vouchers(),
              SliverToBoxAdapter(child: SizedBox(height: kTabBarSpace + (selected != null ? 76 : 0))),
            ]),
          ),
          if (selected != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 66 + MediaQuery.paddingOf(context).bottom,
              child: ItemActionBar(
                key: ValueKey(selected.id),
                item: selected,
                state: itemState(selected, owned: owned, equipped: equipped),
                lockText: unlockText(t, selected, achievements, locale),
              ),
            ),
        ]),
      ),
    );
  }

  List<Item> _shopOrder(List<Item> items, Set<String> owned, Set<String> equipped) {
    int rank(Item i) => switch (itemState(i, owned: owned, equipped: equipped)) {
          ItemState.buyable => 0,
          ItemState.equipped => 1,
          ItemState.owned => 2,
          ItemState.locked => 3,
        };
    return [...items]..sort((a, b) {
        final r = rank(a).compareTo(rank(b));
        return r != 0 ? r : a.sort.compareTo(b.sort);
      });
  }

  List<Widget> _rewards(L10n t, String locale, int coins) {
    final all = ref.watch(rewardsProvider).valueOrNull ?? const <Reward>[];
    final types = {for (final r in all) r.type}.toList()..sort((a, b) => a.index.compareTo(b.index));
    final list = all.where((r) => _filter == null || r.type == _filter).toList();
    final featured = ([...all.where((r) => r.stock != null && !r.soldOut)]..sort((a, b) => b.priceCoins.compareTo(a.priceCoins))).firstOrNull;
    return [
      SliverToBoxAdapter(
        child: SizedBox(
          height: 34,
          child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal: 20), children: [
            Padding(padding: const EdgeInsets.only(right: 8), child: VChip(label: t.all, active: _filter == null, onTap: () => setState(() => _filter = null))),
            for (final ty in types)
              Padding(padding: const EdgeInsets.only(right: 8), child: VChip(label: rewardTypeName(t, ty), active: _filter == ty, onTap: () => setState(() => _filter = ty))),
          ]),
        ),
      ),
      if (featured != null && _filter == null)
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
          sliver: SliverToBoxAdapter(child: _Featured(reward: featured, coins: coins)),
        ),
      SliverPadding(padding: const EdgeInsets.fromLTRB(0, 24, 0, 14), sliver: SliverToBoxAdapter(child: VSectionHeader(t.allRewards))),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        sliver: SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, mainAxisExtent: 232),
          itemCount: list.length,
          itemBuilder: (_, i) => RewardCard(reward: list[i], coins: coins),
        ),
      ),
    ];
  }
}

class _Featured extends ConsumerWidget {
  const _Featured({required this.reward, required this.coins});
  final Reward reward;
  final int coins;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final economy = ref.watch(economyProvider).valueOrNull;
    final missing = reward.priceCoins - coins;
    final perVisit = ((economy?.coinsPerEuro ?? 10) * 35).round();
    return GestureDetector(
      onTap: () => openRedeemSheet(context, reward),
      child: VOrnateCard(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
          height: 136,
          child: Stack(children: [
            Positioned(
              right: -6,
              top: 0,
              width: 150,
              height: 104,
              child: reward.type == RewardType.merch && reward.imageUrl == null
                  ? ShaderMask(
                      shaderCallback: (r) => const RadialGradient(colors: [Colors.white, Colors.white, Colors.transparent], stops: [0, .7, 1]).createShader(r),
                      blendMode: BlendMode.dstIn,
                      child: VArt.image(VArt.scene('horn')),
                    )
                  : VRewardArt(type: reward.type, imageUrl: reward.imageUrl, height: 104, radius: BorderRadius.circular(12)),
            ),
            Positioned(
              left: 0,
              top: 0,
              width: 176,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                VRarityChip(rarity: ItemRarity.legendary, label: rewardTypeName(t, reward.type), small: true),
                const SizedBox(height: 6),
                Text(reward.name(locale), maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.cinzel(size: 18, height: 1.2)),
                if (reward.description(locale) != null)
                  Text(reward.description(locale)!, maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 12.5, color: VColors.ash)),
              ]),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  const VCoin(size: 15),
                  const SizedBox(width: 6),
                  Text(vNum(reward.priceCoins), style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.goldBright, tabular: true)),
                  const Spacer(),
                  if (reward.stock != null) Text(t.stockLeft(reward.stock!), style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.amber)),
                ]),
                const SizedBox(height: 6),
                VGoldBar(progress: coins / reward.priceCoins),
                if (missing > 0) ...[
                  const SizedBox(height: 6),
                  Text('${t.missingCoins(vNum(missing))} · ≈ ${t.visitsCount((missing / perVisit).ceil())}',
                      style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.ash)),
                ],
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}

class RewardCard extends ConsumerWidget {
  const RewardCard({super.key, required this.reward, required this.coins});
  final Reward reward;
  final int coins;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final affordable = coins >= reward.priceCoins && !reward.soldOut;
    return Semantics(
      button: true,
      label: reward.name(locale),
      child: GestureDetector(
        onTap: reward.soldOut ? null : () => openRedeemSheet(context, reward),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(gradient: VColors.cardGradient, borderRadius: BorderRadius.circular(16), border: Border.all(color: VColors.border)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            VRewardArt(type: reward.type, imageUrl: reward.imageUrl, height: 112),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(rewardTypeName(t, reward.type).toUpperCase(), style: VType.body(size: 10.5, weight: FontWeight.w800, color: VColors.ash, spacing: 1.2)),
                  const SizedBox(height: 4),
                  Text(reward.name(locale), maxLines: 2, overflow: TextOverflow.ellipsis, style: VType.body(size: 14.5, weight: FontWeight.w800, height: 1.25)),
                  const Spacer(),
                  Row(children: [
                    const VCoin(size: 16),
                    const SizedBox(width: 5),
                    Text(vNum(reward.priceCoins), style: VType.body(size: 15, weight: FontWeight.w800, color: affordable ? VColors.goldBright : const Color(0xFFB59D76), tabular: true)),
                    const Spacer(),
                    if (reward.soldOut)
                      Text(t.outOfStock, style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.bloodText))
                    else if (reward.stock != null)
                      Text(t.stockLeft(reward.stock!), style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.amber)),
                  ]),
                  if (!affordable && !reward.soldOut)
                    Text(t.missingCoins(vNum(reward.priceCoins - coins)), style: VType.body(size: 11.5, weight: FontWeight.w700, color: VColors.ash)),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Redeem confirmation: shows the maths and needs a press-and-hold.
Future<void> openRedeemSheet(BuildContext context, Reward reward) async {
  final router = GoRouter.of(context);
  final id = await showVSheet<String>(context, builder: (_) => _RedeemSheet(reward: reward));
  if (id != null) router.push('/voucher/$id');
}

class _RedeemSheet extends ConsumerStatefulWidget {
  const _RedeemSheet({required this.reward});
  final Reward reward;
  @override
  ConsumerState<_RedeemSheet> createState() => _RedeemSheetState();
}

class _RedeemSheetState extends ConsumerState<_RedeemSheet> {
  bool _busy = false;

  Future<void> _redeem() async {
    final t = L10n.of(context);
    setState(() => _busy = true);
    try {
      final v = await ref.read(shopRepoProvider).redeemReward(widget.reward.id);
      invalidateUserData(ref);
      if (mounted) Navigator.of(context).pop(v.id);
    } on ApiError catch (e) {
      if (mounted) {
        showSnack(context, switch (e.code) { ApiErrorCode.insufficientCoins => t.insufficientCoins, ApiErrorCode.outOfStock => t.outOfStock, _ => e.message }, error: true);
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final coins = ref.watch(profileProvider).valueOrNull?.coinBalance ?? 0;
    final r = widget.reward;
    final after = coins - r.priceCoins;
    Widget row(String k, Widget v) => SizedBox(
          height: 42,
          child: Row(children: [Text(k, style: VType.body(size: 14, weight: FontWeight.w600, color: VColors.ash)), const Spacer(), v]),
        );
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Container(
              width: 96,
              height: 96,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: VColors.ornament.withValues(alpha: .5))),
              child: VRewardArt(type: r.type, imageUrl: r.imageUrl, height: 96, radius: BorderRadius.zero),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(rewardTypeName(t, r.type).toUpperCase(), style: VType.body(size: 10.5, weight: FontWeight.w800, color: VColors.ash, spacing: 1.2)),
                const SizedBox(height: 4),
                Text(r.name(locale), style: VType.cinzel(size: 21, height: 1.2)),
              ]),
            ),
            VRoundButton(icon: VIcons.close, tooltip: t.close, background: VColors.surface2, onTap: () => Navigator.of(context).pop()),
          ]),
          if (r.description(locale) != null) ...[
            const SizedBox(height: 14),
            Text(r.description(locale)!, style: VType.body(size: 14, color: VColors.ash, height: 1.5)),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFF171210), borderRadius: BorderRadius.circular(16), border: Border.all(color: VColors.border)),
            child: Column(children: [
              row(t.priceLabel, Row(children: [const VCoin(size: 16), const SizedBox(width: 6), Text(vNum(r.priceCoins), style: VType.body(size: 14, weight: FontWeight.w800, color: VColors.goldBright, tabular: true))])),
              const Divider(),
              row(
                t.balanceAfter,
                Row(children: [
                  Text(vNum(coins), style: VType.body(size: 14, weight: FontWeight.w700, color: VColors.ash).copyWith(decoration: TextDecoration.lineThrough)),
                  const VIcon(VIcons.chevRight, size: 14, color: VColors.ash, stroke: 2),
                  Text(vNum(after), style: VType.body(size: 14, weight: FontWeight.w800, color: after < 0 ? VColors.bloodText : VColors.bone, tabular: true)),
                ]),
              ),
              const Divider(),
              row(t.validLabel, Text(t.validDays(r.validityDays), style: VType.body(size: 14, weight: FontWeight.w800))),
              const Divider(),
              row(t.redeemHow, Text(t.showCodeAtBar, style: VType.body(size: 14, weight: FontWeight.w800))),
            ]),
          ),
          const SizedBox(height: 18),
          if (_busy)
            const SizedBox(height: 56, child: Center(child: CircularProgressIndicator()))
          else if (after < 0)
            VSecondaryButton(label: t.missingCoins(vNum(-after)), onPressed: null)
          else
            VHoldButton(label: t.holdToRedeem, onConfirmed: _redeem),
          const SizedBox(height: 10),
          Text(t.holdHint, textAlign: TextAlign.center, style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
        ]),
      ),
    );
  }
}

class _Vouchers extends ConsumerWidget {
  const _Vouchers();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final list = [...(ref.watch(myVouchersProvider).valueOrNull ?? const <Voucher>[])]
      ..sort((a, b) {
        final r = (a.effectiveStatus == VoucherStatus.active ? 0 : 1).compareTo(b.effectiveStatus == VoucherStatus.active ? 0 : 1);
        return r != 0 ? r : b.createdAt.compareTo(a.createdAt);
      });
    if (list.isEmpty) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(children: [
            ClipRRect(borderRadius: BorderRadius.circular(18), child: VArt.image(VArt.scene('empty'), width: 140, height: 140)),
            const SizedBox(height: 14),
            Text(t.noVouchers, textAlign: TextAlign.center, style: VType.body(size: 14, color: VColors.ash)),
          ]),
        ),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      sliver: SliverList.separated(
        itemCount: list.length,
        separatorBuilder: (_, _) => const SizedBox(height: 10),
        itemBuilder: (_, i) {
          final v = list[i];
          final st = v.effectiveStatus;
          final active = st == VoucherStatus.active;
          final color = switch (st) { VoucherStatus.active => VColors.moss, VoucherStatus.redeemed => VColors.ash, _ => VColors.ash2 };
          return VCard(
            onTap: () => context.push('/voucher/${v.id}'),
            borderColor: active ? VColors.gold.withValues(alpha: .45) : null,
            padding: const EdgeInsets.all(12),
            child: Row(children: [
              Container(
                width: 56,
                height: 56,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: v.reward == null ? const SizedBox() : VRewardArt(type: v.reward!.type, imageUrl: v.reward!.imageUrl, height: 56, radius: BorderRadius.zero),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(v.reward?.name(locale) ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 15, weight: FontWeight.w800)),
                  Text(
                    active ? t.validUntil(formatDate(v.expiresAt, locale: locale)) : t.redeemedOn(formatDate(v.redeemedAt ?? v.expiresAt, locale: locale)),
                    style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash),
                  ),
                ]),
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(v.code,
                    style: VType.body(size: active ? 17 : 13, weight: FontWeight.w800, spacing: 1.5, color: active ? VColors.bone : VColors.ash2)
                        .copyWith(decoration: active ? null : TextDecoration.lineThrough)),
                Text(
                  switch (st) { VoucherStatus.active => t.voucherActive, VoucherStatus.redeemed => t.voucherRedeemed, VoucherStatus.expired => t.voucherExpired, VoucherStatus.cancelled => t.voucherCancelled },
                  style: VType.body(size: 11, weight: FontWeight.w800, color: color),
                ),
              ]),
            ]),
          );
        },
      ),
    );
  }
}
