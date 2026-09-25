import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// Team mode at the bar. Frost accent so it never looks like the guest app.
class StaffScreen extends ConsumerStatefulWidget {
  const StaffScreen({super.key});
  @override
  ConsumerState<StaffScreen> createState() => _StaffScreenState();
}

class _StaffScreenState extends ConsumerState<StaffScreen> {
  int _seg = 0;
  Timer? _poll;

  @override
  void initState() {
    super.initState();
    _poll = Timer.periodic(const Duration(seconds: 10), (_) => ref.invalidate(pendingClaimsProvider));
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final pending = ref.watch(pendingClaimsProvider).valueOrNull?.length ?? 0;
    final venue = ref.watch(activeVenuesProvider).valueOrNull?.firstOrNull;
    return VScreen(
      glow: VColors.frost,
      child: Column(children: [
        Container(height: 4, decoration: const BoxDecoration(gradient: LinearGradient(colors: [VColors.frost, Color(0xFF3E8AA3)]))),
        Expanded(
          child: SafeArea(
            top: true,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
                child: Row(children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(color: VColors.frost.withValues(alpha: .12), borderRadius: BorderRadius.circular(12), border: Border.all(color: VColors.frost.withValues(alpha: .45))),
                    child: const Center(child: VIcon(VIcons.key, size: 20, color: VColors.frostBright, stroke: 1.9)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        Text(t.counter, style: VType.cinzel(size: 20)),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(color: VColors.frost.withValues(alpha: .15), borderRadius: BorderRadius.circular(6), border: Border.all(color: VColors.frost.withValues(alpha: .45))),
                          child: Text(t.teamModeBadge, style: VType.body(size: 10, weight: FontWeight.w800, color: VColors.frostBright, spacing: .8)),
                        ),
                      ]),
                      if (venue != null) Text('${venue.name} · ${venue.city ?? ''}', style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
                    ]),
                  ),
                  TextButton(
                    onPressed: () => context.canPop() ? context.pop() : context.go('/home'),
                    child: Text(t.exitTeam, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.frostBright)),
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: VSegmented(labels: [t.claimsTab(pending), t.voucherCheckTab], index: _seg, onChanged: (i) => setState(() => _seg = i)),
              ),
              Expanded(child: _seg == 0 ? const _Claims() : const _VoucherCheck()),
            ]),
          ),
        ),
      ]),
    );
  }
}

class _Claims extends ConsumerWidget {
  const _Claims();

