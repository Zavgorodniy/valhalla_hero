import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// The ticket the guest shows at the bar; refreshes until staff confirm it.
class VoucherScreen extends ConsumerStatefulWidget {
  const VoucherScreen({super.key, required this.voucherId});
  final String voucherId;
  @override
  ConsumerState<VoucherScreen> createState() => _VoucherScreenState();
}

class _VoucherScreenState extends ConsumerState<VoucherScreen> {
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _poll = Timer.periodic(const Duration(seconds: 5), (_) => ref.invalidate(myVouchersProvider));
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final profile = ref.watch(profileProvider).valueOrNull;
    final levels = ref.watch(levelMapProvider);
    final v = (ref.watch(myVouchersProvider).valueOrNull ?? const <Voucher>[]).where((x) => x.id == widget.voucherId).firstOrNull;
    if (v != null && v.effectiveStatus != VoucherStatus.active) _poll?.cancel();

    return VScreen(
      glow: VColors.gold,
      child: SafeArea(
        child: Column(children: [
          VTopBar(title: t.segVouchers, back: true),
          Expanded(
            child: v == null
                ? vLoading()
                : ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 24), children: [
                    _Ticket(voucher: v, locale: locale, profile: profile, levelName: profile == null ? '' : levelName(levels, profile.level, profile.heroForm)),
                    const SizedBox(height: 26),
                    Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      _step(1, VIcons.eye, t.stepShowCode),
                      _step(2, VIcons.key, t.stepTeamConfirms),
                      _step(3, VIcons.sparkle, t.stepEnjoy),
                    ]),
                    const SizedBox(height: 20),
                    VCard(
                      color: const Color(0xFF161110),
                      padding: const EdgeInsets.all(14),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        const VIcon(VIcons.info, size: 18, color: VColors.ash, stroke: 1.8),
                        const SizedBox(width: 10),
                        Expanded(child: Text(t.voucherLiveNote, style: VType.body(size: 12.5, color: VColors.ash, height: 1.45))),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    VGhostButton(label: t.myVouchers, icon: VIcons.ticket, onPressed: () => context.go('/shop?seg=2')),
                  ]),
          ),
        ]),
      ),
    );
  }

  Widget _step(int n, VIcons icon, String label) => Expanded(
        child: Column(children: [
          SizedBox(
            width: 50,
            height: 50,
            child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: const Color(0xFF1E1712), shape: BoxShape.circle, border: Border.all(color: VColors.border)),
                child: Center(child: VIcon(icon, size: 20, color: VColors.goldBright, stroke: 1.8)),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: const BoxDecoration(color: VColors.gold, shape: BoxShape.circle),
                  child: Center(child: Text('$n', style: VType.body(size: 10.5, weight: FontWeight.w800, color: VColors.onGold))),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 8),
          Text(label, textAlign: TextAlign.center, style: VType.body(size: 12, weight: FontWeight.w700, color: const Color(0xFFD6CAB4), height: 1.3)),
        ]),
      );
}

class _Ticket extends StatelessWidget {
  const _Ticket({required this.voucher, required this.locale, required this.profile, required this.levelName});
  final Voucher voucher;
  final String locale;
  final Profile? profile;
  final String levelName;

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final st = voucher.effectiveStatus;
    final active = st == VoucherStatus.active;
    final days = voucher.expiresAt.difference(DateTime.now()).inDays;
    final (label, color) = switch (st) {
      VoucherStatus.active => (t.voucherActive, VColors.moss),
      VoucherStatus.redeemed => (t.voucherRedeemed, VColors.goldBright),
      VoucherStatus.expired => (t.voucherExpired, VColors.ash),
      VoucherStatus.cancelled => (t.voucherCancelled, VColors.ash),
    };
    return VOrnateCard(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
      child: Column(children: [
        VEyebrow(t.showThisCode, color: VColors.gold, size: 11),
        const SizedBox(height: 10),
        Text(voucher.reward?.name(locale) ?? '', textAlign: TextAlign.center, style: VType.cinzel(size: 22)),
        const SizedBox(height: 10),
        VStatusPill(label: label, color: color, dot: active, icon: st == VoucherStatus.redeemed ? VIcons.check : null),
        const SizedBox(height: 16),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
          opacity: active ? 1 : .45,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: const Color(0xFF0F0B09),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: VColors.gold.withValues(alpha: .6), width: 1.5),
              boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .1), blurRadius: 30, spreadRadius: -6)],
            ),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Semantics(
                label: voucher.code.split('').join(' '),
                child: Text(
                  voucher.code.length == 6 ? '${voucher.code.substring(0, 3)}-${voucher.code.substring(3)}' : voucher.code,
                  style: VType.body(size: 44, weight: FontWeight.w800, spacing: 5, color: const Color(0xFFFFF3DC), tabular: true)
                      .copyWith(decoration: active ? null : TextDecoration.lineThrough),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          active ? t.validUntilDays(formatDate(voucher.expiresAt, locale: locale), days.clamp(0, 999)) : t.redeemedOn(formatDate(voucher.redeemedAt ?? voucher.expiresAt, locale: locale)),
          style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.ash),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 24,
          child: Stack(clipBehavior: Clip.none, alignment: Alignment.center, children: [
            LayoutBuilder(
              builder: (_, c) => Row(
                children: List.generate((c.maxWidth / 10).floor(), (i) => Expanded(child: Container(height: 1.5, color: i.isEven ? VColors.ornament.withValues(alpha: .45) : Colors.transparent))),
              ),
            ),
            Positioned(left: -32, child: _notch()),
            Positioned(right: -32, child: _notch()),
          ]),
        ),
        const SizedBox(height: 10),
        if (profile != null)
          Row(children: [
            VPortrait(level: profile!.level, form: profile!.heroForm, size: 36),
            const SizedBox(width: 12),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('${profile!.nickname} · ${romanLevel(profile!.level)} $levelName', style: VType.body(size: 14, weight: FontWeight.w800)),
                Text(t.exchangedOn(formatDate(voucher.createdAt, locale: locale), vNum(voucher.pricePaid)), style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
              ]),
            ),
          ]),
      ]),
    );
  }

  Widget _notch() => Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(color: VColors.bg, shape: BoxShape.circle, border: Border.all(color: VColors.ornament.withValues(alpha: .55))),
      );
}
