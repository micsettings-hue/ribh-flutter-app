import 'package:flutter/material.dart';

import '../app/theme/ribh_tokens.dart';

/// One tile in the Home services grid. 44dp-plus target, stroke icon,
/// optional SOON badge for honestly-not-yet services (Qard).
class ServiceTile extends StatelessWidget {
  const ServiceTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.soonBadge,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final String? soonBadge;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return Material(
      color: tokens.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: tokens.line, width: 1.5),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: tokens.mintSoft,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, size: 18, color: tokens.teal),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              if (soonBadge != null)
                Positioned(
                  top: 0,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: tokens.amberSoft,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      soonBadge!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontSize: 9,
                        color: tokens.amber,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
