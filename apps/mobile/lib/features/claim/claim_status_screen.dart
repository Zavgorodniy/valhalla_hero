import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// After "Besuch melden": shows the code for the bartender, waits for the
/// review, then reveals what was credited and hands over to the level-up.
class ClaimStatusScreen extends ConsumerStatefulWidget {
  const ClaimStatusScreen({super.key, required this.claimId});
  final String claimId;
  @override
  ConsumerState<ClaimStatusScreen> createState() => _ClaimStatusScreenState();
}

class _ClaimStatusScreenState extends ConsumerState<ClaimStatusScreen> {
  Timer? _poll;
  Profile? _before;
  bool _credited = false;

  @override
  void initState() {
    super.initState();
    _before = ref.read(profileProvider).valueOrNull;
    _poll = Timer.periodic(const Duration(seconds: 4), (_) => ref.invalidate(myClaimsProvider));
  }

  @override
  void dispose() {
    _poll?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final claims = ref.watch(myClaimsProvider);
    final claim = claims.valueOrNull?.where((c) => c.id == widget.claimId).firstOrNull;

    if (claim != null && claim.status != ClaimStatus.pending) {
      _poll?.cancel();
      if (claim.status == ClaimStatus.approved && !_credited) {
        _credited = true;
        HapticFeedback.heavyImpact();
        WidgetsBinding.instance.addPostFrameCallback((_) => invalidateUserData(ref));
      }
    }

    return VScreen(
      glow: VColors.gold,
      child: Stack(children: [
        const Positioned.fill(child: VEmbers(opacity: .5)),
        SafeArea(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: switch (claim?.status) {
              null => vLoading(),
              ClaimStatus.pending => _Pending(key: const ValueKey('p'), claim: claim!),
              ClaimStatus.rejected => _Rejected(key: const ValueKey('r'), claim: claim!),
              ClaimStatus.approved => CreditReveal(key: const ValueKey('a'), before: _before, since: claim!.createdAt),
            },
          ),
        ),
      ]),
    );
  }
}

class _Pending extends StatelessWidget {
  const _Pending({super.key, required this.claim});
  final VisitClaim claim;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final time = TimeOfDay.fromDateTime(claim.createdAt.toLocal()).format(context);
    return Column(children: [
      VTopBar(actions: [VRoundButton(icon: VIcons.close, tooltip: t.close, background: VColors.surface2, onTap: () => context.go('/hero'))]),
      Expanded(
        child: ListView(padding: const EdgeInsets.symmetric(horizontal: 20), children: [
          const Center(child: _Seal()),
          const SizedBox(height: 6),
          Text(t.claimSentTitle, textAlign: TextAlign.center, style: VType.cinzel(size: 28)),
          const SizedBox(height: 8),
          Text(t.claimSentBody, textAlign: TextAlign.center, style: VType.body(size: 15, color: VColors.ash, height: 1.5)),
          const SizedBox(height: 22),
          Center(
            child: Container(
              width: 210,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF15100D),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: VColors.ornament.withValues(alpha: .6)),
                boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .08), blurRadius: 24)],
              ),
              child: Column(children: [
                VEyebrow(t.yourVisitCode, size: 11),
                const SizedBox(height: 10),
                Semantics(
                  label: claimCode(claim.id).split('').join(' '),
                  child: Text(claimCode(claim.id), style: VType.body(size: 46, weight: FontWeight.w800, spacing: 6, tabular: true, height: 1)),
                ),
              ]),
            ),
          ),
          const SizedBox(height: 22),
          VCard(
            padding: const EdgeInsets.all(18),
            child: Column(children: [
              _Step(state: _S.done, title: t.stepReported, sub: '$time · ${formatEuro(claim.amountCents)}'),
              const _StepLine(),
              _Step(state: _S.now, title: t.stepChecking, sub: t.stepCheckingSub),
              const _StepLine(),
              _Step(state: _S.next, title: t.stepCredited, sub: t.stepCreditedSub),
            ]),
          ),
          const SizedBox(height: 18),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const VIcon(VIcons.horn, size: 16, color: VColors.ash, stroke: 1.8),
            const SizedBox(width: 8),
            Text(t.hornWillCall, style: VType.body(size: 13, weight: FontWeight.w600, color: VColors.ash)),
          ]),
          VGhostButton(label: t.toHall, onPressed: () => context.go('/hero')),
          const SizedBox(height: 16),
        ]),
      ),
    ]);
  }
}

class _Seal extends StatelessWidget {
  const _Seal();
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 190,
        height: 190,
        child: Stack(alignment: Alignment.center, children: [
          Container(decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: VColors.gold.withValues(alpha: .35)))),
          Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: VColors.gold.withValues(alpha: .45), width: 1.5)),
          ),
          Container(
            width: 124,
            height: 124,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: VColors.goldGradient,
              border: Border.all(color: const Color(0xFF6B4514), width: 3),
              boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .4), blurRadius: 40)],
            ),
            child: const Center(child: VIcon(VIcons.seal, size: 52, color: Color(0xFF3A2308), stroke: 1.8)),
          ),
        ]),
      );
}

