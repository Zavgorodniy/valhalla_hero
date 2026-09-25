import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

class AdminShell extends ConsumerWidget {
  const AdminShell({super.key, required this.location, required this.child});
  final String location;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = L10n.of(context);
    final profile = ref.watch(profileProvider).valueOrNull;
    final isAdmin = profile?.role.isAdmin ?? false;
    final pending = ref.watch(adminStatsProvider).valueOrNull?.pendingClaims ?? 0;
    final entries = <(String, IconData, String)>[
      ('/dashboard', Icons.dashboard_outlined, t.adminDashboard),
      ('/claims', Icons.receipt_long_outlined, t.adminClaims),
      ('/users', Icons.people_outline, t.adminUsers),
      ('/posts', Icons.auto_stories_outlined, t.adminPosts),
      if (isAdmin) ('/rewards', Icons.card_giftcard_outlined, t.adminRewards),
      if (isAdmin) ('/items', Icons.checkroom_outlined, t.adminItems),
      if (isAdmin) ('/venues', Icons.store_outlined, t.adminVenues),
      if (isAdmin) ('/economy', Icons.tune_outlined, t.adminEconomy),
    ];
    final index = entries.indexWhere((e) => e.$1 == location).clamp(0, entries.length - 1);
    final wide = MediaQuery.sizeOf(context).width > 900;

    return Scaffold(
      body: Row(children: [
        NavigationRail(
          extended: wide,
          minExtendedWidth: 210,
          selectedIndex: index,
          onDestinationSelected: (i) => context.go(entries[i].$1),
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(children: [
              const Icon(Icons.shield, color: VColors.gold, size: 32),
              if (wide) const Padding(padding: EdgeInsets.only(top: 6), child: Text('VALHALLA', style: TextStyle(color: VColors.gold, letterSpacing: 3, fontWeight: FontWeight.w700))),
            ]),
          ),
          trailing: Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  if (wide && profile != null) Text('${profile.nickname} · ${profile.role.name}', style: const TextStyle(color: VColors.ash, fontSize: 11)),
                  IconButton(onPressed: () => ref.read(supabaseProvider).auth.signOut(), icon: const Icon(Icons.logout), tooltip: t.signOut),
                ]),
              ),
            ),
          ),
          destinations: [
            for (final e in entries)
              NavigationRailDestination(
                icon: e.$1 == '/claims' ? Badge(isLabelVisible: pending > 0, label: Text('$pending'), child: Icon(e.$2)) : Icon(e.$2),
                label: Text(e.$3),
              ),
          ],
        ),
        const VerticalDivider(width: 1),
        Expanded(child: child),
      ]),
    );
  }
}

/// Standard page frame with title and optional action.
class AdminPage extends StatelessWidget {
  const AdminPage({super.key, required this.title, required this.child, this.actions = const []});
  final String title;
  final Widget child;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 12),
          child: Row(children: [Expanded(child: Text(title, style: Theme.of(context).textTheme.headlineMedium)), ...actions]),
        ),
        Expanded(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 24), child: child)),
      ]);
}

/// Simple labelled text field for edit dialogs.
class Field extends StatelessWidget {
  const Field(this.label, this.controller, {super.key, this.number = false, this.lines = 1});
  final String label;
  final TextEditingController controller;
  final bool number;
  final int lines;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: TextField(
          controller: controller,
          maxLines: lines,
          keyboardType: number ? const TextInputType.numberWithOptions(decimal: true) : null,
          decoration: InputDecoration(labelText: label, isDense: true),
        ),
      );
}

Future<void> runAction(BuildContext context, Future<void> Function() fn, {String? success}) async {
  try {
    await fn();
    if (context.mounted && success != null) showSnack(context, success);
  } on ApiError catch (e) {
    if (context.mounted) showSnack(context, e.message, error: true);
  }
}
