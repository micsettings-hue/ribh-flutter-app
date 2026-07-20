import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';

/// Help and disputes, static informational page. No backend: it explains how
/// to get support and how the dispute process works, and offers a copyable
/// support email. Factual, non-faith copy, so no board sign-off needed.
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  static const supportEmail = 'support@ribh.app';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.meHelp)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(l10n.helpIntro, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 20),
          Text(l10n.helpContactTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Card(
            child: ListTile(
              leading: const Icon(LucideIcons.mail),
              title: Text(supportEmail),
              subtitle: Text(l10n.helpContactBody),
              trailing: IconButton(
                icon: const Icon(LucideIcons.copy, size: 18),
                tooltip: l10n.helpCopyEmail,
                onPressed: () async {
                  await Clipboard.setData(
                    const ClipboardData(text: supportEmail),
                  );
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(l10n.helpEmailCopied)),
                    );
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.helpDisputeTitle, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            l10n.helpDisputeBody,
            style: theme.textTheme.bodyMedium?.copyWith(color: tokens.ink),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.helpDisputeSteps,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        ],
      ),
    );
  }
}
