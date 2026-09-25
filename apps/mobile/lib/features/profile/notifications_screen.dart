import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import '../../shared/ui.dart';

/// Hornrufe: grouped by today / this week / earlier; each one leads somewhere.
class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});
  @override
  ConsumerState<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  Set<String> _unreadOnOpen = const {};

  @override
  void initState() {
    super.initState();
    _unreadOnOpen = (ref.read(notificationsProvider).valueOrNull ?? const []).where((n) => !n.isRead).map((n) => n.id).toSet();
    Future.microtask(_markRead);
  }

  Future<void> _markRead() async {
    await ref.read(profileRepoProvider).markAllRead();
    ref.invalidate(notificationsProvider);
  }

  static (VIcons, Color, String?) _style(String type) => switch (type) {
        'level_up' => (VIcons.arrowUp, VColors.frostBright, '/hero?seg=1'),
        'achievement' => (VIcons.star, VColors.goldBright, '/hero?seg=2'),
        'visit_credited' => (VIcons.seal, VColors.moss, '/hero'),
        'claim_rejected' => (VIcons.close, VColors.bloodText, '/hero'),
        'coins_expiring' => (VIcons.hourglass, VColors.amber, '/coins'),
        'voucher_redeemed' => (VIcons.ticket, VColors.goldBright, '/shop?seg=2'),
        'event' || 'post' => (VIcons.music, VColors.frostBright, '/events'),
        'checkin_approved' => (VIcons.check, VColors.moss, '/saga'),
        'checkin_rejected' => (VIcons.close, VColors.bloodText, '/saga'),
        _ => (VIcons.horn, VColors.goldBright, null),
      };

  @override
  Widget build(BuildContext context) {
    final t = L10n.of(context);
    final locale = ref.watch(localeCodeProvider);
    final list = ref.watch(notificationsProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final week = weekStart(now);

    return VScreen(
      child: SafeArea(
        child: Column(children: [
          VTopBar(title: t.hornCalls, back: true, actions: [TextButton(onPressed: _markRead, child: Text(t.markAllRead))]),
          Expanded(
            child: list.when(
              skipLoadingOnReload: true,
              loading: vLoading,
              error: (e, _) => Center(child: Text('$e', style: VType.body(size: 12, color: VColors.ash))),
              data: (items) {
                if (items.isEmpty) {
                  return Center(
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      const VIcon(VIcons.horn, size: 44, color: VColors.ash2, stroke: 1.5),
                      const SizedBox(height: 12),
                      Text(t.notificationsEmpty, style: VType.body(size: 14, color: VColors.ash)),
                    ]),
                  );
                }
                final groups = <String, List<AppNotification>>{};
                for (final n in items) {
                  final d = n.createdAt.toLocal();
                  final key = !d.isBefore(today) ? t.today : (!d.isBefore(week) ? t.thisWeek : t.earlier);
                  groups.putIfAbsent(key, () => []).add(n);
                }
                return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 32), children: [
                  for (final g in groups.entries) ...[
                    Padding(padding: const EdgeInsets.fromLTRB(4, 12, 0, 10), child: VEyebrow(g.key, size: 11.5)),
                    for (final n in g.value) _tile(context, n, locale, today),
                  ],
                ]);
              },
            ),
          ),
        ]),
      ),
    );
  }

  Widget _tile(BuildContext context, AppNotification n, String locale, DateTime today) {
    final (icon, color, route) = _style(n.type);
    final unread = _unreadOnOpen.contains(n.id);
    final d = n.createdAt.toLocal();
    final time = d.isBefore(today) ? formatDate(d, locale: locale) : TimeOfDay.fromDateTime(d).format(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: route == null ? null : () => context.push(route),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 14, 14),
          decoration: BoxDecoration(
            gradient: unread ? LinearGradient(colors: [VColors.gold.withValues(alpha: .08), VColors.gold.withValues(alpha: .02)]) : null,
            color: unread ? null : const Color(0xFF161110),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: unread ? VColors.gold.withValues(alpha: .35) : VColors.border),
          ),
          child: Stack(clipBehavior: Clip.none, children: [
            if (unread)
              Positioned(
                left: -14,
                top: 16,
                child: Container(width: 7, height: 7, decoration: BoxDecoration(color: VColors.gold, shape: BoxShape.circle, boxShadow: const [BoxShadow(color: VColors.gold, blurRadius: 6)])),
              ),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(color: const Color(0xFF1E1712), borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withValues(alpha: .33))),
                child: Center(child: VIcon(icon, size: 20, color: color, stroke: 1.8)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(child: Text(n.title(locale), style: VType.body(size: 14.5, weight: FontWeight.w800))),
                    const SizedBox(width: 8),
                    Text(time, style: VType.body(size: 12, weight: FontWeight.w700, color: VColors.ash)),
                  ]),
                  if (n.body(locale) != null) Padding(padding: const EdgeInsets.only(top: 2), child: Text(n.body(locale)!, style: VType.body(size: 13, color: VColors.ash, height: 1.4))),
                ]),
              ),
            ]),
          ]),
        ),
      ),
    );
  }
}
