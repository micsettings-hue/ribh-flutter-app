import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/l10n/app_localizations.dart';

/// Five-tab shell. Tab state persists via the indexed stack; re-selecting
/// the active tab pops that branch to its root.
class RibhShell extends StatelessWidget {
  const RibhShell({super.key, required this.shell});

  final StatefulNavigationShell shell;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (index) =>
            shell.goBranch(index, initialLocation: index == shell.currentIndex),
        destinations: [
          NavigationDestination(
            icon: const Icon(LucideIcons.house),
            label: l10n.tabHome,
          ),
          NavigationDestination(
            icon: const Icon(LucideIcons.trendingUp),
            label: l10n.tabInvest,
          ),
          NavigationDestination(
            icon: const Icon(LucideIcons.sprout),
            label: l10n.tabGrow,
          ),
          NavigationDestination(
            icon: const Icon(LucideIcons.moon),
            label: l10n.tabBarakah,
          ),
          NavigationDestination(
            icon: const Icon(LucideIcons.user),
            label: l10n.tabMe,
          ),
        ],
      ),
    );
  }
}
