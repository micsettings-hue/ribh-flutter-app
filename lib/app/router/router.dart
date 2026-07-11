import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/barakah/barakah_screen.dart';
import '../../features/grow/grow_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/invest/invest_screen.dart';
import '../../features/me/me_screen.dart';
import '../../shared/ribh_shell.dart';
import 'routes.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RibhRoutes.home,
    routes: [
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