enum _S { done, now, next }

class _Step extends StatelessWidget {
  const _Step({required this.state, required this.title, required this.sub});
  final _S state;
  final String title;
  final String sub;
  @override
  Widget build(BuildContext context) {
    final node = switch (state) {
      _S.done => Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(color: VColors.moss, shape: BoxShape.circle),
          child: const Center(child: VIcon(VIcons.check, size: 16, color: Color(0xFF101A0B), stroke: 2.6)),
        ),
      _S.now => Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: VColors.gold, width: 2),
            boxShadow: [BoxShadow(color: VColors.gold.withValues(alpha: .5), blurRadius: 16)],
          ),
          child: Center(child: Container(width: 10, height: 10, decoration: const BoxDecoration(color: VColors.goldBright, shape: BoxShape.circle))),
        ),
      _S.next => Container(width: 28, height: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF4A3E34), width: 1.5))),
    };
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      node,
      const SizedBox(width: 14),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 3),
          Text(title, style: VType.body(size: 15, weight: FontWeight.w800, color: state == _S.next ? VColors.ash : VColors.bone)),
          Text(sub, style: VType.body(size: 13, weight: FontWeight.w600, color: VColors.ash)),
        ]),
      ),
    ]);
  }
}

class _StepLine extends StatelessWidget {
  const _StepLine();
  @override
  Widget build(BuildContext context) => Align(alignment: Alignment.centerLeft, child: Container(width: 2, height: 18, margin: const EdgeInsets.only(left: 13), color: VColors.border));
}

class _Rejected extends StatelessWidget {
  const _Rejected({super.key, required this.claim});
  final VisitClaim claim;
  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    return Column(children: [
      VTopBar(actions: [VRoundButton(icon: VIcons.close, tooltip: t.close, background: VColors.surface2, onTap: () => context.go('/hero'))]),
      const Spacer(),
      Container(
        width: 96,
        height: 96,
        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: VColors.bloodText, width: 2)),
        child: const Center(child: VIcon(VIcons.close, size: 40, color: VColors.bloodText, stroke: 2)),
      ),
      const SizedBox(height: 18),
      Text(t.claimRejectedTitle, style: VType.cinzel(size: 26)),
      const SizedBox(height: 8),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(claim.rejectReason ?? t.claimRejectedBody, textAlign: TextAlign.center, style: VType.body(size: 15, color: VColors.ash, height: 1.5)),
      ),
      const Spacer(),
      Padding(padding: const EdgeInsets.all(20), child: VSecondaryButton(label: t.toHall, onPressed: () => context.go('/hero'))),
    ]);
  }
}

/// Snapshot taken before a credit, so the reveal can show what changed.
/// The last redeemed receipt, handed from the scanner to [CreditRevealScreen].
final lastReceiptProvider = StateProvider<ReceiptResult?>((ref) => null);

/// Full-screen reward reveal after a scanned receipt.
class CreditRevealScreen extends ConsumerWidget {
  const CreditRevealScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => VScreen(
        glow: VColors.gold,
        child: Stack(children: [
          const Positioned.fill(child: VEmbers(opacity: .5)),
          SafeArea(child: CreditReveal(result: ref.watch(lastReceiptProvider))),
        ]),
      );
}

class CreditReveal extends ConsumerWidget {
  const CreditReveal({super.key, this.result, this.before, this.since});

  /// Receipt path: gains as computed by the server.
  final ReceiptResult? result;

  /// Claim path: profile before the claim and when it was made.
  final Profile? before;
  final DateTime? since;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final now = ref.watch(profileProvider).valueOrNull;
    final levels = ref.watch(levelMapProvider);
    final achievements = ref.watch(achievementsProvider).valueOrNull ?? const <Achievement>[];
    final items = ref.watch(itemsProvider).valueOrNull ?? const <Item>[];
    final mine = ref.watch(myAchievementsProvider).valueOrNull ?? const <UserAchievement>[];
    if (now == null) return vLoading();
    final b = before ?? now;
    final r = result;
    final xpGain = r?.xpGained ?? now.xp - b.xp;
    final coinGain = r?.coinsGained ?? now.coinBalance - b.coinBalance;
    final levelBefore = r?.levelBefore ?? b.level;
    final leveledUp = (r?.levelAfter ?? now.level) > levelBefore;
    final newKeys = r?.achievements.toSet() ??
        {for (final a in mine) if (since != null && !a.unlockedAt.isBefore(since!)) a.achievementKey};
    final newAch = achievements.where((a) => newKeys.contains(a.key)).toList();
    final ach = newAch.firstOrNull;
    final achItem = ach == null ? null : items.where((i) => i.unlockAchievementKey == ach.key).firstOrNull;
    final cur = levels[now.level];
    final next = levels[now.level + 1];
    final progress = leveledUp ? 1.0 : next == null ? 1.0 : (now.xp - (cur?.xpThreshold ?? 0)) / (next.xpThreshold - (cur?.xpThreshold ?? 0));

