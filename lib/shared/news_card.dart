import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../app/theme/ribh_tokens.dart';
import '../data/models/models.dart';

/// One News and Insight card. Fixed width for the Home horizontal scroll.
/// The thumbnail is a category-tinted stroke icon: Supabase Storage images
/// are an admin-tool follow-up, so nothing renders a broken remote image.
class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.item, this.onTap});

  final NewsItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final theme = Theme.of(context);

    return SizedBox(
      width: 260,
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 84,
                width: double.infinity,
                color: tokens.mintSoft,
                child: Icon(
                  _iconFor(item.category),
                  size: 30,
                  color: tokens.teal,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.category.toUpperCase(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: tokens.tealDeep,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleSmall,
                    ),
                    if (item.summary.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.summary,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.inkSoft,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _iconFor(String category) => switch (category.toLowerCase()) {
    'new campaign' || 'campaign' => LucideIcons.trendingUp,
    'recovery update' || 'recovery' => LucideIcons.shieldCheck,
    'insight' => LucideIcons.bookOpen,
    _ => LucideIcons.newspaper,
  };
}
