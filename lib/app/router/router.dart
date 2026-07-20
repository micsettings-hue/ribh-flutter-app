import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/supabase/supabase_client.dart';
import '../../features/auth/auth_screen.dart';
import '../../features/barakah/barakah_screen.dart';
import '../../features/campaign/campaign_detail_screen.dart';
import '../../features/grow/grow_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/invest/invest_screen.dart';
import '../../features/me/help_screen.dart';
import '../../features/me/me_screen.dart';
import '../../features/me/shariah_board_screen.dart';
import '../../features/services/invite_screen.dart';
import '../../features/services/learn_screen.dart';
import '../../features/services/prayer_screen.dart';
import '../../features/services/qard_screen.dart';
import '../../features/services/sadaqah_screen.dart';
import '../../features/services/service_coming_soon_screen.dart';
import '../../features/services/zakat_screen.dart';
import '../../features/wallet/wallet_screen.dart';
import '../../shared/motion.dart';
import '../../shared/ribh_shell.dart';
import 'routes.dart';

/// Re-evaluates router redirects whenever the auth session changes.
class _AuthRefresh extends ChangeNotifier {
  _AuthRefresh(Stream<dynamic> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    unawaited(_subscription.cancel());
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final configured = RibhSupabase.isConfigured;
  final refresh = configured
      ? _AuthRefresh(Supabase.instance.client.auth.onAuthStateChange)
      : null;
  ref.onDispose(() => refresh?.dispose());

  return GoRouter(
    initialLocation: RibhRoutes.home,
    refreshListenable: refresh,
    redirect: (context, state) {
      // Without backend credentials the shell still opens; every surface
      // shows its real "backend not configured" state instead of data.
      if (!configured) return null;
      final signedIn = Supabase.instance.client.auth.currentSession != null;
      final onAuth = state.matchedLocation == RibhRoutes.auth;
      if (!signedIn) return onAuth ? null : RibhRoutes.auth;
      if (onAuth) return RibhRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: RibhRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RibhRoutes.wallet,
        pageBuilder: (context, state) =>
            ribhPage(key: state.pageKey, child: const WalletScreen()),
      ),
      GoRoute(
        path: RibhRoutes.campaignPattern,
        pageBuilder: (context, state) => ribhPage(
          key: state.pageKey,
          child: CampaignDetailScreen(
            campaignId: state.pathParameters['id']!,
            heroTag: state.extra as String?,
          ),
        ),
      ),
      GoRoute(
        path: RibhRoutes.shariahBoard,
        pageBuilder: (context, state) =>
            ribhPage(key: state.pageKey, child: const ShariahBoardScreen()),
      ),
      GoRoute(
        path: RibhRoutes.help,
        pageBuilder: (context, state) =>
            ribhPage(key: state.pageKey, child: const HelpScreen()),
      ),
      GoRoute(
        path: RibhRoutes.servicePattern,
        pageBuilder: (context, state) => ribhPage(
          key: state.pageKey,
          child: switch (state.pathParameters['id']!) {
            'learn' => const LearnScreen(),
            'zakat' => const ZakatScreen(),
            'sadaqah' => const SadaqahScreen(),
            'qard' => const QardScreen(),
            'invite' => const InviteScreen(),
            'prayer' => const PrayerScreen(),
            final id => ServiceComingSoonScreen(serviceId: id),
          },
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => RibhShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RibhRoutes.home,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RibhRoutes.invest,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: InvestScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RibhRoutes.grow,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: GrowScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RibhRoutes.barakah,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: BarakahScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RibhRoutes.me,
                pageBuilder: (context, state) =>
                    const NoTransitionPage(child: MeScreen()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
