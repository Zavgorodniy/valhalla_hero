import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../shell/admin_shell.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final stats = ref.watch(adminStatsProvider);
    final board = ref.watch(leaderboardProvider);
    final levels = ref.watch(levelMapProvider);
    return AdminPage(
      title: t.adminDashboard,
      actions: [IconButton(onPressed: () { ref.invalidate(adminStatsProvider); ref.invalidate(leaderboardProvider); }, icon: const Icon(Icons.refresh))],
      child: AsyncView(
        value: stats,
        onRetry: () => ref.invalidate(adminStatsProvider),
        data: (s) => ListView(children: [
          Wrap(spacing: 12, runSpacing: 12, children: [
            _Tile(t.adminStatUsers, formatNumber(s.users, locale: locale), Icons.people),
            _Tile(t.adminStatOnBoard, formatNumber(s.usersOnBoard, locale: locale), Icons.sailing, color: VColors.moss),
            _Tile(t.adminStatVisits30, formatNumber(s.visits30d, locale: locale), Icons.local_bar),
            _Tile(t.adminStatRevenue30, formatEuro(s.revenue30dCents, locale: locale), Icons.euro, color: VColors.gold),
            _Tile(t.adminStatPending, formatNumber(s.pendingClaims, locale: locale), Icons.hourglass_top, color: s.pendingClaims > 0 ? VColors.blood : null),
            _Tile(t.adminStatCoins, formatNumber(s.coinsOutstanding, locale: locale), Icons.toll, color: VColors.gold),
            _Tile(t.adminStatVouchersActive, formatNumber(s.vouchersActive, locale: locale), Icons.confirmation_number),
            _Tile(t.adminStatVouchersRedeemed30, formatNumber(s.vouchersRedeemed30d, locale: locale), Icons.check_circle),
          ]),
          SectionTitle(t.leaderboardTitle),
          AsyncView(
            value: board,
            compact: true,
            data: (list) => Card(
              child: Column(children: [
                for (final p in list.take(10))
                  ListTile(
                    dense: true,
                    leading: SizedBox(width: 28, child: Text('${p.rank}', style: const TextStyle(fontWeight: FontWeight.w700, color: VColors.gold))),
                    title: Text(p.nickname),
                    subtitle: Text('${levels[p.level]?.name ?? ''} · ${t.visitsCount(p.visitCount)}'),
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      if (p.onBoard) const Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.sailing, size: 16, color: VColors.moss)),
                      Text(t.xpLabel(p.xp), style: const TextStyle(fontWeight: FontWeight.w700)),
                    ]),
                  ),
              ]),
            ),
          ),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile(this.label, this.value, this.icon, {this.color});
  final String label;
  final String value;
  final IconData icon;
  final Color? color;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(icon, color: color ?? VColors.ash, size: 20),
              const SizedBox(height: 10),
              Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: color ?? VColors.bone)),
              Text(label, style: const TextStyle(color: VColors.ash, fontSize: 12)),
            ]),
          ),
        ),
      );
}
