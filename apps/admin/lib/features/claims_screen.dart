import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class ClaimsScreen extends ConsumerWidget {
  const ClaimsScreen({super.key});

  Future<void> _review(BuildContext context, WidgetRef ref, VisitClaim c, bool approve) async {
    final t = L10n.of(context);
    String? reason;
    if (!approve) {
      final ctrl = TextEditingController();
      final ok = await showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(t.staffReject),
          content: SizedBox(width: 360, child: TextField(controller: ctrl, decoration: InputDecoration(labelText: t.staffRejectReason))),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.staffReject))],
        ),
      );
      if (ok != true) return;
      reason = ctrl.text.trim().isEmpty ? null : ctrl.text.trim();
    }
    if (!context.mounted) return;
    await runAction(context, () async {
      await ref.read(visitRepoProvider).review(c.id, approve: approve, reason: reason);
      ref.invalidate(allClaimsProvider);
      ref.invalidate(adminStatsProvider);
      ref.invalidate(leaderboardProvider);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final claims = ref.watch(allClaimsProvider);
    final venues = {for (final v in ref.watch(venuesProvider).valueOrNull ?? const <Venue>[]) v.id: v};
    return AdminPage(
      title: t.adminClaims,
      actions: [IconButton(onPressed: () => ref.invalidate(allClaimsProvider), icon: const Icon(Icons.refresh))],
      child: AsyncView(
        value: claims,
        onRetry: () => ref.invalidate(allClaimsProvider),
        data: (list) {
          final sorted = [...list]..sort((a, b) => a.status == b.status ? b.createdAt.compareTo(a.createdAt) : (a.status == ClaimStatus.pending ? -1 : 1));
          return SingleChildScrollView(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text(t.nickname)),
                  DataColumn(label: Text(t.claimVenue)),
                  DataColumn(label: Text(t.claimAmount), numeric: true),
                  DataColumn(label: Text(t.claimNote)),
                  const DataColumn(label: Text('')),
                  const DataColumn(label: Text('')),
                ],
                rows: [
                  for (final c in sorted)
                    DataRow(cells: [
                      DataCell(Text(c.profile?.nickname ?? c.userId.substring(0, 8))),
                      DataCell(Text(venues[c.venueId]?.name ?? '')),
                      DataCell(Text(formatEuro(c.amountCents, locale: locale), style: const TextStyle(fontWeight: FontWeight.w700))),
                      DataCell(Text(c.note ?? '', style: const TextStyle(color: VColors.ash))),
                      DataCell(Text(formatDateTime(c.createdAt, locale: locale), style: const TextStyle(color: VColors.ash, fontSize: 12))),
                      DataCell(c.status == ClaimStatus.pending
                          ? Row(mainAxisSize: MainAxisSize.min, children: [
                              IconButton(tooltip: t.staffReject, onPressed: () => _review(context, ref, c, false), icon: const Icon(Icons.close, color: VColors.blood)),
                              IconButton.filled(tooltip: t.staffApprove, onPressed: () => _review(context, ref, c, true), icon: const Icon(Icons.check)),
                            ])
                          : Text(
                              c.status == ClaimStatus.approved ? t.claimStatusApproved : '${t.claimStatusRejected}${c.rejectReason != null ? ' · ${c.rejectReason}' : ''}',
                              style: TextStyle(color: c.status == ClaimStatus.approved ? VColors.moss : VColors.blood, fontSize: 12),
                            )),
                    ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
