import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/goal_row.dart' show goalIcon;
import '../../shared/ribh_sheet_scaffold.dart';
import 'grow_controller.dart';

const goalIconChoices = [
  'target',
  'home',
  'hajj',
  'education',
  'business',
  'family',
];

/// Create or edit a savings goal (writes `goals`). Deleting is available
/// while editing. Goals hold no money themselves in v1; `saved` grows via
/// future flows, so this sheet edits title, icon, and target only.
class GoalSheet extends ConsumerStatefulWidget {
  const GoalSheet({super.key, this.existing});

  final Goal? existing;

  @override
  ConsumerState<GoalSheet> createState() => _GoalSheetState();
}

class _GoalSheetState extends ConsumerState<GoalSheet> {
  late final _titleController = TextEditingController(
    text: widget.existing?.title ?? '',
  );
  late final _targetController = TextEditingController(
    text: widget.existing == null
        ? ''
        : (widget.existing!.target ~/ 100).toString(),
  );
  late String _icon = widget.existing?.icon ?? 'target';
  bool _busy = false;
  String? _error;

  @override
  void dispose() {
    _titleController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context)!;
    final title = _titleController.text.trim();
    final target = parseTakaToPoisha(_targetController.text);
    if (title.isEmpty) {
      setState(() => _error = l10n.goalTitleMissing);
      return;
    }
    if (target == null) {
      setState(() => _error = l10n.invalidAmount);
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    final controller = ref.read(goalsControllerProvider.notifier);
    final result = widget.existing == null
        ? await controller.createGoal(title: title, icon: _icon, target: target)
        : await controller.updateGoal(
            widget.existing!.id,
            title: title,
            icon: _icon,
            target: target,
          );
    if (!mounted) return;
    result.fold(
      (_) => Navigator.of(context).pop(),
      (failure) => setState(() {
        _busy = false;
        _error = failureText(l10n, failure);
      }),
    );
  }

  Future<void> _delete() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref
        .read(goalsControllerProvider.notifier)
        .deleteGoal(widget.existing!.id);
    if (!mounted) return;
    result.fold(
      (_) => Navigator.of(context).pop(),
      (failure) => setState(() {
        _busy = false;
        _error = failureText(l10n, failure);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final editing = widget.existing != null;

    return RibhSheetScaffold(
      title: editing ? l10n.goalSheetTitleEdit : l10n.goalSheetTitleNew,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: l10n.goalTitleLabel),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _targetController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              labelText: l10n.goalTargetLabel,
              prefixText: takaSign,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final name in goalIconChoices)
                ChoiceChip(
                  avatar: Icon(
                    goalIcon(name),
                    size: 16,
                    color: _icon == name ? tokens.tealDeep : tokens.inkSoft,
                  ),
                  label: Text(goalIconLabel(l10n, name)),
                  selected: _icon == name,
                  onSelected: (_) => setState(() => _icon = name),
                ),
            ],
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
            onPressed: _busy ? null : _save,
            child: Text(_busy ? l10n.submitting : l10n.goalSave),
          ),
          if (editing)
            TextButton(
              onPressed: _busy ? null : _delete,
              style: TextButton.styleFrom(foregroundColor: tokens.danger),
              child: Text(l10n.goalDelete),
            ),
        ],
      ),
    );
  }
}

String goalIconLabel(AppLocalizations l10n, String name) => switch (name) {
  'home' => l10n.goalIconHome,
  'hajj' => l10n.goalIconHajj,
  'education' => l10n.goalIconEducation,
  'business' => l10n.goalIconBusiness,
  'family' => l10n.goalIconFamily,
  _ => l10n.goalIconGeneral,
};