    return Column(children: [
      VTopBar(actions: [VRoundButton(icon: VIcons.close, tooltip: t.close, background: VColors.surface2, onTap: () => context.go('/hero'))]),
      Expanded(
        child: ListView(padding: const EdgeInsets.symmetric(horizontal: 20), children: [
          Center(child: VStatusPill(label: t.visitConfirmed.toUpperCase(), color: VColors.moss, icon: VIcons.check)),
          const SizedBox(height: 10),
          Text(t.hallHonours(now.nickname), textAlign: TextAlign.center, style: VType.cinzel(size: 26)),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(child: _Tile(xp: true, value: '+$xpGain', label: t.experience)),
            const SizedBox(width: 12),
            Expanded(child: _Tile(xp: false, value: '+${vNum(coinGain)}', label: t.coinsWord)),
          ]),
          if (now.currentStreakWeeks >= 2) ...[
            const SizedBox(height: 14),
            VCard(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                for (var i = 0; i < now.currentStreakWeeks.clamp(0, 4); i++)
                  Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const RadialGradient(center: Alignment(0, -.3), colors: [Color(0xFF4A3620), Color(0xFF231910)]),
                        border: Border.all(color: VColors.gold, width: 1.5),
                      ),
                      child: const Center(child: VIcon(VIcons.ship, size: 16, color: VColors.goldBright, stroke: 1.9)),
                    ),
                  ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.streakNow(now.currentStreakWeeks), style: VType.body(size: 15, weight: FontWeight.w800)),
                    Text(t.streakKept, style: VType.body(size: 12.5, weight: FontWeight.w600, color: VColors.ash)),
                  ]),
                ),
              ]),
            ),
          ],
          if (ach != null) ...[
            const SizedBox(height: 14),
            VOrnateCard(
              padding: const EdgeInsets.all(16),
              child: Column(children: [
                Row(children: [
                  VMedal(tier: medalTier(ach), icon: achievementVIcon(ach.icon), size: 60),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      VEyebrow(t.achievementUnlocked, color: VColors.gold, size: 10.5),
                      const SizedBox(height: 4),
                      Text(ach.name(locale), style: VType.cinzel(size: 20)),
                      const SizedBox(height: 4),
                      Row(children: [
                        const VGem(size: 13),
                        Text(' +${ach.xpReward}  ', style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.frostBright)),
                        if (ach.coinReward > 0) ...[
                          const VCoin(size: 13),
                          Text(' +${ach.coinReward}', style: VType.body(size: 12.5, weight: FontWeight.w800, color: VColors.goldBright)),
                        ],
                      ]),
                    ]),
                  ),
                ]),
                if (achItem != null) ...[
                  const Divider(height: 26, color: Color(0x40B98A3E)),
                  Row(children: [
                    VItemArt(assetKey: achItem.assetKey, slot: achItem.slot, size: 36),
                    const SizedBox(width: 10),
                    Expanded(child: Text(achItem.name(locale), style: VType.body(size: 14, weight: FontWeight.w800))),
                    VRarityChip(rarity: achItem.rarity, label: rarityName(t, achItem.rarity), small: true),
                  ]),
                ],
              ]),
            ),
          ],
          const SizedBox(height: 22),
          Row(children: [
            const VGem(size: 15),
            const SizedBox(width: 7),
            Text(t.xpLabel(now.xp), style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.frostBright, tabular: true)),
            const Spacer(),
            if (leveledUp) Text(t.levelReached(romanLevel(now.level)), style: VType.body(size: 13, weight: FontWeight.w800, color: VColors.goldBright)),
          ]),
          const SizedBox(height: 8),
          VXpBar(progress: progress),
          const SizedBox(height: 24),
          VPrimaryButton(label: t.continueLabel, onPressed: () => context.go(leveledUp ? '/levelup?from=$levelBefore' : '/hero')),
          const SizedBox(height: 20),
        ]),
      ),
    ]);
  }
}

class _Tile extends StatelessWidget {
  const _Tile({required this.xp, required this.value, required this.label});
  final bool xp;
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) {
    final c = xp ? VColors.frostBright : VColors.goldBright;
    final g = xp ? VColors.frost : VColors.gold;
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 18, 10, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: RadialGradient(center: const Alignment(0, -1), radius: 1.2, colors: [g.withValues(alpha: .2), const Color(0xE6141A1C)]),
        border: Border.all(color: g.withValues(alpha: .45)),
      ),
      child: Column(children: [
        xp ? const VGem(size: 34) : const VCoin(size: 34),
        const SizedBox(height: 8),
        Text(value, style: VType.cinzel(size: 34, color: c, height: 1)),
        const SizedBox(height: 6),
        Text(label, style: VType.body(size: 13, weight: FontWeight.w800)),
      ]),
    );
  }
}
