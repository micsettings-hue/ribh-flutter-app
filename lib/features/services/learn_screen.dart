import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'services_controllers.dart';

/// Learn: the lesson catalogue with per-user progress persisted to
/// lessons_progress. Module content is board-gated placeholder text
/// (stated in the sheet); progress itself is real.
class LearnScreen extends ConsumerWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final learn = ref.watch(learnControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceLearn)),
      body: learn.when(
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
                  onPressed: () => ref.invalidate(learnControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l10n.learnProgressLine(data.completedCount, data.lessons.length),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            for (final lesson in data.lessons)
              Card(
                child: ListTile(
                  leading: Icon(
                    (data.progress[lesson.id]?.completed ?? false)
                        ? LucideIcons.circleCheck
                        : LucideIcons.bookOpen,
                    color: (data.progress[lesson.id]?.completed ?? false)
                        ? tokens.teal
                        : tokens.inkSoft,
                  ),
                  title: Text(lesson.title),
                  subtitle: Text(
                    switch (data.progress[lesson.id]) {
                      null => l10n.serviceLearn,
                      final p when p.completed =>
                        '${l10n.learnCompleted} · '
                            '${l10n.learnReadCount(p.readCount)}',
                      final p => l10n.learnReadCount(p.readCount),
                    },
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
                  ),
                  trailing: const Icon(LucideIcons.chevronRight),
                  onTap: () => showRibhSheet<void>(
                    context: context,
                    builder: (_) =>
                        _ModuleSheet(lessonId: lesson.id, title: lesson.title),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _ModuleSheet extends ConsumerStatefulWidget {
  const _ModuleSheet({required this.lessonId, required this.title});

  final String lessonId;
  final String title;

  @override
  ConsumerState<_ModuleSheet> createState() => _ModuleSheetState();
}

class _ModuleSheetState extends ConsumerState<_ModuleSheet> {
  bool _busy = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    return RibhSheetScaffold(
      title: widget.title,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.learnModuleBody,
            style: Theme.of(context).textTheme.bodyMedium,
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
            onPressed: _busy
                ? null
                : () async {
                    setState(() {
                      _busy = true;
                      _error = null;
                    });
                    final result = await ref
                        .read(learnControllerProvider.notifier)
                        .markRead(widget.lessonId);
                    if (!mounted) return;
                    result.fold(
                      (_) => Navigator.of(context).pop(),
                      (failure) => setState(() {
                        _busy = false;
                        _error = failureText(l10n, failure);
                      }),
                    );
                  },
            child: Text(_busy ? l10n.submitting : l10n.learnMarkRead),
          ),
        ],
      ),
    );
  }
}
