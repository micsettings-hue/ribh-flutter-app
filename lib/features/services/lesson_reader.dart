import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../app/theme/spacing.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/haptics.dart';
import 'services_controllers.dart';

/// Estimated reading time in whole minutes at ~200 words per minute (a
/// careful, reflective pace for this material), never less than one. Pure so
/// the estimate is unit-testable.
int lessonReadMinutes(String body) {
  final words = body.trim().split(RegExp(r'\s+')).where((w) => w.isNotEmpty);
  final minutes = (words.length / 200).ceil();
  return minutes < 1 ? 1 : minutes;
}

/// Full-screen reader for one lesson: a draft banner (content is board-gated),
/// the reading-time estimate, the long-form body, and a mark-as-read action
/// that persists real progress to lessons_progress.
class LessonReaderScreen extends ConsumerStatefulWidget {
  const LessonReaderScreen({super.key, required this.lesson});

  final Lesson lesson;

  @override
  ConsumerState<LessonReaderScreen> createState() => _LessonReaderScreenState();
}

class _LessonReaderScreenState extends ConsumerState<LessonReaderScreen> {
  bool _busy = false;
  String? _error;

  Future<void> _markRead() async {
    final l10n = AppLocalizations.of(context)!;
    setState(() {
      _busy = true;
      _error = null;
    });
    final result = await ref
        .read(learnControllerProvider.notifier)
        .markRead(widget.lesson.id);
    if (!mounted) return;
    result.fold((_) {
      RibhHaptics.commit();
      Navigator.of(context).pop();
    }, (failure) => setState(() {
      _busy = false;
      _error = failureText(l10n, failure);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final body = widget.lesson.body.trim();

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
                children: [
                  Text(widget.lesson.title, style: theme.textTheme.displaySmall),
                  const SizedBox(height: RibhSpace.sm),
                  Row(
                    children: [
                      Icon(LucideIcons.clock, size: 14, color: tokens.inkSoft),
                      const SizedBox(width: RibhSpace.xs),
                      Text(
                        l10n.learnReadMinutes(lessonReadMinutes(body)),
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: tokens.inkSoft,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: RibhSpace.lg),
                  // The content is board-gated placeholder; say so up front.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: tokens.amberSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.triangleAlert,
                          size: 16,
                          color: tokens.amber,
                        ),
                        const SizedBox(width: RibhSpace.sm),
                        Expanded(
                          child: Text(
                            l10n.learnDraftBanner,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: tokens.amber,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: RibhSpace.xl),
                  if (body.isEmpty)
                    Text(
                      l10n.learnBodyPending,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: tokens.inkSoft,
                      ),
                    )
                  else
                    ..._renderBody(context, body),
                ],
              ),
            ),
            if (_error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  _error!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.danger,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _busy ? null : _markRead,
                  child: Text(_busy ? l10n.submitting : l10n.learnMarkRead),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Minimal markup: lines starting with "## " are section headings, blank
  /// lines separate paragraphs. Keeps the board's editing surface plain text.
  List<Widget> _renderBody(BuildContext context, String body) {
    final theme = Theme.of(context);
    final tokens = context.tokens;
    final blocks = body.split(RegExp(r'\n\s*\n'));
    final widgets = <Widget>[];
    for (final raw in blocks) {
      final block = raw.trim();
      if (block.isEmpty) continue;
      if (block.startsWith('## ')) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(top: RibhSpace.lg, bottom: RibhSpace.sm),
            child: Text(
              block.substring(3).trim(),
              style: theme.textTheme.titleMedium,
            ),
          ),
        );
      } else {
        widgets.add(
          Padding(
            padding: const EdgeInsets.only(bottom: RibhSpace.md),
            child: Text(
              block,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.55,
                color: tokens.ink,
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }
}