  Future<void> _review(BuildContext context, WidgetRef ref, VisitClaim c, bool approve) async {
    final t = L10n.of(context);
    String? reason;
    if (!approve) {
      final ctrl = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(t.staffReject),
          content: TextField(controller: ctrl, decoration: InputDecoration(hintText: t.staffRejectReason)),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)),
            TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.staffReject, style: VType.body(size: 14, weight: FontWeight.w800, color: VColors.bloodText))),
          ],
        ),
      );
      if (ok != true) return;
      reason = ctrl.text.trim().isEmpty ? null : ctrl.text.trim();
    }
    try {
      await ref.read(visitRepoProvider).review(c.id, approve: approve, reason: reason);
      HapticFeedback.mediumImpact();
      ref.invalidate(pendingClaimsProvider);
      ref.invalidate(leaderboardProvider);
    } on ApiError catch (e) {
      if (context.mounted) showSnack(context, e.message, error: true);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final claims = ref.watch(pendingClaimsProvider);
    final levels = ref.watch(levelMapProvider);
    return RefreshIndicator(
      color: VColors.frost,
      onRefresh: () async => ref.invalidate(pendingClaimsProvider),
      child: claims.when(
        skipLoadingOnReload: true,
        loading: vLoading,
        error: (e, _) => ListView(children: [Padding(padding: const EdgeInsets.all(24), child: Text('$e', style: VType.body(size: 12, color: VColors.ash)))]),
        data: (list) => list.isEmpty
            ? ListView(children: [
                const SizedBox(height: 80),
                const Center(child: VIcon(VIcons.check, size: 44, color: VColors.moss, stroke: 1.6)),
                const SizedBox(height: 12),
                Center(child: Text(t.staffClaimsEmpty, style: VType.body(size: 14, color: VColors.ash))),
              ])
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
                itemCount: list.length,
                separatorBuilder: (_, _) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final c = list[i];
                  final p = c.profile;
                  final lvl = p?.level ?? 1;
                  final form = p?.heroForm ?? HeroForm.hero;
                  final ago = DateTime.now().difference(c.createdAt);
                  final agoText = ago.inMinutes < 1 ? '< 1 min' : (ago.inHours < 1 ? '${ago.inMinutes} min' : formatDateTime(c.createdAt, locale: locale));
                  return VCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(children: [
                        VPortrait(level: lvl, form: form, size: 40),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(p?.nickname ?? '—', style: VType.body(size: 16, weight: FontWeight.w800)),
                            Text('${romanLevel(lvl)} · ${levelName(levels, lvl, form)}', style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
                          ]),
                        ),
                        Container(
                          height: 36,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(color: VColors.frost.withValues(alpha: .08), borderRadius: BorderRadius.circular(10), border: Border.all(color: VColors.frost.withValues(alpha: .6), width: 1.5)),
                          child: Center(child: Text(claimCode(c.id), style: VType.body(size: 20, weight: FontWeight.w800, color: VColors.frostBright, spacing: 1.5, tabular: true))),
                        ),
                      ]),
                      const SizedBox(height: 12),
                      Row(children: [
                        Text(formatEuro(c.amountCents, locale: locale), style: VType.body(size: 24, weight: FontWeight.w800, tabular: true)),
                        const SizedBox(width: 10),
                        Text(agoText, style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.ash)),
                        const Spacer(),
                        if (c.note != null)
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                              decoration: BoxDecoration(color: VColors.surface2, borderRadius: BorderRadius.circular(99), border: Border.all(color: VColors.border)),
                              child: Text('„${c.note}“', maxLines: 1, overflow: TextOverflow.ellipsis, style: VType.body(size: 12, weight: FontWeight.w700, color: const Color(0xFFD6CAB4))),
                            ),
                          ),
                      ]),
                      if (c.amountCents >= 10000) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          decoration: BoxDecoration(color: VColors.amber.withValues(alpha: .1), borderRadius: BorderRadius.circular(10), border: Border.all(color: VColors.amber.withValues(alpha: .4))),
                          child: Row(children: [
                            const VIcon(VIcons.info, size: 15, color: VColors.amber, stroke: 1.9),
                            const SizedBox(width: 7),
                            Text(t.highAmount, style: VType.body(size: 12.5, weight: FontWeight.w700, color: VColors.amber)),
                          ]),
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _review(context, ref, c, false),
                            style: OutlinedButton.styleFrom(foregroundColor: VColors.bloodText, side: BorderSide(color: VColors.bloodText.withValues(alpha: .55)), minimumSize: const Size(0, 46), padding: const EdgeInsets.symmetric(horizontal: 8)),
                            child: Text(t.staffReject, style: VType.body(size: 14.5, weight: FontWeight.w800, color: VColors.bloodText)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 2,
                          child: FilledButton.icon(
                            onPressed: () => _review(context, ref, c, true),
                            style: FilledButton.styleFrom(backgroundColor: const Color(0xFF86B368), foregroundColor: const Color(0xFF0F1A0A), minimumSize: const Size(0, 46)),
                            icon: const VIcon(VIcons.check, size: 18, color: Color(0xFF0F1A0A), stroke: 2.6),
                            label: Text(t.staffApprove, style: VType.body(size: 14.5, weight: FontWeight.w800, color: const Color(0xFF0F1A0A))),
                          ),
                        ),
                      ]),
                    ]),
                  );
                },
              ),
      ),
    );
  }
}

class _VoucherCheck extends ConsumerStatefulWidget {
  const _VoucherCheck();
  @override
  ConsumerState<_VoucherCheck> createState() => _VoucherCheckState();
}

class _VoucherCheckState extends ConsumerState<_VoucherCheck> {
  final _code = TextEditingController();
  final _focus = FocusNode();
  VoucherLookup? _found;
  bool _busy = false;
  bool _notFound = false;

  @override
  void dispose() {
    _code.dispose();
    _focus.dispose();
    super.dispose();
  }

