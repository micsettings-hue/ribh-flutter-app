import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/auto_invest_repository.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
import 'package:ribh/data/repositories/goal_repository.dart';
import 'package:ribh/data/repositories/investment_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:ribh/features/grow/grow_screen.dart';

final _openCampaign = Campaign(
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

AutoInvestRule rule({bool active = true}) => AutoInvestRule(
  id: 'r1',
  profileId: 'u1',
  strategy: 'short',
  budget: 5000000, // 50,000 taka
  active: active,
  createdAt: DateTime.utc(2026, 7, 1),
);

class FakeAutoInvestRepository extends AutoInvestRepository {
  FakeAutoInvestRepository({
    this.rule,
    this.queue = const [],
    this.approveResult,
  }) : super(null);

  AutoInvestRule? rule;
  List<AutoInvestQueueItem> queue;
  Result<String>? approveResult;

  String? savedStrategy;
  int? savedBudget;
  bool? savedActive;
  String? approvedItemId;
  bool? approvedAck1;
  bool? approvedAck2;
  final declined = <String>[];

  @override
  Future<Result<AutoInvestRule?>> myRule() async => Ok(rule);

  @override
  Future<Result<AutoInvestRule>> saveRule({
    String? existingId,
    required String strategy,
    required int budget,
    required bool active,
  }) async {
    savedStrategy = strategy;
    savedBudget = budget;
    savedActive = active;
    rule = AutoInvestRule(
      id: existingId ?? 'r1',
      profileId: 'u1',
      strategy: strategy,
      budget: budget,
      active: active,
      createdAt: DateTime.utc(2026, 7, 1),
    );
    return Ok(rule!);
  }

  @override
  Future<Result<List<AutoInvestQueueItem>>> myQueue({int limit = 30}) async =>
      Ok(List.of(queue));

  @override
  Future<Result<String>> approveQueueItem({
    required String itemId,
    required bool riskAck1,
    required bool riskAck2,
  }) async {
    if (!(riskAck1 && riskAck2)) {
      return const Err(ValidationFailure('risk_acknowledgements_required'));
    }
    if (approveResult case final result?) return result;
    approvedItemId = itemId;
    approvedAck1 = riskAck1;
    approvedAck2 = riskAck2;
    queue = [
      for (final item in queue)
        if (item.id != itemId) item,
    ];
    return const Ok('inv-1');
  }

  @override
  Future<Result<void>> declineQueueItem(String itemId) async {
    declined.add(itemId);
    queue = [
      for (final item in queue)
        if (item.id != itemId) item,
    ];
    return const Ok(null);
  }
}

class FakeCampaignRepository extends CampaignRepository {
  FakeCampaignRepository({List<Campaign>? campaigns})
    : campaignList = campaigns ?? [_openCampaign],
      super(null);

  final List<Campaign> campaignList;

  @override
  Future<Result<List<Campaign>>> campaigns({CampaignStatus? status}) async =>
      Ok(campaignList);

  @override
  Future<Result<Set<String>>> myWatchlist() async => const Ok({});
}

class FakeGoalRepository extends GoalRepository {
  FakeGoalRepository() : super(null);

  final goals = <Goal>[];
  String? deletedId;

  @override
  Future<Result<List<Goal>>> myGoals() async => Ok(List.of(goals));

  @override
  Future<Result<Goal>> createGoal({
    required String title,
    required String icon,
    required int target,
  }) async {
    final goal = Goal(
      id: 'g${goals.length + 1}',
      profileId: 'u1',
      title: title,
      icon: icon,
      target: target,
      saved: 0,
      createdAt: DateTime.utc(2026, 7, 12),
    );
    goals.add(goal);
    return Ok(goal);
  }

  @override
  Future<Result<Goal>> updateGoal(
    String id, {
    String? title,
    String? icon,
    int? target,
  }) async {
    final index = goals.indexWhere((g) => g.id == id);
    final old = goals[index];
    final updated = Goal(
      id: old.id,
      profileId: old.profileId,
      title: title ?? old.title,
      icon: icon ?? old.icon,
      target: target ?? old.target,
      saved: old.saved,
      createdAt: old.createdAt,
    );
    goals[index] = updated;
    return Ok(updated);
  }

  @override
  Future<Result<void>> deleteGoal(String id) async {
    deletedId = id;
    goals.removeWhere((g) => g.id == id);
    return const Ok(null);
  }
}

class FakeInvestmentRepository extends InvestmentRepository {
  FakeInvestmentRepository({this.investments = const []}) : super(null);

  final List<Investment> investments;

  @override
  Future<Result<List<Investment>>> myInvestments() async => Ok(investments);
}

Investment _investment(String campaignId, int amount) => Investment(
  id: 'i-$campaignId',
  profileId: 'u1',
  campaignId: campaignId,
  amount: amount,
  riskAck1: true,
  riskAck2: true,
  source: 'wallet',
  createdAt: DateTime.utc(2026, 7, 10),
);

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

AutoInvestQueueItem pendingItem(String id) => AutoInvestQueueItem(
  id: id,
  ruleId: 'r1',
  campaignId: 'c1',
  status: QueueStatus.pending,
  createdAt: DateTime.utc(2026, 7, 12),
);

Future<void> pumpGrow(
  WidgetTester tester, {
  required FakeAutoInvestRepository autoInvest,
  FakeGoalRepository? goals,
  FakeCampaignRepository? campaigns,
  FakeInvestmentRepository? investments,
}) async {
  tester.view.physicalSize = const Size(800, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        autoInvestRepositoryProvider.overrideWithValue(autoInvest),
        campaignRepositoryProvider.overrideWithValue(
          campaigns ?? FakeCampaignRepository(),
        ),
        goalRepositoryProvider.overrideWithValue(goals ?? FakeGoalRepository()),
        investmentRepositoryProvider.overrideWithValue(
          investments ?? FakeInvestmentRepository(),
        ),
        walletRepositoryProvider.overrideWithValue(FakeWalletRepository()),
      ],
      child: MaterialApp(
        theme: RibhTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const GrowScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('strategy setup: pick, budget, save writes the rule', (
    tester,
  ) async {
    final autoInvest = FakeAutoInvestRepository();
    await pumpGrow(tester, autoInvest: autoInvest);

    expect(
      find.text('Off. Pick a strategy; you approve every deployment.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Auto-invest strategy'));
    await tester.pumpAndSettle();
    await tester.tap(
      find.text('The widest spread of contracts, including elevated risk.'),
    );
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), '25000');
    await tester.tap(find.text('Save strategy'));
    await tester.pumpAndSettle();

    expect(autoInvest.savedStrategy, 'diversified');
    expect(autoInvest.savedBudget, 2500000);
    expect(autoInvest.savedActive, isTrue);
    expect(find.textContaining('per deployment'), findsOneWidget);
  });

  testWidgets('approval queue: approve needs both acks, then deploys through '
      'the repository', (tester) async {
    final autoInvest = FakeAutoInvestRepository(
      rule: rule(),
      queue: [pendingItem('q1')],
    );
    await pumpGrow(tester, autoInvest: autoInvest);

    expect(find.text('Printing Zone'), findsOneWidget);
    expect(find.text('Proposes deploying ৳50,000'), findsOneWidget);

    await tester.tap(find.text('Approve and deploy'));
    await tester.pumpAndSettle();

    // .last: the queue card's button also carries this label.
    final approveButton = find
        .widgetWithText(FilledButton, 'Approve and deploy')
        .last;
    expect(tester.widget<FilledButton>(approveButton).onPressed, isNull);

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.tap(find.byType(CheckboxListTile).last);
    await tester.pumpAndSettle();
    await tester.tap(approveButton);
    await tester.pumpAndSettle();

    expect(autoInvest.approvedItemId, 'q1');
    expect(autoInvest.approvedAck1, isTrue);
    expect(autoInvest.approvedAck2, isTrue);
    expect(find.text('Investment committed'), findsOneWidget);
  });

  testWidgets('approval failure: insufficient balance stays in the sheet', (
    tester,
  ) async {
    final autoInvest = FakeAutoInvestRepository(
      rule: rule(),
      queue: [pendingItem('q1')],
      approveResult: const Err(InsufficientFundsFailure()),
    );
    await pumpGrow(tester, autoInvest: autoInvest);

    await tester.tap(find.text('Approve and deploy'));
    await tester.pumpAndSettle();
    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.tap(find.byType(CheckboxListTile).last);
    await tester.pumpAndSettle();
    await tester.tap(
      find.widgetWithText(FilledButton, 'Approve and deploy').last,
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Your available balance is not enough for this amount.'),
      findsOneWidget,
    );
    expect(find.text('Investment committed'), findsNothing);
  });

  testWidgets('declining removes the proposal and moves no money', (
    tester,
  ) async {
    final autoInvest = FakeAutoInvestRepository(
      rule: rule(),
      queue: [pendingItem('q1')],
    );
    await pumpGrow(tester, autoInvest: autoInvest);

    await tester.tap(find.text('Decline'));
    await tester.pumpAndSettle();

    expect(autoInvest.declined, ['q1']);
    expect(find.textContaining('No proposals waiting'), findsOneWidget);
  });

  testWidgets('goals: create, edit, delete write through the repository', (
    tester,
  ) async {
    final goalsRepo = FakeGoalRepository();
    final autoInvest = FakeAutoInvestRepository();
    await pumpGrow(tester, autoInvest: autoInvest, goals: goalsRepo);

    // Create.
    await tester.tap(find.text('Add goal'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Goal name'),
      'Hajj fund',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Target amount in taka'),
      '500000',
    );
    await tester.tap(find.text('Hajj'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save goal'));
    await tester.pumpAndSettle();

    expect(goalsRepo.goals.single.title, 'Hajj fund');
    expect(goalsRepo.goals.single.target, 50000000);
    expect(goalsRepo.goals.single.icon, 'hajj');
    expect(find.text('Hajj fund'), findsOneWidget);

    // Edit.
    await tester.tap(find.text('Hajj fund'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Goal name'),
      'Hajj 2030',
    );
    await tester.tap(find.text('Save goal'));
    await tester.pumpAndSettle();
    expect(goalsRepo.goals.single.title, 'Hajj 2030');
    expect(find.text('Hajj 2030'), findsOneWidget);

    // Delete.
    await tester.tap(find.text('Hajj 2030'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete goal'));
    await tester.pumpAndSettle();
    expect(goalsRepo.deletedId, 'g1');
    expect(find.textContaining('No goals yet'), findsOneWidget);
  });

  testWidgets('Ribh Fund shows the empty state with no deployments', (
    tester,
  ) async {
    await pumpGrow(tester, autoInvest: FakeAutoInvestRepository());

    expect(find.text('Ribh Fund'), findsOneWidget);
    expect(
      find.textContaining('No active deployments yet'),
      findsOneWidget,
    );
  });

  testWidgets('Ribh Fund shows deployed, spread, blended rate, and sectors', (
    tester,
  ) async {
    final campaigns = [
      _openCampaign, // printing, open, rate 17.4%
      Campaign(
        id: 'c2',
        title: 'Machinery Purchase',
        contract: 'murabaha',
        sector: 'machinery',
        pool: 800000000,
        raised: 800000000,
        profitPerLac: 1600000,
        share: 60,
        tenure: 9, // running, rate 12.8%
        risk: 'moderate',
        status: CampaignStatus.running,
        createdAt: DateTime.utc(2026, 6, 1),
      ),
    ];
    await pumpGrow(
      tester,
      autoInvest: FakeAutoInvestRepository(),
      campaigns: FakeCampaignRepository(campaigns: campaigns),
      investments: FakeInvestmentRepository(
        investments: [
          _investment('c1', 10000000), // 100,000 taka, printing
          _investment('c2', 30000000), // 300,000 taka, machinery
        ],
      ),
    );

    // Deployed total (100,000 + 300,000), western grouping in en.
    expect(find.text('৳400,000'), findsOneWidget);
    // 2 deployments across 2 sectors.
    expect(find.text('2 deployments across 2 sectors'), findsOneWidget);
    // Amount-weighted blended rate is shown with its projected disclosure.
    expect(find.text('Blended rate'), findsOneWidget);
    expect(find.textContaining('p.a. projected'), findsOneWidget);
    expect(find.textContaining('Projected, not guaranteed'), findsOneWidget);
    // Sector rows, largest first: machinery 75%, printing 25%.
    expect(find.text('Machinery · 75%'), findsOneWidget);
    expect(find.text('Printing · 25%'), findsOneWidget);
  });

  testWidgets('capture: grow', (tester) async {
    final running = Campaign(
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
    );
    final goals = FakeGoalRepository();
    goals.goals.add(
      Goal(
        id: 'g1',
        profileId: 'u1',
        title: 'Hajj fund',
        icon: 'hajj',
        target: 50000000,
        saved: 12500000,
        createdAt: DateTime.utc(2026, 7, 1),
      ),
    );
    await pumpGrow(
      tester,
      autoInvest: FakeAutoInvestRepository(rule: rule(), queue: [pendingItem('q1')]),
      campaigns: FakeCampaignRepository(campaigns: [_openCampaign, running]),
      investments: FakeInvestmentRepository(
        investments: [
          _investment('c1', 10000000),
          _investment('c2', 30000000),
        ],
      ),
      goals: goals,
    );
    await expectLater(
      find.byType(GrowScreen),
      matchesGoldenFile('captures/grow.png'),
    );
  });
}
