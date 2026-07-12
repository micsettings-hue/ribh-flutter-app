import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/formatters/taka.dart';
import '../../core/result/result.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/haptics.dart';
import '../../shared/motion.dart';
import '../../shared/ribh_sheet_scaffold.dart';

/// Shared give flow for Zakat and Sadaqah: pick a project, enter an amount,
/// give from the wallet balance through the give_welfare RPC (contribution
/// row + ledger row in one transaction, full amount to the project).
class GiveSheet extends ConsumerStatefulWidget {
  const GiveSheet({
    super.key,
    required this.title,
    required this.projects,
    required this.onGive,
    this.presetAmount,
  });

  final String title;
  final List<WelfareProject> projects;
  final Future<Result<String>> Function({
    required String projectId,
    required int amount,
  })
  onGive;

  /// Pre-filled amount in poisha (the Sadaqah quick-give buttons).
  final int? presetAmount;

  @override
  ConsumerState<GiveSheet> createState() => _GiveSheetState();
}

class _GiveSheetState extends ConsumerState<GiveSheet> {
  late final _amountController = TextEditingController(
    text: widget.presetAmount == null
        ? ''
        : (widget.presetAmount! ~/ 100).toString(),
  );
  late String? _projectId = widget.projects.isEmpty
      ? null
      : widget.projects.first.id;
  bool _busy = false;
  String? _error;
  bool _done = false;

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _give() async {
    final l10n = AppLocalizations.of(context)!;
    final amount = parseTakaToPoisha(_amountController.text);
    if (amount == null) {
      setState(() => _error = l10n.invalidAmount);
      return;
    }
    final projectId = _projectId;
    if (projectId == null) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await widget.onGive(projectId: projectId, amount: amount);
    if (!mounted) return;
    setState(() {
      _busy = false;
      result.fold((_) {
        RibhHaptics.commit();
        _done = true;
      }, (failure) => _error = failureText(l10n, failure));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;

    return RibhSheetScaffold(
      title: widget.title,
      child: RibhSwap(
        child: _done
            ? Column(
                key: const ValueKey('done'),
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(LucideIcons.circleCheck, size: 40, color: tokens.teal),
                  const SizedBox(height: 12),
                  Text(
                    l10n.giveRecordedTitle,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.giveRecordedBody,
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
                key: const ValueKey('form'),
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: _projectId,
                    decoration: InputDecoration(
                      labelText: l10n.giveSheetProject,
                    ),
                    items: [
                      for (final project in widget.projects)
                        DropdownMenuItem(
                          value: project.id,
                          child: Text(
                            project.title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                    onChanged: (value) => setState(() => _projectId = value),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _amountController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: InputDecoration(
                      labelText: l10n.amountLabel,
                      prefixText: takaSign,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l10n.giveNoFeeNote,
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
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
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _busy || _projectId == null ? null : _give,
                    child: Text(_busy ? l10n.submitting : widget.title),
                  ),
                ],
              ),
      ),
    );
  }
}
