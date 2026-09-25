import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class UsersScreen extends ConsumerStatefulWidget {
  const UsersScreen({super.key});
  @override
  ConsumerState<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends ConsumerState<UsersScreen> {
  String _search = '';

  Future<void> _credit(Profile p) async {
    final t = L10n.of(context);
    final venues = await ref.read(activeVenuesProvider.future);
    if (venues.isEmpty || !mounted) return;
    String venueId = venues.first.id;
    final amount = TextEditingController();
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setS) => AlertDialog(
          title: Text('${t.staffCredit}: ${p.nickname}'),
          content: SizedBox(
            width: 360,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              DropdownButtonFormField<String>(
                initialValue: venueId,
                items: [for (final v in venues) DropdownMenuItem(value: v.id, child: Text(v.name))],
                onChanged: (v) => setS(() => venueId = v!),
                decoration: InputDecoration(labelText: t.claimVenue),
              ),
              const SizedBox(height: 10),
              Field(t.claimAmount, amount, number: true),
            ]),
          ),
          actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(t.cancel)), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: Text(t.confirm))],
        ),
      ),
    );
    final cents = parseEuroToCents(amount.text);
    if (ok != true || cents == null || !mounted) return;
    await runAction(context, () async {
      await ref.read(visitRepoProvider).adminCreditVisit(userId: p.id, venueId: venueId, amountCents: cents);
      ref.invalidate(adminProfilesProvider);
      ref.invalidate(adminStatsProvider);
      ref.invalidate(leaderboardProvider);
    }, success: t.adminSaved);
  }

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final me = ref.watch(profileProvider).valueOrNull;
    final users = ref.watch(adminProfilesProvider(_search));
    final levels = ref.watch(levelMapProvider);
    return AdminPage(
      title: t.adminUsers,
      actions: [
        SizedBox(
          width: 260,
          child: TextField(
            decoration: InputDecoration(labelText: t.adminSearch, isDense: true, prefixIcon: const Icon(Icons.search)),
            onChanged: (v) => setState(() => _search = v),
          ),
        ),
      ],
      child: AsyncView(
        value: users,
        onRetry: () => ref.invalidate(adminProfilesProvider),
        data: (list) => SingleChildScrollView(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text(t.nickname)),
                DataColumn(label: Text(t.adminRole)),
                const DataColumn(label: Text('Lvl'), numeric: true),
                const DataColumn(label: Text('XP'), numeric: true),
                DataColumn(label: Text(t.tabShop), numeric: true),
                DataColumn(label: Text(t.visitsCount(0).replaceFirst('0 ', '')), numeric: true),
                const DataColumn(label: Text('')),
                const DataColumn(label: Text('')),
              ],
              rows: [
                for (final p in list)
                  DataRow(cells: [
                    DataCell(Text(p.nickname, style: const TextStyle(fontWeight: FontWeight.w600))),
                    DataCell(me?.role.isAdmin == true && p.id != me!.id
                        ? DropdownButton<UserRole>(
                            value: p.role,
                            underline: const SizedBox.shrink(),
                            items: [for (final r in UserRole.values) DropdownMenuItem(value: r, child: Text(r.name))],
                            onChanged: (r) => runAction(context, () async {
                              await ref.read(adminRepoProvider).setRole(p.id, r!);
                              ref.invalidate(adminProfilesProvider);
                            }, success: t.adminSaved),
                          )
                        : Text(p.role.name)),
                    DataCell(Text('${p.level} ${levels[p.level]?.name ?? ''}')),
                    DataCell(Text(formatNumber(p.xp, locale: locale))),
                    DataCell(Text(formatNumber(p.coinBalance, locale: locale), style: const TextStyle(color: VColors.gold))),
                    DataCell(Text('${p.visitCount}')),
                    DataCell(Text(p.lastVisitAt == null ? '—' : formatDate(p.lastVisitAt!, locale: locale), style: const TextStyle(color: VColors.ash, fontSize: 12))),
                    DataCell(TextButton.icon(onPressed: () => _credit(p), icon: const Icon(Icons.add, size: 16), label: Text(t.staffCredit))),
                  ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
