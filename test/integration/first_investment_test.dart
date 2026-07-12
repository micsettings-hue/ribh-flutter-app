import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/router/router.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
import 'package:ribh/data/repositories/goal_repository.dart';
import 'package:ribh/data/repositories/investment_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';

/// The first-investment journey end to end (from the activity diagram in
/// the dossier), over the REAL router: Home -> Invest -> campaign detail ->
/// calculator visible -> both acknowledgements -> commit -> the holding
/// appears on Home and the ledger shows the investment with the balance
/// down by exactly the invested amount.
///
/// A shared in-memory rail keeps the fakes consistent the way the database
/// transaction does: one invest() writes the investment AND the ledger row.
class MemoryRail {
  final transactions = <WalletTransaction>[
    WalletTransaction(
      id: 't-deposit',
      walletId: 'w1',
      kind: TxKind.deposit,
      amount: 10000000, // 100,000 taka available
      createdAt: DateTime.utc(2026, 7, 1),
    ),
  ];
  final investments = <Investment>[];

  int get balance => transactions.fold(0, (sum, tx) => sum + tx.signedAmount);

  String invest(String campaignId, int amount) {
    final id = 'inv-${investments.length + 1}';
    investments.add(
      Investment(
        id: id,
        profileId: 'u1',
        campaignId: campaignId,
        amount: amount,
        riskAck1: true,
        riskAck2: true,
        source: 'wallet',
        createdAt: DateTime.utc(2026, 7, 12),
      ),
    );
    transactions.insert(
      0,
      WalletTransaction(
        id: 'tx-$id',
        walletId: 'w1',
        kind: TxKind.investment,
        amount: amount,
        createdAt: DateTime.utc(2026, 7, 12),
      ),
    );
    return id;
  }
}

final _campaign = Campaign(
  id: 'c1',
  title: 'Printing Zone',
  contract: 'murabaha',
  sector: 'printing',
  pool: 500000000,
  raised: 210000000,
  profitPerLac: 1450000,
  share: 60,
  tenure: 6,
  risk: 'moderate',
  status: CampaignStatus.open,
  createdAt: DateTime.utc(2026, 7, 1),
);

class RailCampaignRepository extends CampaignRepository {
  RailCampaignRepository() : super(null);

  @override
  Future<Result<List<Campaign>>> campaigns({CampaignStatus? status}) async =>
      Ok([_campaign]);

  @override
  Future<Result<Campaign>> campaignById(String id) async => Ok(_campaign);

  @override
  Future<Result<Set<String>>> myWatchlist() async => const Ok({});
}

class RailInvestmentRepository extends InvestmentRepository {
  RailInvestmentRepository(this.rail) : super(null);

  final MemoryRail rail;

  @override
  Future<Result<List<Investment>>> myInvestments() async =>
      Ok(List.of(rail.investments));

  @override
  Future<Result<String>> invest({
    required String campaignId,
    required int amount,
    required bool riskAck1,
    required bool riskAck2,
    String source = 'wallet',
  }) async {
    if (!(riskAck1 && riskAck2)) {
      return const Err(ValidationFailure('risk_acknowledgements_required'));
    }
    if (rail.balance < amount) {
      return const Err(InsufficientFundsFailure());
    }
    return Ok(rail.invest(campaignId, amount));
  }
}

class RailWalletRepository extends WalletRepository {
  RailWalletRepository(this.rail) : super(null);

  final MemoryRail rail;

  @override
  Future<Result<int>> myBalance() async => Ok(rail.balance);

  @override
  Future<Result<List<WalletTransaction>>> myTransactions({
    int limit = 50,
    DateTime? before,
  }) async => Ok(List.of(rail.transactions));

  @override
  Future<Result<List<MoneyRequest>>> myMoneyRequests({int limit = 20}) async =>
      const Ok([]);
}

class EmptyGoalRepository extends GoalRepository {
  EmptyGoalRepository() : super(null);

  @override
  Future<Result<List<Goal>>> myGoals() async => const Ok([]);
}

void main() {
  testWidgets('first-investment journey: marketplace to committed holding '
      'with the ledger moving once', (tester) async {
    tester.view.physicalSize = const Size(800, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final rail = MemoryRail();
    await tester.pumpWidget(
      ProviderScope(
        retry: (retryCount, error) => null,
        overrides: [
          campaignRepositoryProvider.overrideWithValue(
            RailCampaignRepository(),
          ),
          investmentRepositoryProvider.overrideWithValue(
            RailInvestmentRepository(rail),
          ),
          walletRepositoryProvider.overrideWithValue(
            RailWalletRepository(rail),
          ),
          goalRepositoryProvider.overrideWithValue(EmptyGoalRepository()),
        ],
        child: Consumer(
          builder: (context, ref, _) => MaterialApp.router(
            theme: RibhTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: ref.watch(routerProvider),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Home: real available balance from the ledger, no holdings yet.
    expect(find.text('৳100,000'), findsWidgets);
    expect(find.textContaining('No investments yet'), findsOneWidget);

    // Invest tab -> marketplace -> campaign detail.
    await tester.tap(find.text('Invest').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Printing Zone'));
    await tester.pumpAndSettle();

    // Detail: calculator default (1 lac at these terms = 8,700 projected).
    expect(find.text('Projected profit: ৳8,700 over 6 months'), findsOneWidget);

    // Invest 25,000 taka with both acknowledgements.
    await tester.tap(find.text('Invest in this campaign'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Amount in taka').last,
      '25000',
    );
    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.tap(find.byType(CheckboxListTile).last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Commit investment'));
    await tester.pumpAndSettle();
    expect(find.text('Investment committed'), findsOneWidget);
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();

    // The rail moved exactly once: one investment, one ledger row.
    expect(rail.investments, hasLength(1));
    expect(rail.investments.single.amount, 2500000);
    expect(rail.balance, 7500000); // 100,000 - 25,000 taka in poisha

    // Pop the detail back to the shell, then to Home.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home').last);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text('৳75,000'), findsWidgets);
    expect(find.textContaining('৳25,000 invested'), findsOneWidget);

    // Wallet ledger shows the investment row (amanah card's Ledger link).
    await tester.tap(find.text('Ledger'));
    await tester.pumpAndSettle();
    expect(find.text('Investment'), findsOneWidget);
    expect(find.text('-৳25,000'), findsOneWidget);

    // Let Riverpod's scheduler flush pending refresh tasks (auto-dispose of
    // the detail family provider) before tearing the tree down, then
    // dispose so the banner's periodic timer is cancelled.
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpWidget(const SizedBox());
    await tester.pump();
  });
}
