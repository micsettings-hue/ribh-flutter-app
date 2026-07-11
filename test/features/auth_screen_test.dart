import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/repositories/auth_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/features/auth/auth_screen.dart';

class FakeAuthRepository extends AuthRepository {
  FakeAuthRepository({this.sendResult, this.verifyResult}) : super(null);

  final Result<void>? sendResult;
  final Result<void>? verifyResult;
  String? sentTo;
  String? verifiedCode;

  @override
  Future<Result<void>> sendEmailOtp(String email) async {
    sentTo = email;
    return sendResult ?? const Ok(null);
  }

  @override
  Future<Result<void>> verifyEmailOtp({
    required String email,
    required String code,
  }) async {
    verifiedCode = code;
    return verifyResult ?? const Ok(null);
  }
}

Widget wrap(FakeAuthRepository repo) => ProviderScope(
  overrides: [authRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const AuthScreen(),
  ),
);

void main() {
  testWidgets('happy path: email, code sent, verify called', (tester) async {
    final repo = FakeAuthRepository();
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'user@example.com');
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();

    expect(repo.sentTo, 'user@example.com');
    expect(find.text('One-time code'), findsOneWidget);
    expect(
      find.text('Enter the code we sent to user@example.com.'),
      findsOneWidget,
    );

    await tester.enterText(find.byType(TextField), '123456');
    await tester.tap(find.text('Verify and continue'));
    await tester.pumpAndSettle();
    expect(repo.verifiedCode, '123456');
  });

  testWidgets('invalid email is refused locally', (tester) async {
    final repo = FakeAuthRepository();
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'not-an-email');
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();

    expect(repo.sentTo, isNull);
    expect(find.text('Enter a valid email address.'), findsOneWidget);
  });

  testWidgets('failure path: rejected code shows a real error', (tester) async {
    final repo = FakeAuthRepository(
      verifyResult: const Err(AuthFailure('otp_expired')),
    );
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'user@example.com');
    await tester.tap(find.text('Send code'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '000000');
    await tester.tap(find.text('Verify and continue'));
    await tester.pumpAndSettle();

    expect(
      find.text('You are signed out or the code was not accepted. Try again.'),
      findsOneWidget,
    );
    // Still on the code stage so the user can retry.
    expect(find.text('One-time code'), findsOneWidget);
  });
}
