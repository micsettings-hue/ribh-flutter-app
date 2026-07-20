import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';

/// The Shariah board, static display. Per the project rules: the chair is a
/// real, named appointment; the other two seats are PLACEHOLDERS and are
/// shown as such, never presented as real, until consenting scholars are
/// confirmed before launch. All copy here is TODO(board).
class ShariahBoardScreen extends StatelessWidget {
  const ShariahBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.meShariahBoard)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.boardIntro,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft),
          ),
          const SizedBox(height: 16),
          _MemberCard(
            name: l10n.boardChairName,
            role: l10n.boardChairRole,
            placeholder: false,
          ),
          const SizedBox(height: 12),
          _MemberCard(
            name: l10n.boardMemberPlaceholder,
            role: l10n.boardMemberRole,
            placeholder: true,
          ),
          const SizedBox(height: 12),
          _MemberCard(
            name: l10n.boardMemberPlaceholder,
            role: l10n.boardMemberRole,
            placeholder: true,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.boardComplianceNote,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
          ),
        ],
      ),
    );
  }
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({
    required this.name,
    required this.role,
    required this.placeholder,
  });

  final String name;
  final String role;
  final bool placeholder;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: tokens.mintSoft,
                shape: BoxShape.circle,
              ),
              child: Icon(LucideIcons.userCheck, size: 20, color: tokens.teal),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: theme.textTheme.titleSmall),
                  Text(
                    role,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: tokens.inkSoft,
                    ),
                  ),
                ],
              ),
            ),
            if (placeholder)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: tokens.amberSoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  l10n.boardPlaceholderBadge,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: tokens.amber,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
