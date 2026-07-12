import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';

/// Honest holding page for service routes whose real pages arrive in M7
/// (Learn, Zakat, Sadaqah, Prayer, Qard, Invite). States plainly that the
/// service is not live; never fakes content. The routes are real so M7
/// replaces bodies, not navigation.
class ServiceComingSoonScreen extends StatelessWidget {
  const ServiceComingSoonScreen({super.key, required this.serviceId});

  final String serviceId;

  String _title(AppLocalizations l10n) => switch (serviceId) {
    'learn' => l10n.serviceLearn,
    'zakat' => l10n.serviceZakat,
    'sadaqah' => l10n.serviceSadaqah,
    'prayer' => l10n.servicePrayer,
    'qard' => l10n.serviceQard,
    'invite' => l10n.serviceInvite,
    _ => serviceId,
  };

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    return Scaffold(
      appBar: AppBar(title: Text(_title(l10n))),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(LucideIcons.hammer, size: 40, color: tokens.inkSoft),
              const SizedBox(height: 16),
              Text(
                l10n.serviceComingSoonBody(_title(l10n)),
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
