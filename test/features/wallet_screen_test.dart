import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:ribh/features/wallet/wallet_screen.dart';

class FakeWalletRepository extends WalletRepository {
  FakeWalletRepository({
    this.balance = 12840000, // 1,28,400 taka
    this.balanceFailure,
    this.depositResult,
    this.withdrawalResult,
  }) : super(null);

  int balance;
  Failure? balanceFailure;
  Result<String>? depositResult;
  Result<String>? withdrawalResult;

  final transactions = <WalletTransaction>[
    WalletTransaction(
      id: 't1',
      walletId: 'w1',
      kind: TxKind.deposit,
      amount: 10000000,
      createdAt: DateTime.utc(2026, 7, 1),
    ),
    WalletTransaction(
      id: 't2',
      walletId: 'w1',
      kind: TxKind.investment,
      amount: 4000000,
      createdAt: DateTime.utc(2026, 7, 5),
    ),
  ];
  final requests = <MoneyRequest>[];
  final cancelled = <String>[];
  PaymentMethod? depositMethod;
  int? depositAmount;
  String? depositReference;
  PaymentMethod? withdrawalMethod;
  int? withdrawalAmount;

  @override
  Future<Result<int>> myBalance() async =>
      balanceFailure == null ? Ok(balance) : Err(balanceFailure!);

  @override
  Future<Result<List<WalletTransaction>>> myTransactions({
    int limit = 50,
    DateTime? before,
  }) async => Ok(transactions);

  @override
  Future<Result<List<MoneyRequest>>> myMoneyRequests({int limit = 20}) async =>
      Ok(List.of(requests));

  @override
  Future<Result<String>> requestDeposit({
    required PaymentMethod method,
    required int amount,
    String? reference,
  }) async {
    if (depositResult case final result?) return result;
    depositMethod = method;
    depositAmount = amount;
    depositReference = reference;
    requests.add(
      MoneyRequest(
        id: 'r${requests.length + 1}',
        profileId: 'u1',
        kind: MoneyRequestKind.deposit,
        method: method,
        amount: amount,
        reference: reference,
        status: MoneyRequestStatus.pending,
        createdAt: DateTime.utc(2026, 7, 12),
      ),
    );
    return Ok(requests.last.id);
  }

  @override
  Future<Result<String>> requestWithdrawal({
    required PaymentMethod method,
    required int amount,
  }) async {
    if (withdrawalResult case final result?) return result;
    withdrawalMethod = method;
    withdrawalAmount = amount;
    requests.add(
      MoneyRequest(
        id: 'r${requests.length + 1}',
        profileId: 'u1',
        kind: MoneyRequestKind.withdrawal,
        method: method,
        amount: amount,
        status: MoneyRequestStatus.pending,
        createdAt: DateTime.utc(2026, 7, 12),
      ),
    );
    return Ok(requests.last.id);
  }

  @override
  Future<Result<void>> cancelMoneyRequest(String requestId) async {
    cancelled.add(requestId);
    requests.removeWhere((r) => r.id == requestId);
    return const Ok(null);
  }
}

Widget wrap(FakeWalletRepository repo, {Locale? locale}) => ProviderScope(
  retry: (retryCount, error) => null,
  overrides: [walletRepositoryProvider.overrideWithValue(repo)],
  child: MaterialApp(
    theme: RibhTheme.light(),
    locale: locale,
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: const WalletScreen(),
  ),
);

void main() {
  testWidgets('happy path: derived balance, ledger rows, honest derivation '
      'note', (tester) async {
    // Tall surface so the ledger below the performance empty-state builds.
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(wrap(FakeWalletRepository()));
    await tester.pumpAndSettle();

    expect(find.text('৳128,400'), findsOneWidget);
    expect(
      find.text('Derived from your append-only ledger, never stored.'),
      findsOneWidget,
    );
    expect(find.text('Deposit'), findsOneWidget);
    expect(find.text('Investment'), findsOneWidget);
    expect(find.text('+৳100,000'), findsOneWidget);
    expect(find.text('-৳40,000'), findsOneWidget);
  });

  testWidgets('Bengali locale renders Indian grouping', (tester) async {
    await tester.pumpWidget(
      wrap(FakeWalletRepository(), locale: const Locale('bn')),
    );
    await tester.pumpAndSettle();
    expect(find.text('৳1,28,400'), findsOneWidget);
  });

  testWidgets('failure path: balance failure shows message and retry reloads', (
    tester,
  ) async {
    final repo = FakeWalletRepository(balanceFailure: const NetworkFailure());
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    expect(
      find.text('Network unavailable. Check your connection and try again.'),
      findsOneWidget,
    );

    repo.balanceFailure = null;
    await tester.tap(find.text('Retry'));
    await tester.pumpAndSettle();
    expect(find.text('৳128,400'), findsOneWidget);
  });

  testWidgets('deposit sheet: bKash request records and shows the honest '
      'pending state', (tester) async {
    final repo = FakeWalletRepository();
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add funds'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '2500.50');
    await tester.tap(find.text('Record deposit request'));
    await tester.pumpAndSettle();

    expect(repo.depositMethod, PaymentMethod.bkash);
    expect(repo.depositAmount, 250050);
    expect(find.text('Request recorded, pending'), findsOneWidget);
    expect(find.textContaining('nothing has been charged'), findsOneWidget);

    // Closing the sheet shows the new pending request on the wallet screen.
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    expect(find.text('Pending requests'), findsOneWidget);
    expect(find.textContaining('Deposit ৳2,500.50'), findsOneWidget);
  });

  testWidgets('deposit sheet: bank transfer requires a reference', (
    tester,
  ) async {
    final repo = FakeWalletRepository();
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add funds'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bank transfer'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).first, '1000');
    await tester.tap(find.text('Record deposit request'));
    await tester.pumpAndSettle();
    expect(
      find.text('A transfer reference is required for bank deposits.'),
      findsOneWidget,
    );
    expect(repo.depositAmount, isNull);
  });

  testWidgets('deposit sheet failure: repository error stays in the sheet', (
    tester,
  ) async {
    final repo = FakeWalletRepository(
      depositResult: const Err(NotVerifiedFailure()),
    );
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Add funds'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '1000');
    await tester.tap(find.text('Record deposit request'));
    await tester.pumpAndSettle();

    expect(
      find.text('Identity verification is required first.'),
      findsOneWidget,
    );
    expect(find.text('Request recorded, pending'), findsNothing);
  });

  testWidgets('withdraw sheet: over-available amount is refused locally', (
    tester,
  ) async {
    final repo = FakeWalletRepository();
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Withdraw'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), '999999');
    await tester.tap(find.text('Record withdrawal request'));
    await tester.pumpAndSettle();

    expect(
      find.text('Your available balance is not enough for this amount.'),
      findsOneWidget,
    );
    expect(repo.withdrawalAmount, isNull);
  });

  testWidgets('withdraw sheet happy path records the request pending', (
    tester,
  ) async {
    final repo = FakeWalletRepository();
    await tester.pumpWidget(wrap(repo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Withdraw'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '500');
    await tester.tap(find.text('Record withdrawal request'));
    await tester.pumpAndSettle();

    expect(repo.withdrawalMethod, PaymentMethod.bank);
    expect(repo.withdrawalAmount, 50000);
    expect(find.text('Request recorded, pending'), findsOneWidget);
  });

  testWidgets('capture: wallet', (tester) async {
    tester.view.physicalSize = const Size(800, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(wrap(FakeWalletRepository()));
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(WalletScreen),
      matchesGoldenFile('captures/wallet.png'),
    );
  });
}
