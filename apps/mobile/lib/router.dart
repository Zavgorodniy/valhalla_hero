import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:valhalla_core/valhalla_core.dart';

import 'features/auth/email_login_screen.dart';
import 'features/auth/onboarding_flow.dart';
import 'features/auth/welcome_screen.dart';
import 'features/claim/claim_status_screen.dart';
import 'features/events/events_screen.dart';
import 'features/hero/path_screen.dart';
import 'features/saga/checkin_composer.dart';
import 'features/saga/saga_screen.dart';
import 'features/scan/scan_screen.dart';
import 'features/feed/post_screen.dart';
import 'features/hero/hero_screen.dart';
import 'features/hero/level_up_screen.dart';
import 'features/leaderboard/player_screen.dart';
import 'features/profile/notifications_screen.dart';
import 'features/profile/settings_screen.dart';
import 'features/shop/coin_purse_screen.dart';
import 'features/shop/shop_screen.dart';
import 'features/shop/voucher_screen.dart';
import 'features/splash_screen.dart';
import 'features/staff/staff_screen.dart';
import 'shell/app_shell.dart';

/// Notifies GoRouter when auth or profile state changes.
class _RouterRefresh extends ChangeNotifier {
  _RouterRefresh(Ref ref) {
    ref.listen(authStateProvider, (_, _) => notifyListeners());
    ref.listen(profileProvider, (_, _) => notifyListeners());
  }
}

Page<void> _fade(Widget child, GoRouterState s) => CustomTransitionPage(
      key: s.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 280),
      transitionsBuilder: (_, a, _, c) => FadeTransition(opacity: CurvedAnimation(parent: a, curve: Curves.easeOut), child: c),
    );

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh(ref);
  ref.onDispose(refresh.dispose);
  final rootKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootKey,
    initialLocation: '/hero',
    refreshListenable: refresh,
    redirect: (context, state) {
      final user = ref.read(currentUserProvider);
      final profile = ref.read(profileProvider);
      final loc = state.matchedLocation;
      final isAuthRoute = loc == '/welcome' || loc == '/login' || loc == '/signup';

      if (user == null) return isAuthRoute ? null : '/welcome';
      if (profile.isLoading && !profile.hasValue) return loc == '/splash' ? null : '/splash';
      if (profile.hasError) return loc == '/splash' ? null : '/splash';
      if (profile.valueOrNull == null) return loc == '/onboarding' ? null : '/onboarding';
      if (isAuthRoute || loc == '/splash' || loc == '/onboarding' || loc == '/home') return '/hero';
      if (loc == '/team' && !(profile.valueOrNull!.role.isStaff)) return '/hero';
      return null;
    },
    routes: [
      GoRoute(path: '/splash', pageBuilder: (_, s) => _fade(const SplashScreen(), s)),
      GoRoute(path: '/welcome', pageBuilder: (_, s) => _fade(const WelcomeScreen(), s)),
      GoRoute(path: '/login', builder: (_, _) => const EmailLoginScreen()),
      GoRoute(path: '/signup', builder: (_, _) => const OnboardingFlow(mode: OnboardingMode.emailSignup)),
      GoRoute(path: '/onboarding', builder: (_, _) => const OnboardingFlow(mode: OnboardingMode.completeProfile)),
      GoRoute(path: '/claim/:id', parentNavigatorKey: rootKey, pageBuilder: (_, s) => _fade(ClaimStatusScreen(claimId: s.pathParameters['id']!), s)),
      GoRoute(
        path: '/levelup',
        parentNavigatorKey: rootKey,
        pageBuilder: (_, s) => _fade(LevelUpScreen(from: int.tryParse(s.uri.queryParameters['from'] ?? '')), s),
      ),
      GoRoute(path: '/voucher/:id', parentNavigatorKey: rootKey, builder: (_, s) => VoucherScreen(voucherId: s.pathParameters['id']!)),
      GoRoute(path: '/coins', parentNavigatorKey: rootKey, builder: (_, _) => const CoinPurseScreen()),
      GoRoute(path: '/player/:id', parentNavigatorKey: rootKey, builder: (_, s) => PlayerScreen(playerId: s.pathParameters['id']!)),
      GoRoute(path: '/post/:id', parentNavigatorKey: rootKey, builder: (_, s) => PostScreen(postId: s.pathParameters['id']!)),
      GoRoute(path: '/notifications', parentNavigatorKey: rootKey, builder: (_, _) => const NotificationsScreen()),
      GoRoute(path: '/settings', parentNavigatorKey: rootKey, builder: (_, _) => const SettingsScreen()),
      GoRoute(path: '/team', parentNavigatorKey: rootKey, builder: (_, _) => const StaffScreen()),
      GoRoute(path: '/home', redirect: (_, _) => '/hero'),
      GoRoute(path: '/scan', parentNavigatorKey: rootKey, pageBuilder: (_, s) => _fade(const ScanScreen(), s)),
      GoRoute(path: '/credited', parentNavigatorKey: rootKey, pageBuilder: (_, s) => _fade(const CreditRevealScreen(), s)),
      GoRoute(path: '/path', parentNavigatorKey: rootKey, builder: (_, _) => const PathScreen()),
      GoRoute(path: '/checkin/new', parentNavigatorKey: rootKey, builder: (_, _) => const CheckinComposer()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(routes: [
            GoRoute(path: '/hero', builder: (_, s) => HeroScreen(initialSegment: int.tryParse(s.uri.queryParameters['seg'] ?? '') ?? 0)),
          ]),
          StatefulShellBranch(routes: [GoRoute(path: '/events', builder: (_, _) => const EventsScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/saga', builder: (_, _) => const SagaScreen())]),
          StatefulShellBranch(routes: [
            GoRoute(path: '/shop', builder: (_, s) => ShopScreen(initialSegment: int.tryParse(s.uri.queryParameters['seg'] ?? '') ?? 0)),
          ]),
        ],
      ),
    ],
  );
});
