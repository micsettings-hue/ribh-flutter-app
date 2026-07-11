import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/router/routes.dart';
import '../../app/theme/ribh_tokens.dart';

/// Home becomes the full hub in M5. Since M3 it carries the one real entry
/// that already exists: the Amanah wallet. Everything else stays an honest
/// placeholder, no demo content.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.tabHome)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(LucideIcons.wallet),
              title: Text(l10n.homeWalletEntry),
              subtitle: Text(l10n.homeWalletEntrySubtitle),
              trailing: const Icon(LucideIcons.chevronRight),
              onTap: () => context.push(RibhRoutes.wallet),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            l10n.milestonePlaceholderBody,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        ],
      ),
    );
  }
}
