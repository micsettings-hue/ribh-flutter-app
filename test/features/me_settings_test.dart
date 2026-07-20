import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/app.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/auth_repository.dart';
import 'package:ribh/data/repositories/kyc_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/features/me/help_screen.dart';
import 'package:ribh/features/me/me_screen.dart';
import 'package:ribh/features/me/preferences_sheet.dart';
import 'package:ribh/features/me/shariah_board_screen.dart';

final _profile = Profile(
  id: 'u1',
  role: UserRole.investor,
  kycTier: 0,
  lang: 'en',
  theme: 'system',
  twofaEnabled: false,
  createdAt: DateTime.utc(2026, 7, 1),
);

class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository() : super(null);
  @override
  String? get currentEmail => 'dev@ribh.local';
  @override
  Future<Result<Profile>> myProfile() async => Ok(_profile);
}

class FakeKycRepository extends KycRepository {
  FakeKycRepository() : super(null);
  @override
  Future<Result<KycSubmission?>> latestSubmission() async => const Ok(null);
}

Widget wrapMe() => ProviderScope(
  retry: (retryCount, error) => null,
  overrides: [
    authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
    kycRepositoryProvider.overrideWithValue(FakeKycRepository()),
  ],
  child: MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const MeScreen(),
  ),
);

Widget wrapWidget(Widget child) => ProviderScope(
  child: MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: child,
  ),
);

void main() {
  testWidgets('Me tab shows preferences, about, and honest coming-soon rows', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(800, 2600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(wrapMe());
    await tester.pumpAndSettle();

    // Preferences (real, static/local).
    expect(find.text('Language'), findsOneWidget);
    expect(find.text('Theme'), findsOneWidget);
    expect(find.text('System default'), findsOneWidget); // current language
    expect(find.text('System'), findsOneWidget); // current theme
    // About and support.
    expect(find.text('Shariah board'), findsOneWidget);
    expect(find.text('Help and disputes'), findsOneWidget);
    // Coming soon, honestly labelled (not faked).
    expect(find.text('Security and 2FA'), findsOneWidget);
    expect(find.text('Nominee'), findsOneWidget);
    expect(find.text('Statements'), findsOneWidget);
    expect(find.text('SOON'), findsNWidgets(3));
  });

  testWidgets('theme picker changes and persists the app theme mode', (
    tester,
  ) async {
    late ProviderContainer container;
    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (context, ref, _) {
            container = ProviderScope.containerOf(context);
            return const ThemeSheetHost();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(container.read(themeModeProvider), ThemeMode.system);
    await tester.tap(find.text('Dark'));
    await tester.pumpAndSettle();
    expect(container.read(themeModeProvider), ThemeMode.dark);
  });

  testWidgets('language picker sets the locale live', (tester) async {
    late ProviderContainer container;
    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (context, ref, _) {
            container = ProviderScope.containerOf(context);
            return const LanguageSheetHost();
          },
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(container.read(localeProvider), isNull); // system default
    await tester.tap(find.textContaining('বাংলা'));
    await tester.pumpAndSettle();
    expect(container.read(localeProvider)?.languageCode, 'bn');
  });

  testWidgets('Shariah board shows the chair real and two placeholders', (
    tester,
  ) async {
    await tester.pumpWidget(wrapWidget(const ShariahBoardScreen()));
    await tester.pumpAndSettle();

    expect(find.text('Abdullah Jubair'), findsOneWidget);
    expect(find.text('Board chair'), findsOneWidget);
    // Two placeholder seats, each badged PLACEHOLDER, never shown as real.
    expect(find.text('Placeholder seat'), findsNWidgets(2));
    expect(find.text('PLACEHOLDER'), findsNWidgets(2));
    expect(
      find.textContaining('are not real appointments'),
      findsOneWidget,
    );
  });

  testWidgets('Help page shows support email and dispute process', (
    tester,
  ) async {
    await tester.pumpWidget(wrapWidget(const HelpScreen()));
    await tester.pumpAndSettle();

    expect(find.text('support@ribh.app'), findsOneWidget);
    expect(find.text('Disputes'), findsOneWidget);
    expect(find.textContaining('append-only ledger'), findsOneWidget);
  });
}

/// Minimal hosts that render the sheets inline so the pickers can be tapped
/// without a modal route.
class ThemeSheetHost extends StatelessWidget {
  const ThemeSheetHost({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const Scaffold(body: ThemeSheet()),
  );
}

class LanguageSheetHost extends StatelessWidget {
  const LanguageSheetHost({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const Scaffold(body: LanguageSheet()),
  );
}
