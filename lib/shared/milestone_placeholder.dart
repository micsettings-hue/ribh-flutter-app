import 'package:flutter/material.dart';

import '../app/l10n/app_localizations.dart';
import '../app/theme/ribh_tokens.dart';

/// Honest under-construction body for tabs whose milestone is not built yet.
/// States plainly that nothing here is live; never fakes a working feature.
class MilestonePlaceholder extends StatelessWidget {
  const MilestonePlaceholder({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            l10n.milestonePlaceholderBody,
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: tokens.inkSoft),
          ),
        ),
      ),
    );
  }
}
