import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import 'features/claims_screen.dart';
import 'features/dashboard_screen.dart';
import 'features/economy_screen.dart';
import 'features/items_screen.dart';
import 'features/login_screen.dart';
import 'features/posts_screen.dart';
import 'features/rewards_screen.dart';
import 'features/users_screen.dart';
import 'features/venues_screen.dart';
import 'shell/admin_shell.dart';

class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    ref.listen(authStateProvider, (_, _) => notifyListeners());
    ref.listen(profileProvider, (_, _) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);
  return GoRouter(
    initialLocation: '/dashboard',
    refreshListenable: refresh,
    redirect: (context, state) {
      final user = ref.read(currentUserProvider);
      final profile = ref.read(profileProvider);
      final loc = state.matchedLocation;
      if (user == null) return loc == '/login' ? null : '/login';
      if (!profile.hasValue) return loc == '/splash' ? null : '/splash';
      final p = profile.valueOrNull;
      if (p == null || !p.role.isManager) return loc == '/forbidden' ? null : '/forbidden';
      if (loc == '/login' || loc == '/splash' || loc == '/forbidden') return '/dashboard';
      return null;
    },
    routes: [
      GoRoute(path: '/login', pageBuilder: (_, _) => const NoTransitionPage(child: LoginScreen())),
      GoRoute(path: '/splash', builder: (_, _) => const Scaffold(body: Center(child: CircularProgressIndicator()))),
      GoRoute(path: '/forbidden', pageBuilder: (_, _) => const NoTransitionPage(child: _Forbidden())),
      ShellRoute(
        builder: (context, state, child) => AdminShell(location: state.matchedLocation, child: child),
        routes: [
          GoRoute(path: '/dashboard', pageBuilder: (_, _) => const NoTransitionPage(child: DashboardScreen())),
          GoRoute(path: '/claims', pageBuilder: (_, _) => const NoTransitionPage(child: ClaimsScreen())),
          GoRoute(path: '/users', pageBuilder: (_, _) => const NoTransitionPage(child: UsersScreen())),
          GoRoute(path: '/rewards', pageBuilder: (_, _) => const NoTransitionPage(child: RewardsScreen())),
          GoRoute(path: '/items', pageBuilder: (_, _) => const NoTransitionPage(child: ItemsScreen())),
          GoRoute(path: '/posts', pageBuilder: (_, _) => const NoTransitionPage(child: PostsScreen())),
          GoRoute(path: '/venues', pageBuilder: (_, _) => const NoTransitionPage(child: VenuesScreen())),
          GoRoute(path: '/economy', pageBuilder: (_, _) => const NoTransitionPage(child: EconomyScreen())),
        ],
      ),
    ],
  );
});

class _Forbidden extends ConsumerWidget {
  const _Forbidden();
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            const Icon(Icons.lock_outline, color: VColors.blood, size: 40),
            const SizedBox(height: 12),
            Text(L10n.of(context).adminNotAllowed),
            const SizedBox(height: 12),
            TextButton(onPressed: () => ref.read(supabaseProvider).auth.signOut(), child: Text(L10n.of(context).signOut)),
          ]),
        ),
      );
}
