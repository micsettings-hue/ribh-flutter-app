import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_localizations.dart';
import 'router/router.dart';
import 'theme/ribh_theme.dart';

/// The chosen locale. `null` follows the device. The Me tab's language
/// toggle (M2+) writes here and persists the choice.
final localeProvider = NotifierProvider<LocaleController, Locale?>(
  LocaleController.new,
);

class LocaleController extends Notifier<Locale?> {
  @override
  Locale? build() => null;

  void set(Locale? locale) => state = locale;
}

class RibhApp extends ConsumerWidget {
  const RibhApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final chosenLocale = ref.watch(localeProvider);

    // Resolve the effective locale up front so typography (Anek Bangla for
    // Bengali, Hanken Grotesk and Inter for Latin) matches the locale.
    final effectiveLocale =
        chosenLocale ??
        basicLocaleListResolution(
          WidgetsBinding.instance.platformDispatcher.locales,
          AppLocalizations.supportedLocales,
        );

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
      theme: RibhTheme.light(locale: effectiveLocale),
      darkTheme: RibhTheme.dark(locale: effectiveLocale),
      themeMode: ThemeMode.system,
      locale: effectiveLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // Accessibility: honor large text up to 1.5x; beyond that, money
      // figures and pill rows clip instead of helping anyone.
      builder: (context, child) => MediaQuery.withClampedTextScaling(
        minScaleFactor: 1.0,
        maxScaleFactor: 1.5,
        child: child ?? const SizedBox.shrink(),
      ),
      routerConfig: router,
    );
  }
}
