import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/formatters/taka.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'grow_controller.dart';

/// The explicit consent step for one auto-invest proposal. Approving with
/// both acknowledgements deploys the rule budget and marks the item
/// approved in ONE server-side transaction. Same consent bar as a manual
/// investment; nothing is softer because it came from a strategy.
class ApproveQueueSheet extends ConsumerStatefulWidget {
  const ApproveQueueSheet({
    super.key,
    required this.entry,
    required this.budget,
  });

  final QueueEntry entry;

  /// Rule budget in poisha: the amount this approval deploys.
  final int budget;

  @override
  ConsumerState<ApproveQueueSheet> createState() => _ApproveQueueSheetState();
}

class _ApproveQueueSheetState extends ConsumerState<ApproveQueueSheet> {
  bool _ack1 = false;
  bool _ack2 = false;
  bool _submitting = false;
  String? _error;
  bool _done = false;

  Future<void> _approve() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _submitting = true;
      _error = null;
    });
    final result = await ref
        .read(growControllerProvider.notifier)
        .approve(
          itemId: widget.entry.item.id,
          riskAck1: _ack1,
          riskAck2: _ack2,
        );
    if (!mounted) return;
    setState(() {
      _submitting = false;
      result.fold(
        (_) => _done = true,
        (failure) => _error = failureText(l10n, failure),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final locale = Localizations.localeOf(context).languageCode;
    final bothAcked = _ack1 && _ack2;
    final campaign = widget.entry.campaign;

    return RibhSheetScaffold(
      title: l10n.approveSheetTitle,
      child: _done
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(LucideIcons.circleCheck, size: 40, color: tokens.teal),
                const SizedBox(height: 12),
                Text(
                  l10n.investCommittedTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.investCommittedBody,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.done),
                ),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l10n.approveSheetBody(
                    formatTaka(widget.budget, localeCode: locale),
                    campaign.title.isEmpty ? campaign.sector : campaign.title,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 8),
                CheckboxListTile(
                  value: _ack1,
                  onChanged: (value) => setState(() => _ack1 = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.investAck1,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                CheckboxListTile(
                  value: _ack2,
                  onChanged: (value) => setState(() => _ack2 = value ?? false),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    l10n.investAck2,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                if (_error != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    _error!,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.danger),
                  ),
                ],
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: bothAcked && !_submitting ? _approve : null,
                  child: Text(
                    _submitting ? l10n.submitting : l10n.growQueueApprove,
                  ),
                ),
                if (!bothAcked) ...[
                  const SizedBox(height: 8),
                  Text(
                    l10n.investAcksRequired,
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
                  ),
                ],
              ],
            ),
    );
  }
}
