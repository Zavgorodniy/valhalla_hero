import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';
import 'shop_screen.dart';

/// Münzbeutel: balance, what expires soon, and every credit and spend.
class CoinPurseScreen extends ConsumerWidget {
  const CoinPurseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final coins = ref.watch(profileProvider).valueOrNull?.coinBalance ?? 0;
    final economy = ref.watch(economyProvider).valueOrNull;
    final expiring = ref.watch(expiringCoinsProvider);
    final ledger = ref.watch(coinLedgerProvider);

    return VScreen(
      glow: VColors.gold,
      child: SafeArea(
        child: Column(children: [
          VTopBar(title: t.coinPurse, back: true),
          Expanded(
            child: RefreshIndicator(
              color: VColors.gold,
              onRefresh: () async {
                ref.invalidate(coinLedgerProvider);
                ref.invalidate(profileProvider);
              },
              child: ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 32), children: [
                const Center(child: VCoin(size: 68)),
                const SizedBox(height: 8),
                Center(child: Text(vNum(coins), style: VType.cinzel(size: 44, height: 1))),
                Center(child: Text(t.coinsWord, style: VType.body(size: 14, weight: FontWeight.w700, color: VColors.ash))),
                const SizedBox(height: 22),
                if (expiring != null) ...[
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: VColors.amber.withValues(alpha: .08), borderRadius: BorderRadius.circular(16), border: Border.all(color: VColors.amber.withValues(alpha: .45))),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      const VIcon(VIcons.hourglass, size: 22, color: VColors.amber, stroke: 1.8),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(t.coinsExpireSoon(expiring.$1, formatDate(expiring.$2, locale: locale)), style: VType.body(size: 15, weight: FontWeight.w800)),
                          const SizedBox(height: 3),
                          Text(t.redeemBeforeExpiry, style: VType.body(size: 12.5, color: VColors.ash, height: 1.45)),
                          GestureDetector(
                            onTap: () => context.go('/shop'),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(children: [
                                Text(t.toShop, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.gold)),
                                const VIcon(VIcons.chevRight, size: 15, color: VColors.gold, stroke: 2),
                              ]),
                            ),
                          ),
                        ]),
                      ),
                    ]),
                  ),
                  const SizedBox(height: 14),
                ],
                Row(children: [
                  Expanded(child: _Info(icon: const VIcon(VIcons.clock, size: 18, color: VColors.ash, stroke: 1.8), text: t.expiryInfo(economy?.coinExpiryMonths ?? 36))),
                  const SizedBox(width: 10),
                  Expanded(child: _Info(icon: const VGem(size: 18), text: t.xpNeverExpires)),
                ]),
                const SizedBox(height: 18),
                ...ledger.when(
                  skipLoadingOnReload: true,
                  loading: () => [vLoading()],
                  error: (e, _) => [Text('$e', style: VType.body(size: 12, color: VColors.ash))],
                  data: (entries) {
                    final out = <Widget>[];
                    String? month;
                    for (final e in entries) {
                      final m = DateFormat.yMMMM(locale).format(e.createdAt.toLocal());
                      if (m != month) {
                        month = m;
                        out.add(Padding(padding: const EdgeInsets.only(top: 14, bottom: 4), child: VSectionHeader(m, padding: EdgeInsets.zero)));
                      }
                      out.add(_Row(entry: e, locale: locale));
                    }
                    return out;
                  },
                ),
                const SizedBox(height: 18),
                Text(t.coinsNoCash, textAlign: TextAlign.center, style: VType.body(size: 11.5, color: VColors.ash, height: 1.45)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({required this.icon, required this.text});
  final Widget icon;
  final String text;
  @override
  Widget build(BuildContext context) => VCard(
        color: const Color(0xFF161110),
        radius: 14,
        padding: const EdgeInsets.all(12),
        child: Row(children: [icon, const SizedBox(width: 10), Expanded(child: Text(text, style: VType.body(size: 12.5, weight: FontWeight.w700, color: const Color(0xFFD6CAB4), height: 1.3)))]),
      );
}

class _Row extends StatelessWidget {
  const _Row({required this.entry, required this.locale});
  final CoinLedgerEntry entry;
  final String locale;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final pos = entry.amount >= 0;
    final (icon, title) = switch (entry.reason) {
      CoinReason.visit => (VIcons.seal, t.coinReasonVisit),
      CoinReason.achievement => (VIcons.star, t.coinReasonAchievement),
      CoinReason.manual => (VIcons.key, t.coinReasonManual),
      CoinReason.reward => (VIcons.ticket, t.coinReasonReward),
      CoinReason.item => (VIcons.held, t.coinReasonItem),
      CoinReason.expiry => (VIcons.hourglass, t.coinReasonExpiry),
      CoinReason.refund => (VIcons.arrowUp, t.coinReasonRefund),
      CoinReason.checkin => (VIcons.camera, t.coinReasonCheckin),
    };
    final color = entry.reason == CoinReason.expiry ? VColors.amber : (pos ? VColors.goldBright : const Color(0xFFCFC2AE));
    return Container(
      height: 62,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Color(0xB33A302A)))),
      child: Row(children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: const Color(0xFF1C1511), borderRadius: BorderRadius.circular(12), border: Border.all(color: VColors.border)),
          child: Center(child: VIcon(icon, size: 18, color: color, stroke: 1.8)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: VType.body(size: 14.5, weight: FontWeight.w800)),
            Text(
              entry.expiresAt != null && entry.remaining > 0
                  ? '${formatDate(entry.createdAt, locale: locale)} · ${t.validUntil(formatDate(entry.expiresAt!, locale: locale))}'
                  : formatDate(entry.createdAt, locale: locale),
              style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash),
            ),
          ]),
        ),
        Text('${pos ? '+' : ''}${vNum(entry.amount)}', style: VType.body(size: 15, weight: FontWeight.w800, color: color, tabular: true)),
      ]),
    );
  }
}
