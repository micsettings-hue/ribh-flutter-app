import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

/// The shared honest empty state: a stroke icon in a mint circle, a short
/// title, and body copy that says what fills this space and how. Never a
/// blank void, never fake content.
class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: tokens.mintSoft,
              shape: BoxShape.circle,
              border: Border.all(color: tokens.line, width: 1.5),
            ),
            child: Icon(icon, size: 24, color: tokens.teal),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 4),
          Text(
            body,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
          if (action != null) ...[const SizedBox(height: 12), action!],
        ],
      ),
    );
  }
}