  Future<void> _lookup() async {
    setState(() {
      _busy = true;
      _notFound = false;
    });
    try {
      final res = await ref.read(shopRepoProvider).lookupVoucher(_code.text);
      setState(() {
        _found = res;
        _notFound = res == null;
      });
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.message, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _confirm() async {
    final t = L10n.of(context);
    setState(() => _busy = true);
    try {
      await ref.read(shopRepoProvider).confirmVoucher(_code.text);
      HapticFeedback.mediumImpact();
      if (mounted) {
        showSnack(context, t.staffVoucherDone);
        setState(() {
          _found = null;
          _code.clear();
        });
      }
    } on ApiError catch (e) {
      if (mounted) showSnack(context, switch (e.code) { ApiErrorCode.voucherExpired => t.voucherExpired, ApiErrorCode.voucherNotActive => t.voucherRedeemed, _ => e.message }, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final levels = ref.watch(levelMapProvider);
    final f = _found;
    final text = _code.text;
    final valid = f != null && f.voucher.effectiveStatus == VoucherStatus.active;

    Widget box(int i) {
      final ch = i < text.length ? text[i] : '';
      final focused = _focus.hasFocus && i == text.length.clamp(0, 5);
      return Container(
        width: 44,
        height: 58,
        decoration: BoxDecoration(
          color: VColors.field,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: focused ? VColors.frostBright : VColors.border, width: focused ? 1.5 : 1),
          boxShadow: focused ? [BoxShadow(color: VColors.frost.withValues(alpha: .2), blurRadius: 10)] : null,
        ),
        child: Center(child: Text(ch, style: VType.body(size: 26, weight: FontWeight.w800, tabular: true))),
      );
    }

    return ListView(padding: const EdgeInsets.fromLTRB(20, 16, 20, 32), children: [
      Text(t.voucherCodeLabel, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.parchment)),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () => _focus.requestFocus(),
        child: Stack(children: [
          Opacity(
            opacity: 0,
            child: TextField(
              controller: _code,
              focusNode: _focus,
              autofocus: true,
              textCapitalization: TextCapitalization.characters,
              autocorrect: false,
              enableSuggestions: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                LengthLimitingTextInputFormatter(6),
                TextInputFormatter.withFunction((_, v) => v.copyWith(text: v.text.toUpperCase())),
              ],
              onChanged: (v) {
                setState(() {
                  _found = null;
                  _notFound = false;
                });
                if (v.length == 6) _lookup();
              },
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            box(0),
            const SizedBox(width: 6),
            box(1),
            const SizedBox(width: 6),
            box(2),
            Container(width: 12, height: 2, margin: const EdgeInsets.symmetric(horizontal: 6), color: VColors.ash2),
            box(3),
            const SizedBox(width: 6),
            box(4),
            const SizedBox(width: 6),
            box(5),
          ]),
        ]),
      ),
      const SizedBox(height: 22),
      if (_busy && f == null) vLoading(),
      if (_notFound)
        VCard(
          borderColor: VColors.bloodText.withValues(alpha: .6),
          child: Row(children: [
            const VIcon(VIcons.close, size: 22, color: VColors.bloodText, stroke: 2),
            const SizedBox(width: 10),
            Expanded(child: Text(t.staffVoucherNotFound, style: VType.body(size: 15, weight: FontWeight.w800, color: VColors.bloodText))),
          ]),
        ),
      if (f != null) ...[
        VCard(
          borderColor: (valid ? VColors.moss : VColors.bloodText).withValues(alpha: .6),
          padding: const EdgeInsets.all(18),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(color: valid ? VColors.moss : VColors.bloodText, shape: BoxShape.circle),
                child: Center(child: VIcon(valid ? VIcons.check : VIcons.close, size: 20, color: const Color(0xFF101A0B), stroke: 2.8)),
              ),
              const SizedBox(width: 10),
              Text(
                valid
                    ? t.voucherValid
                    : switch (f.voucher.effectiveStatus) { VoucherStatus.redeemed => t.voucherRedeemed, VoucherStatus.expired => t.voucherExpired, _ => t.voucherCancelled },
                style: VType.body(size: 17, weight: FontWeight.w800, color: valid ? VColors.moss : VColors.bloodText),
              ),
            ]),
            const SizedBox(height: 12),
            Text(f.reward.name(locale), style: VType.cinzel(size: 21)),
            if (f.reward.description(locale) != null)
              Padding(padding: const EdgeInsets.only(top: 4), child: Text(f.reward.description(locale)!, style: VType.body(size: 13, color: VColors.ash, height: 1.4))),
            const Divider(height: 28),
            Row(children: [
              VPortrait(level: f.user.level, form: f.user.heroForm, size: 38),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('${f.user.nickname} · ${romanLevel(f.user.level)} ${levelName(levels, f.user.level, f.user.heroForm)}', style: VType.body(size: 14.5, weight: FontWeight.w800)),
                  Text(t.validUntil(formatDate(f.voucher.expiresAt, locale: locale)), style: VType.body(size: 12, weight: FontWeight.w600, color: VColors.ash)),
                ]),
              ),
            ]),
          ]),
        ),
        const SizedBox(height: 18),
        VPrimaryButton(label: t.staffVoucherConfirm, icon: VIcons.check, busy: _busy, onPressed: valid ? _confirm : null),
        const SizedBox(height: 10),
        Text(t.voucherUsedHint, textAlign: TextAlign.center, style: VType.body(size: 12.5, color: VColors.ash, height: 1.45)),
      ],
    ]);
  }
}
