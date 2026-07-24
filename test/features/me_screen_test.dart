import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/auth_repository.dart';
import 'package:ribh/data/repositories/kyc_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/features/me/me_screen.dart';

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
  FakeAuthRepository({this.profileResult}) : super(null);

  Result<Profile>? profileResult;
  String? savedRiskTier;

  @override
  String? get currentEmail => 'user@example.com';

  @override
  Future<Result<Profile>> myProfile() async => profileResult ?? Ok(_profile);

  @override
  Future<Result<Profile>> updateMyProfile({
    String? lang,
    String? theme,
    bool? twofaEnabled,
    String? riskTier,
  }) async {
    savedRiskTier = riskTier;
    profileResult = Ok(
      Profile(
        id: _profile.id,
        role: _profile.role,
        kycTier: _profile.kycTier,
        riskTier: riskTier,
        lang: _profile.lang,
        theme: _profile.theme,
        twofaEnabled: _profile.twofaEnabled,
        createdAt: _profile.createdAt,
      ),
    );
    return profileResult!;
  }
}

class FakeKycRepository extends KycRepository {
  FakeKycRepository({this.submitResult}) : super(null);

  final Result<String>? submitResult;
  KycSubmission? stored;
  String? submittedNid;
  KycSource? submittedSource;

  @override
  Future<Result<KycSubmission?>> latestSubmission() async => Ok(stored);

  @override
  Future<Result<String>> submitKyc({
    required String nidNumber,
    required KycSource sourceOfFunds,
    bool selfieCaptured = false,
  }) async {
    if (submitResult case final result?) return result;
    submittedNid = nidNumber;
    submittedSource = sourceOfFunds;
    stored = KycSubmission(
      id: 's1',
      profileId: _profile.id,
      nidHash: hashNid(nidNumber),
      sourceOfFunds: sourceOfFunds,
      selfieCaptured: false,
      status: KycStatus.pending,
      createdAt: DateTime.utc(2026, 7, 11),
    );
    return const Ok('s1');
  }
}

Widget wrap(FakeAuthRepository auth, FakeKycRepository kyc) => ProviderScope(
  retry: (retryCount, error) => null,
  overrides: [
    authRepositoryProvider.overrideWithValue(auth),
    kycRepositoryProvider.overrideWithValue(kyc),
  ],
  child: MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const MeScreen(),
  ),
);

void main() {
  testWidgets('happy path: account, KYC, and risk rows render real state', (
    tester,
  ) async {
    await tester.pumpWidget(wrap(FakeAuthRepository(), FakeKycRepository()));
    await tester.pumpAndSettle();

    expect(find.text('user@example.com'), findsOneWidget);
    expect(
      find.text('Not started. Required before your first deposit.'),
      findsOneWidget,
    );
    expect(find.text('Not set. Take the 3-question quiz.'), findsOneWidget);
  });

  testWidgets('failure path: profile failure shows message and retry works', (
    tester,
  ) async {
    final auth = FakeAuthRepository(profileResult: const Err(NetworkFailure()));
    await tester.pumpWidget(wrap(auth, FakeKycRepository()));
    await tester.pumpAndSettle();

    expect(
      find.text('Network unavailable. Check your connection and try again.'),
      findsOneWidget,
    );

    auth.profileResult = Ok(_profile);
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('user@example.com'), findsOneWidget);
  });

  testWidgets('KYC flow: NID, honest liveness note, source, submit', (
    tester,
  ) async {
    final kyc = FakeKycRepository();
    await tester.pumpWidget(wrap(FakeAuthRepository(), kyc));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Identity and KYC'));
    await tester.pumpAndSettle();

    // Step 1: invalid NID refused.
    await tester.enterText(find.byType(TextField), '123');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.text('NID numbers are 10, 13, or 17 digits.'), findsOneWidget);

    // Step 1 -> 2 -> 3 with a valid NID.
    await tester.enterText(find.byType(TextField), '1234567890');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    expect(find.textContaining('not connected yet'), findsOneWidget);

    await tester.tap(find.text('Continue without liveness'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Savings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Submit for verification'));
    await tester.pumpAndSettle();

    expect(kyc.submittedNid, '1234567890');
    expect(kyc.submittedSource, KycSource.savings);
    // Sheet closed, refreshed status now pending, honest snackbar shown.
    expect(
      find.text('Submitted. Pending verification review.'),
      findsOneWidget,
    );
    expect(find.textContaining('after real verification'), findsOneWidget);
  });

  testWidgets('KYC flow failure: submission error stays in the sheet', (
    tester,
  ) async {
    final kyc = FakeKycRepository(
      submitResult: const Err(ValidationFailure('invalid_source_of_funds')),
    );
    await tester.pumpWidget(wrap(FakeAuthRepository(), kyc));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Identity and KYC'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '1234567890');
    await tester.tap(find.text('Continue'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Continue without liveness'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Submit for verification'));
    await tester.pumpAndSettle();

    expect(find.textContaining('invalid_source_of_funds'), findsOneWidget);
  });

  testWidgets('risk quiz: three answers, recommendation, save', (tester) async {
    final auth = FakeAuthRepository();
    await tester.pumpWidget(wrap(auth, FakeKycRepository()));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Risk tier'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Within a year'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Very uneasy, I want the safest path'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Steadier, shorter cycles'));
    await tester.pumpAndSettle();

    expect(find.text('Your recommended tier'), findsOneWidget);
    expect(find.textContaining('not advice'), findsOneWidget);

    await tester.tap(find.text('Save tier'));
    await tester.pumpAndSettle();

    expect(auth.savedRiskTier, 'short');
    // Sheet closed and the Me row reflects the saved tier.
    expect(find.text('Short: steadier, shorter cycles'), findsOneWidget);
  });

  testWidgets('capture: me', (tester) async {
    tester.view.physicalSize = const Size(800, 3400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(wrap(FakeAuthRepository(), FakeKycRepository()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(MeScreen),
      matchesGoldenFile('captures/me.png'),
    );
  });
}
