import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// Opens the "Besuch melden" sheet; on success the claim status screen follows.
Future<void> openClaimSheet(BuildContext context) async {
  final router = GoRouter.of(context);
  final id = await showVSheet<String>(context, builder: (_) => const ClaimSheet());
  if (id != null) router.push('/claim/$id');
}

class ClaimSheet extends ConsumerStatefulWidget {
  const ClaimSheet({super.key});
  @override
  ConsumerState<ClaimSheet> createState() => _ClaimSheetState();
}

class _ClaimSheetState extends ConsumerState<ClaimSheet> {
  final _amount = TextEditingController();
  final _note = TextEditingController();
  String? _venueId;
  bool _busy = false;

  @override
  void dispose() {
    _amount.dispose();
    _note.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final t = L10n.of(context);
    final cents = parseEuroToCents(_amount.text);
    if (cents == null || _venueId == null) return;
    setState(() => _busy = true);
    try {
      final claim = await ref.read(visitRepoProvider).submitClaim(
            venueId: _venueId!,
            amountCents: cents,
            note: _note.text.trim().isEmpty ? null : _note.text.trim(),
          );
      ref.invalidate(myClaimsProvider);
      if (mounted) Navigator.of(context).pop(claim.id);
    } on ApiError catch (e) {
      if (mounted) showSnack(context, e.code == ApiErrorCode.tooManyPending ? t.claimTooManyPending : e.message, error: true);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _pickVenue(List<Venue> venues) async {
    final picked = await showVSheet<String>(
      context,
      builder: (ctx) => ListView(shrinkWrap: true, padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), children: [
        for (final v in venues)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: VCard(
              onTap: () => Navigator.pop(ctx, v.id),
              borderColor: v.id == _venueId ? VColors.gold : null,
              child: Row(children: [
                const VIcon(VIcons.pin, size: 20, color: VColors.goldBright),
                const SizedBox(width: 12),
                Expanded(child: Text('${v.name} · ${v.city ?? ''}', style: VType.body(size: 15, weight: FontWeight.w700))),
              ]),
            ),
          ),
      ]),
    );
    if (picked != null) setState(() => _venueId = picked);
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final venues = ref.watch(activeVenuesProvider).valueOrNull ?? const <Venue>[];
    final profile = ref.watch(profileProvider).valueOrNull;
    final economy = ref.watch(economyProvider).valueOrNull;
    final levels = ref.watch(levelMapProvider);
    _venueId ??= venues.isNotEmpty ? venues.first.id : null;
    final venue = venues.where((v) => v.id == _venueId).firstOrNull;
    final cents = parseEuroToCents(_amount.text);

    // Preview of what the server will credit (XP fixed per visit).
    var bonus = 0;
    if (profile?.lastVisitAt != null && economy != null) {
      final gap = weekStart(DateTime.now()).difference(weekStart(profile!.lastVisitAt!)).inDays;
      if (gap == 7) bonus = economy.streakBonusXp * math.min(profile.currentStreakWeeks + 1, 4);
    }
    final mult = levels[profile?.level ?? 1]?.coinMultiplier ?? 1;
    final coins = cents == null || economy == null ? null : (economy.coinsPerEuro * cents / 100 * mult).floor();

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 16 + MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(child: Text(t.claimVisitTitle, style: VType.cinzel(size: 23))),
            VRoundButton(icon: VIcons.close, tooltip: t.close, background: VColors.surface2, onTap: () => Navigator.of(context).pop()),
          ]),
          Text(t.claimSheetSub, style: VType.body(size: 14, color: VColors.ash)),
          const SizedBox(height: 20),
          _label(t.claimWhere),
          VCard(
            onTap: venues.length > 1 ? () => _pickVenue(venues) : null,
            color: VColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: VColors.gold.withValues(alpha: .1), borderRadius: BorderRadius.circular(12), border: Border.all(color: VColors.gold.withValues(alpha: .35))),
                child: const Center(child: VIcon(VIcons.pin, size: 20, color: VColors.goldBright, stroke: 1.9)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(venue?.name ?? '…', style: VType.body(size: 16, weight: FontWeight.w800)),
                  if (venue != null) Text([venue.address, venue.city].whereType<String>().join(' · '), style: VType.body(size: 13, weight: FontWeight.w600, color: VColors.ash)),
                ]),
              ),
              if (venues.length > 1) Text(t.change, style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.gold)),
            ]),
          ),
          const SizedBox(height: 20),
          _label(t.claimAmountLabel),
          TextField(
            controller: _amount,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))],
            onChanged: (_) => setState(() {}),
            style: VType.body(size: 34, weight: FontWeight.w800, tabular: true),
            decoration: InputDecoration(
              hintText: '0,00',
              suffixText: '€',
              suffixStyle: VType.body(size: 26, weight: FontWeight.w700, color: VColors.ash),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: VColors.gold.withValues(alpha: .5))),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide(color: VColors.gold.withValues(alpha: .85), width: 1.5)),
            ),
          ),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.only(top: 1), child: VIcon(VIcons.info, size: 16, color: VColors.ash, stroke: 1.8)),
            const SizedBox(width: 8),
            Expanded(child: Text(t.claimAmountHint, style: VType.body(size: 12.5, color: VColors.ash, height: 1.45))),
          ]),
          const SizedBox(height: 18),
          _label(t.claimNoteLabel),
          TextField(controller: _note, maxLength: 120, style: VType.body(size: 15), decoration: InputDecoration(hintText: t.claimNoteHint, counterText: '')),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(color: VColors.frost.withValues(alpha: .06), borderRadius: BorderRadius.circular(14), border: Border.all(color: VColors.frost.withValues(alpha: .25))),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(t.claimPreview, style: VType.body(size: 12, weight: FontWeight.w700, color: VColors.ash)),
              const SizedBox(height: 8),
              Row(children: [
                const VGem(size: 16),
                const SizedBox(width: 6),
                Text('+${economy?.xpPerVisit ?? 50} XP', style: VType.body(size: 14, weight: FontWeight.w800, color: VColors.frostBright)),
                if (bonus > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(color: VColors.gold.withValues(alpha: .1), borderRadius: BorderRadius.circular(99)),
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      const VIcon(VIcons.ship, size: 14, color: VColors.goldBright, stroke: 1.9),
                      const SizedBox(width: 4),
                      Text(t.streakBonus(bonus), style: VType.body(size: 12, weight: FontWeight.w800, color: VColors.goldBright)),
                    ]),
                  ),
                ],
                const Spacer(),
                const VCoin(size: 16),
                const SizedBox(width: 6),
                Text(coins == null ? '—' : '≈ ${vNum(coins)}', style: VType.body(size: 14, weight: FontWeight.w800, color: VColors.goldBright, tabular: true)),
              ]),
            ]),
          ),
          const SizedBox(height: 18),
          VPrimaryButton(label: t.claimVisit, icon: VIcons.seal, busy: _busy, onPressed: cents == null || _venueId == null ? null : _submit),
        ]),
      ),
    );
  }

  Widget _label(String text) => Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(text, style: VType.body(size: 13, weight: FontWeight.w700, color: VColors.parchment)));
}
