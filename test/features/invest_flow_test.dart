import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
import 'package:ribh/data/repositories/investment_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:ribh/features/campaign/campaign_detail_screen.dart';
import 'package:ribh/features/home/home_screen.dart';
import 'package:ribh/features/invest/invest_screen.dart';

final _campaigns = [
  Campaign(
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
  ),
  Campaign(
    id: 'c2',
    title: 'Machinery Purchase',
    contract: 'murabaha',
    sector: 'machinery',
    pool: 800000000,
    raised: 800000000,
    profitPerLac: 1600000,
    share: 60,
    tenure: 9,
    risk: 'moderate',
    status: CampaignStatus.running,
    createdAt: DateTime.utc(2026, 6, 1),
  ),
  Campaign(
    id: 'c3',
    title: 'Machinery Trading',
    contract: 'musharakah',
    sector: 'machinery',
    pool: 600000000,
    raised: 600000000,
    profitPerLac: 1750000,
    share: 55,
    tenure: 12,
    risk: 'elevated',
    status: CampaignStatus.matured,
    createdAt: DateTime.utc(2026, 5, 1),
  ),
  Campaign(
    id: 'c4',
    title: 'Musannif Cement',
    contract: 'murabaha',
    sector: 'construction',
    pool: 1000000000,
    raised: 1000000000,
    profitPerLac: 1500000,
    share: 60,
    tenure: 12,
    risk: 'elevated',
    status: CampaignStatus.inRecovery,
    createdAt: DateTime.utc(2026, 4, 1),
  ),
];

class FakeCampaignRepository extends CampaignRepository {
  FakeCampaignRepository() : super(null);

  final saved = <String>{};

  @override
  Future<Result<List<Campaign>>> campaigns({CampaignStatus? status}) async =>
      Ok(_campaigns);

  @override
  Future<Result<Campaign>> campaignById(String id) async =>
      Ok(_campaigns.firstWhere((c) => c.id == id));

  @override
  Future<Result<Set<String>>> myWatchlist() async => Ok(Set.of(saved));

  @override
  Future<Result<void>> saveToWatchlist(String campaignId) async {
    saved.add(campaignId);
    return const Ok(null);
  }

  @override
  Future<Result<void>> removeFromWatchlist(String campaignId) async {
    saved.remove(campaignId);
    return const Ok(null);
  }
}

class FakeInvestmentRepository extends InvestmentRepository {
  FakeInvestmentRepository({this.investResult, this.investments = const []})
    : super(null);

  final Result<String>? investResult;
  final List<Investment> investments;
  int? investedAmount;
  String? investedCampaignId;

  @override
  Future<Result<List<Investment>>> myInvestments() async => Ok(investments);

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
    if (investResult case final result?) return result;
    investedCampaignId = campaignId;
    investedAmount = amount;
    return const Ok('inv-1');
  }
}

class FakeWalletRepository extends WalletRepository {
  FakeWalletRepository() : super(null);

  @override
  Future<Result<int>> myBalance() async => const Ok(0);

  @override
  Future<Result<List<WalletTransaction>>> myTransactions({
    int limit = 50,
    DateTime? before,
  }) async => const Ok([]);

  @override
  Future<Result<List<MoneyRequest>>> myMoneyRequests({int limit = 20}) async =>
      const Ok([]);
}

/// Pumps [home] on a tall viewport so full-page ListViews build all their
/// children (the default 800x600 surface leaves lower content unbuilt).
Future<void> pumpTall(
  WidgetTester tester,
  Widget home, {
  FakeCampaignRepository? campaignRepo,
  FakeInvestmentRepository? investmentRepo,
}) async {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    wrap(home, campaignRepo: campaignRepo, investmentRepo: investmentRepo),
  );
  await tester.pumpAndSettle();
}

