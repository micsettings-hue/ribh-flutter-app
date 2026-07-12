import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../shared/failure_l10n.dart';
import 'services_controllers.dart';

/// Qard e Hasanah: education plus a real notify-me that records interest.
/// Honestly labelled coming soon; no lending exists in v1 and repayment
/// will be at par when it does.
class QardScreen extends ConsumerWidget {
  const QardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final qard = ref.watch(qardControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceQard)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: tokens.amberSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(LucideIcons.clock, size: 16, color: tokens.amber),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    l10n.qardComingSoon,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.amber,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(l10n.qardBody, style: theme.textTheme.bodyMedium),
          const SizedBox(height: 20),
          qard.when(
            skipLoadingOnRefresh: false,
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Row(
              children: [
                Expanded(
                  child: Text(
                    failureText(
                      l10n,
                      error is Failure ? error : UnknownFailure('$error'),
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.inkSoft,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => ref.invalidate(qardControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
            data: (registered) => registered
                ? Row(
                    children: [
                      Icon(
                        LucideIcons.circleCheck,
                        size: 18,
                        color: tokens.teal,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n.qardRegistered,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  )
                : FilledButton.icon(
                    icon: const Icon(LucideIcons.bell, size: 18),
                    label: Text(l10n.qardNotify),
                    onPressed: () => ref
                        .read(qardControllerProvider.notifier)
                        .registerInterest(),
                  ),
          ),
        ],
      ),
    );
  }
}
