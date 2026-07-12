import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/referral_points.dart';
import '../../core/failures/failure.dart';
import '../../shared/failure_l10n.dart';
import 'services_controllers.dart';

/// Invite: the real referral link, points from sign-up and verification
/// only, and points-to-trees redemption through the server-side conversion.
/// Rewards are trees, never cash (Riba guardrail).
class InviteScreen extends ConsumerWidget {
  const InviteScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final invite = ref.watch(inviteControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceInvite)),
      body: invite.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  failureText(
                    l10n,
                    error is Failure ? error : UnknownFailure('$error'),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.invalidate(inviteControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => _InviteBody(data: data),
      ),
    );
  }
}

class _InviteBody extends ConsumerStatefulWidget {
  const _InviteBody({required this.data});

  final InviteData data;

  @override
  ConsumerState<_InviteBody> createState() => _InviteBodyState();
}

class _InviteBodyState extends ConsumerState<_InviteBody> {
  String? _redeemError;
  bool _redeeming = false;
  bool _copied = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final data = widget.data;
    final points = referralPoints(joined: data.joined, verified: data.verified);
    final redeemable = redeemableTrees(
      points: points,
      alreadyRedeemed: data.redeemedTrees,
    );

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.inviteYourLink, style: theme.textTheme.titleMedium),
                const SizedBox(height: 6),
                SelectableText(
                  data.link,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: tokens.tealDeep,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        icon: const Icon(LucideIcons.copy, size: 16),
                        label: Text(
                          _copied ? l10n.inviteCopied : l10n.inviteCopy,
                        ),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: data.link),
                          );
                          if (mounted) setState(() => _copied = true);
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: FilledButton.icon(
                        icon: const Icon(LucideIcons.share2, size: 16),
                        label: Text(l10n.inviteShare),
                        onPressed: () => SharePlus.instance.share(
                          ShareParams(text: data.link),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.invitePointsTitle,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.invitePointsLine(points, data.joined, data.verified),
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.invitePointsRule,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
                if (_redeemError != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _redeemError!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.danger,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                FilledButton.icon(
                  icon: const Icon(LucideIcons.sprout, size: 18),
                  label: Text(l10n.inviteRedeem),
                  onPressed: redeemable < 1 || _redeeming
                      ? null
                      : () async {
                          setState(() {
                            _redeeming = true;
                            _redeemError = null;
                          });
                          final result = await ref
                              .read(inviteControllerProvider.notifier)
                              .redeemTree();
                          if (!mounted) return;
                          setState(() {
                            _redeeming = false;
                            result.fold(
                              (_) {},
                              (failure) =>
                                  _redeemError = failureText(l10n, failure),
                            );
                          });
                        },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(l10n.forestTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        if (data.trees.isEmpty)
          Text(
            l10n.forestCount(0),
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tree in data.trees)
                Chip(
                  avatar: Icon(
                    LucideIcons.sprout,
                    size: 16,
                    color: tree.plantedAt == null
                        ? tokens.inkSoft
                        : tokens.tealDeep,
                  ),
                  label: Text(
                    tree.plantedAt == null
                        ? l10n.treePledged
                        : '${l10n.treePlanted}'
                              '${tree.district == null ? '' : ' · ${tree.district}'}',
                  ),
                ),
            ],
          ),
      ],
    );
  }
}