Widget wrap(
  Widget home, {
  FakeCampaignRepository? campaignRepo,
  FakeInvestmentRepository? investmentRepo,
}) => ProviderScope(
  retry: (retryCount, error) => null,
  overrides: [
    campaignRepositoryProvider.overrideWithValue(
      campaignRepo ?? FakeCampaignRepository(),
    ),
    investmentRepositoryProvider.overrideWithValue(
      investmentRepo ?? FakeInvestmentRepository(),
    ),
    walletRepositoryProvider.overrideWithValue(FakeWalletRepository()),
  ],
  child: MaterialApp(
    theme: RibhTheme.light(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  ),
);

void main() {
  testWidgets('marketplace lists all campaigns with live funding and rates', (
    tester,
  ) async {
    await pumpTall(tester, const InvestScreen());

    expect(find.text('Printing Zone'), findsOneWidget);
    expect(find.text('Musannif Cement'), findsOneWidget);
    expect(find.text('42% funded'), findsOneWidget);
    // 14,500 * 60% per lac over 6 months, annualised: 17.4%.
    expect(find.text('~17.4% p.a. projected'), findsOneWidget);
    // Result count reflects the visible list.
    expect(find.text('4 campaigns'), findsOneWidget);
  });

  testWidgets('filters and search narrow the list', (tester) async {
    await pumpTall(tester, const InvestScreen());

    await tester.tap(find.widgetWithText(ChoiceChip, 'Open'));
    await tester.pumpAndSettle();
    expect(find.text('Printing Zone'), findsOneWidget);
    expect(find.text('Musannif Cement'), findsNothing);

    await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'cement');
    await tester.pumpAndSettle();
    expect(find.text('Musannif Cement'), findsOneWidget);
    expect(find.text('Printing Zone'), findsNothing);
  });

  testWidgets('watchlist bookmark persists and feeds the Saved filter', (
    tester,
  ) async {
    final campaignRepo = FakeCampaignRepository();
    await pumpTall(tester, const InvestScreen(), campaignRepo: campaignRepo);

    await tester.tap(find.widgetWithText(ChoiceChip, 'Saved'));
    await tester.pumpAndSettle();
    expect(
      find.text('No campaigns match. Adjust the filter or search.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(ChoiceChip, 'All'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Save to watchlist').first);
    await tester.pumpAndSettle();
    expect(campaignRepo.saved, {'c1'});

    await tester.tap(find.widgetWithText(ChoiceChip, 'Saved'));
    await tester.pumpAndSettle();
    expect(find.text('Printing Zone'), findsOneWidget);
    expect(find.text('Machinery Purchase'), findsNothing);
  });

  testWidgets('detail: terms, calculator from the canonical formula, '
      'projected label and risk disclosure', (tester) async {
    await pumpTall(tester, const CampaignDetailScreen(campaignId: 'c1'));

    // Default one lac: 14,500 * 60% = 8,700 taka projected over 6 months.
    expect(find.text('Projected profit: ৳8,700 over 6 months'), findsOneWidget);
    expect(find.textContaining('Projected, not guaranteed'), findsWidgets);

    // Live update: 50,000 taka halves the projection.
    await tester.enterText(
      find.widgetWithText(TextField, 'Amount in taka'),
      '50000',
    );
    await tester.pumpAndSettle();
    expect(find.text('Projected profit: ৳4,350 over 6 months'), findsOneWidget);
  });

  testWidgets('recovery tracker appears only for in_recovery campaigns', (
    tester,
  ) async {
    await pumpTall(tester, const CampaignDetailScreen(campaignId: 'c4'));
    expect(find.text('Recovery in progress'), findsOneWidget);
    expect(
      find.text('This campaign is not open for new investment.'),
      findsOneWidget,
    );
    expect(find.text('Invest in this campaign'), findsNothing);
  });

  testWidgets('invest flow: commit stays disabled until both '
      'acknowledgements, then writes through the repository', (tester) async {
    final investmentRepo = FakeInvestmentRepository();
    await pumpTall(
      tester,
      const CampaignDetailScreen(campaignId: 'c1'),
      investmentRepo: investmentRepo,
    );

    await tester.tap(find.text('Invest in this campaign'));
    await tester.pumpAndSettle();

    final commitButton = find.widgetWithText(FilledButton, 'Commit investment');
    expect(tester.widget<FilledButton>(commitButton).onPressed, isNull);
    expect(
      find.text('Both acknowledgements are required before you can invest.'),
      findsOneWidget,
    );

    // .last: the sheet's amount field sits above the calculator's.
    await tester.enterText(
      find.widgetWithText(TextField, 'Amount in taka').last,
      '25000',
    );
    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.tap(find.byType(CheckboxListTile).last);
    await tester.pumpAndSettle();
    expect(tester.widget<FilledButton>(commitButton).onPressed, isNotNull);

    await tester.tap(commitButton);
    await tester.pumpAndSettle();

    expect(investmentRepo.investedCampaignId, 'c1');
    expect(investmentRepo.investedAmount, 2500000); // poisha
    expect(find.text('Investment committed'), findsOneWidget);
  });

  testWidgets('invest flow failure: insufficient balance is a real error, '
      'not a crash', (tester) async {
    final investmentRepo = FakeInvestmentRepository(
      investResult: const Err(InsufficientFundsFailure()),
    );
    await pumpTall(
      tester,
      const CampaignDetailScreen(campaignId: 'c1'),
      investmentRepo: investmentRepo,
    );

    await tester.tap(find.text('Invest in this campaign'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Amount in taka').last,
      '999999',
    );
    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.tap(find.byType(CheckboxListTile).last);
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Commit investment'));
    await tester.pumpAndSettle();

    expect(
      find.text('Your available balance is not enough for this amount.'),
      findsOneWidget,
    );
    expect(find.text('Investment committed'), findsNothing);
  });

  testWidgets('home portfolio row orders running, matured, recovery', (
    tester,
  ) async {
    Investment holding(String id, String campaignId) => Investment(
      id: id,
      profileId: 'u1',
      campaignId: campaignId,
      amount: 5000000,
      riskAck1: true,
      riskAck2: true,
      source: 'wallet',
      createdAt: DateTime.utc(2026, 7, 10),
    );
    final investmentRepo = FakeInvestmentRepository(
      investments: [
        holding('i1', 'c4'), // in recovery
        holding('i2', 'c2'), // running
        holding('i3', 'c3'), // matured
      ],
    );
    await pumpTall(tester, const HomeScreen(), investmentRepo: investmentRepo);

    final runningX = tester.getTopLeft(find.text('Machinery Purchase')).dx;
    final maturedX = tester.getTopLeft(find.text('Machinery Trading')).dx;
    final recoveryX = tester.getTopLeft(find.text('Musannif Cement')).dx;
    expect(runningX, lessThan(maturedX));
    expect(maturedX, lessThan(recoveryX));
  });
}
