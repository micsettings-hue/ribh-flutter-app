import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/theme/ribh_tokens.dart';
import '../core/formatters/taka.dart';
import '../data/models/models.dart';

IconData goalIcon(String name) => switch (name) {
  'home' => LucideIcons.house,
  'hajj' || 'mosque' => LucideIcons.moonStar,
  'education' || 'book' => LucideIcons.bookOpen,
  'business' => LucideIcons.store,
  'family' || 'heart' => LucideIcons.heart,
  _ => LucideIcons.target,
};

/// One savings goal: icon, title, saved of target with a progress bar.
/// Read-only on Home; editing lives in Grow (M6).
class GoalRow extends StatelessWidget {
  const GoalRow({super.key, required this.goal});

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final progress = goal.target == 0
        ? 0.0
        : (goal.saved / goal.target).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: tokens.mintSoft,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(goalIcon(goal.icon), size: 18, color: tokens.teal),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(goal.title, style: theme.textTheme.titleSmall),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 5,
                    backgroundColor: tokens.mintSoft,
                    color: tokens.green,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '${formatTaka(goal.saved, localeCode: locale)} / '
            '${formatTaka(goal.target, localeCode: locale)}',
            style: theme.textTheme.labelSmall?.copyWith(color: tokens.inkSoft),
          ),
        ],
      ),
    );
  }
}
