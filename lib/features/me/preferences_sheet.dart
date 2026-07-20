import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/app.dart';
import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../shared/ribh_sheet_scaffold.dart';

/// Language picker. Writes the chosen locale (or null = follow device) and
/// persists it; the change applies live across the app.
class LanguageSheet extends ConsumerWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = ref.watch(localeProvider);
    final controller = ref.read(localeProvider.notifier);

    Widget option(String label, Locale? value, bool selected) => _OptionTile(
      label: label,
      selected: selected,
      onTap: () {
        controller.set(value);
        Navigator.of(context).pop();
      },
    );

    return RibhSheetScaffold(
      title: l10n.mePrefLanguage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          option(l10n.langSystem, null, current == null),
          option(
            l10n.langEnglish,
            const Locale('en'),
            current?.languageCode == 'en',
          ),
          option(
            l10n.langBengali,
            const Locale('bn'),
            current?.languageCode == 'bn',
          ),
        ],
      ),
    );
  }
}

/// Theme picker: system, light, or dark. Persisted and applied live.
class ThemeSheet extends ConsumerWidget {
  const ThemeSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final current = ref.watch(themeModeProvider);
    final controller = ref.read(themeModeProvider.notifier);

    Widget option(String label, ThemeMode value) => _OptionTile(
      label: label,
      selected: current == value,
      onTap: () {
        controller.set(value);
        Navigator.of(context).pop();
      },
    );

    return RibhSheetScaffold(
      title: l10n.mePrefTheme,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          option(l10n.themeSystem, ThemeMode.system),
          option(l10n.themeLight, ThemeMode.light),
          option(l10n.themeDark, ThemeMode.dark),
        ],
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    return ListTile(
      title: Text(label),
      trailing: selected ? Icon(LucideIcons.check, color: tokens.teal) : null,
      onTap: onTap,
    );
  }
}

/// Human-readable current-language label for the Me row subtitle.
String currentLanguageLabel(AppLocalizations l10n, Locale? locale) =>
    switch (locale?.languageCode) {
      'en' => l10n.langEnglish,
      'bn' => l10n.langBengali,
      _ => l10n.langSystem,
    };

String currentThemeLabel(AppLocalizations l10n, ThemeMode mode) =>
    switch (mode) {
      ThemeMode.light => l10n.themeLight,
      ThemeMode.dark => l10n.themeDark,
      ThemeMode.system => l10n.themeSystem,
    };
