import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
import 'package:ribh/data/repositories/engagement_repository.dart';
import 'package:ribh/data/repositories/investment_repository.dart';
import 'package:ribh/data/repositories/learn_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/data/repositories/qard_repository.dart';
import 'package:ribh/data/repositories/referral_repository.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:ribh/data/repositories/welfare_repository.dart';
import 'package:ribh/features/services/invite_screen.dart';
import 'package:ribh/features/services/learn_screen.dart';
import 'package:ribh/features/services/qard_screen.dart';
import 'package:ribh/features/services/sadaqah_screen.dart';
import 'package:ribh/features/services/zakat_screen.dart';

final _projects = [
  WelfareProject(
    id: 'p1',
    sector: 'water',
    title: 'Tube wells for char villages',
    district: 'Kurigram',
    target: 120000000,
    raised: 45000000,
    createdAt: DateTime.utc(2026, 6, 1),
  ),
];

class FakeLearnRepository extends LearnRepository {
  FakeLearnRepository() : super(null);

  final progress = <String, LessonProgress>{};

  @override
  Future<Result<List<Lesson>>> lessons() async => Ok([
    Lesson(
      id: 'l1',
      slug: 'halal-investing-basics',
      title: 'Halal investing basics (pending Shariah review)',
      sort: 1,
      createdAt: DateTime.utc(2026, 6, 1),
    ),
    Lesson(
      id: 'l2',
      slug: 'understanding-risk',
      title: 'Understanding risk',
      sort: 2,
      createdAt: DateTime.utc(2026, 6, 1),
    ),
  ]);

  @override
  Future<Result<Map<String, LessonProgress>>> myProgress() async =>
      Ok(Map.of(progress));

  @override
  Future<Result<LessonProgress>> markRead(String moduleId) async {
    final existing = progress[moduleId];
    final updated = LessonProgress(
      id: 'pr-$moduleId',
      profileId: 'u1',
      moduleId: moduleId,
      readCount: (existing?.readCount ?? 0) + 1,
      completed: true,
      createdAt: DateTime.utc(2026, 7, 12),
    );
    progress[moduleId] = updated;
    return Ok(updated);
  }
}

class FakeZakatRepository extends ZakatRepository {
  FakeZakatRepository({this.giveResult}) : super(null);

  final Result<String>? giveResult;
  String? gaveProjectId;
  int? gaveAmount;

  @override
  Future<Result<List<WelfareProject>>> projects() async => Ok(_projects);

  @override
  Future<Result<String>> give({
    required String projectId,
    required int amount,
  }) async {
    if (giveResult case final result?) return result;
    gaveProjectId = projectId;
    gaveAmount = amount;
    return const Ok('wc-1');
  }

  @override
  Future<Result<List<WelfareContribution>>> myContributions() async =>
      const Ok([]);
}

class FakeSadaqahRepository extends SadaqahRepository {
  FakeSadaqahRepository() : super(null);

  int? gaveAmount;

  @override
  Future<Result<List<WelfareProject>>> projects() async => Ok(_projects);

  @override
  Future<Result<String>> give({
    required String projectId,
    required int amount,
  }) async {
    gaveAmount = amount;
    return const Ok('wc-2');
  }

  @override
  Future<Result<List<WelfareContribution>>> myContributions() async => Ok([
    WelfareContribution(
      id: 'c1',
      profileId: 'u1',
      projectId: 'p1',
      kind: WelfareKind.sadaqah,
      amount: 46000,
      createdAt: DateTime.now(),
    ),
    WelfareContribution(
      id: 'c2',
      profileId: 'u1',
      projectId: 'p1',
      kind: WelfareKind.sadaqah,
      amount: 1208000,
      createdAt: DateTime.utc(2025, 1, 5),
    ),
  ]);

  @override
  Future<Result<List<Tree>>> myTrees() async => Ok([
    Tree(
      id: 't1',
      profileId: 'u1',
      source: TreeSource.sadaqah,
      district: 'Satkhira',
      plantedAt: DateTime.utc(2026, 5, 1),
      createdAt: DateTime.utc(2026, 4, 1),
    ),
    Tree(
      id: 't2',
      profileId: 'u1',
      source: TreeSource.referral,
      createdAt: DateTime.utc(2026, 7, 1),
    ),
  ]);
}

class FakeEngagementRepository extends EngagementRepository {
  FakeEngagementRepository() : super(null);

  Map<String, dynamic> habitDays = {};

  @override
  Future<Result<Engagement>> myEngagement() async => Ok(
    Engagement(
      profileId: 'u1',
      adhkarCounts: const {},
      habitDays: habitDays,
      prayerStreak: 0,
      score: 0,
      updatedAt: DateTime.utc(2026, 7, 12),
    ),
  );

  @override
  Future<Result<Engagement>> saveEngagement({
    Map<String, dynamic>? adhkarCounts,
    Map<String, dynamic>? habitDays,
    int? prayerStreak,
    int? score,
  }) async {
    if (habitDays != null) this.habitDays = habitDays;
    return myEngagement().then((r) => r);
  }
}

class FakeQardRepository extends QardRepository {
  FakeQardRepository() : super(null);

  bool registered = false;

  @override
  Future<Result<bool>> hasRegisteredInterest() async => Ok(registered);

  @override
  Future<Result<void>> registerInterest() async {
    registered = true;
    return const Ok(null);
  }
}

class FakeReferralRepository extends ReferralRepository {
  FakeReferralRepository({this.referrals = const []}) : super(null);

  final List<Referral> referrals;
  int redeemCalls = 0;

  @override
  Future<Result<String>> myReferralCode() async => const Ok('ab12cd34');

  @override
  Future<Result<List<Referral>>> myReferrals() async => Ok(referrals);

  @override
  Future<Result<List<Tree>>> myTrees() async => const Ok([]);

  @override
  Future<Result<String>> redeemTree() async {
    redeemCalls++;
    return const Ok('t-new');
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

class FakeInvestmentRepository extends InvestmentRepository {
  FakeInvestmentRepository() : super(null);

  @override
  Future<Result<List<Investment>>> myInvestments() async => const Ok([]);
}

class FakeCampaignRepository extends CampaignRepository {
  FakeCampaignRepository() : super(null);

  @override
  Future<Result<List<Campaign>>> campaigns({CampaignStatus? status}) async =>
      const Ok([]);

  @override
  Future<Result<Set<String>>> myWatchlist() async => const Ok({});
}

Future<void> pumpService(
  WidgetTester tester,
  Widget screen, {
  FakeLearnRepository? learn,
  FakeZakatRepository? zakat,
  FakeSadaqahRepository? sadaqah,
  FakeQardRepository? qard,
  FakeReferralRepository? referral,
}) async {
  tester.view.physicalSize = const Size(800, 2800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    ProviderScope(
      retry: (retryCount, error) => null,
      overrides: [
        learnRepositoryProvider.overrideWithValue(
          learn ?? FakeLearnRepository(),
        ),
        zakatRepositoryProvider.overrideWithValue(
          zakat ?? FakeZakatRepository(),
        ),
        sadaqahRepositoryProvider.overrideWithValue(
          sadaqah ?? FakeSadaqahRepository(),
        ),
        engagementRepositoryProvider.overrideWithValue(
          FakeEngagementRepository(),
        ),
        qardRepositoryProvider.overrideWithValue(qard ?? FakeQardRepository()),
        referralRepositoryProvider.overrideWithValue(
          referral ?? FakeReferralRepository(),
        ),
        walletRepositoryProvider.overrideWithValue(FakeWalletRepository()),
        investmentRepositoryProvider.overrideWithValue(
          FakeInvestmentRepository(),
        ),
        campaignRepositoryProvider.overrideWithValue(FakeCampaignRepository()),
      ],
      child: MaterialApp(
        theme: RibhTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: screen,
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> teardownTree(WidgetTester tester) =>
    tester.pumpWidget(const SizedBox());

void main() {
  testWidgets('Learn: modules render and marking read persists progress', (
    tester,
  ) async {
    final learn = FakeLearnRepository();
    await pumpService(tester, const LearnScreen(), learn: learn);

    expect(find.text('0 of 2 modules completed'), findsOneWidget);
    await tester.tap(find.text('Understanding risk'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Mark as read'));
    await tester.pumpAndSettle();

    expect(learn.progress['l2']!.completed, isTrue);
    expect(find.text('1 of 2 modules completed'), findsOneWidget);
    expect(find.textContaining('Read 1 times'), findsOneWidget);
  });

  testWidgets('Zakat: live calculator math and the honest Nisab-unavailable '
      'state', (tester) async {
    await pumpService(tester, const ZakatScreen());

    // 100,000 + 20,000 + 30,000 - 10,000 = 140,000 taka; due 3,500.
    await tester.enterText(
      find.widgetWithText(TextField, 'Cash and bank balances'),
      '100000',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Gold value'),
      '20000',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Business assets'),
      '30000',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Debts to deduct'),
      '10000',
    );
    await tester.pumpAndSettle();

    expect(find.text('Zakatable wealth: ৳140,000'), findsOneWidget);
    expect(find.text('Zakat due at 2.5%: ৳3,500'), findsOneWidget);
    // No silver price source connected: unavailable, never estimated.
    expect(
      find.textContaining('silver price source is not connected'),
      findsOneWidget,
    );

    await teardownTree(tester);
  });

  testWidgets('Zakat give: full-amount contribution through the RPC path', (
    tester,
  ) async {
    final zakat = FakeZakatRepository();
    await pumpService(tester, const ZakatScreen(), zakat: zakat);

    await tester.tap(find.text('Give Zakat'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Amount in taka'),
      '3500',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Give Zakat').last);
    await tester.pumpAndSettle();

    expect(zakat.gaveProjectId, 'p1');
    expect(zakat.gaveAmount, 350000);
    expect(find.text('Given'), findsOneWidget);

    await teardownTree(tester);
  });

  testWidgets('Zakat give failure: insufficient balance is a real error', (
    tester,
  ) async {
    final zakat = FakeZakatRepository(
      giveResult: const Err(InsufficientFundsFailure()),
    );
    await pumpService(tester, const ZakatScreen(), zakat: zakat);

    await tester.tap(find.text('Give Zakat'));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.widgetWithText(TextField, 'Amount in taka'),
      '999999',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Give Zakat').last);
    await tester.pumpAndSettle();

    expect(
      find.text('Your available balance is not enough for this amount.'),
      findsOneWidget,
    );

    await teardownTree(tester);
  });

  testWidgets('Sadaqah: real tracker totals, habit grid, forest with pledged '
      'and planted trees', (tester) async {
    await pumpService(tester, const SadaqahScreen());

    expect(find.text('This month: ৳460'), findsOneWidget);
    expect(find.text('Lifetime: ৳12,540'), findsOneWidget);
    expect(find.text('0 of 30 days'), findsOneWidget);
    expect(find.text('2 trees'), findsOneWidget);
  });

  testWidgets('Sadaqah quick give: preset amount reaches the repository', (
    tester,
  ) async {
    final sadaqah = FakeSadaqahRepository();
    await pumpService(tester, const SadaqahScreen(), sadaqah: sadaqah);

    await tester.tap(find.widgetWithText(OutlinedButton, '৳50'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Give Sadaqah').last);
    await tester.pumpAndSettle();

    expect(sadaqah.gaveAmount, 5000);
    expect(find.text('Given'), findsOneWidget);
  });

  testWidgets('Qard: honest coming soon plus a notify-me that records', (
    tester,
  ) async {
    final qard = FakeQardRepository();
    await pumpService(tester, const QardScreen(), qard: qard);

    expect(
      find.text('Honestly not open yet. No lending exists in this version.'),
      findsOneWidget,
    );
    await tester.tap(find.text('Notify me when it opens'));
    await tester.pumpAndSettle();

    expect(qard.registered, isTrue);
    expect(
      find.text('You are on the list. We will tell you when Qard opens.'),
      findsOneWidget,
    );
  });

  testWidgets('Invite: link, points math, redemption gated on points', (
    tester,
  ) async {
    Referral referral(String id, ReferralStatus status) => Referral(
      id: id,
      referrerId: 'u1',
      inviteeId: 'other-$id',
      status: status,
      createdAt: DateTime.utc(2026, 7, 1),
    );

    // 1 verified + 1 joined = 60 points: one tree redeemable.
    final repo = FakeReferralRepository(
      referrals: [
        referral('r1', ReferralStatus.verified),
        referral('r2', ReferralStatus.joined),
      ],
    );
    await pumpService(tester, const InviteScreen(), referral: repo);

    expect(find.text('https://ribh.app/r/ab12cd34'), findsOneWidget);
    expect(find.text('60 points · 1 joined, 1 verified'), findsOneWidget);

    await tester.tap(find.text('Plant a tree (50 points)'));
    await tester.pumpAndSettle();
    expect(repo.redeemCalls, 1);
  });

  testWidgets('Invite: redemption disabled without enough points', (
    tester,
  ) async {
    final repo = FakeReferralRepository(
      referrals: [
        Referral(
          id: 'r1',
          referrerId: 'u1',
          inviteeId: 'o1',
          status: ReferralStatus.joined,
          createdAt: DateTime.utc(2026, 7, 1),
        ),
      ],
    );
    await pumpService(tester, const InviteScreen(), referral: repo);

    final button = find.widgetWithText(
      FilledButton,
      'Plant a tree (50 points)',
    );
    expect(tester.widget<FilledButton>(button).onPressed, isNull);
  });

  testWidgets('capture: learn', (tester) async {
    await pumpService(tester, const LearnScreen());
    await expectLater(
      find.byType(LearnScreen),
      matchesGoldenFile('captures/learn.png'),
    );
  });

  testWidgets('capture: zakat', (tester) async {
    await pumpService(tester, const ZakatScreen());
    await expectLater(
      find.byType(ZakatScreen),
      matchesGoldenFile('captures/zakat.png'),
    );
  });

  testWidgets('capture: sadaqah', (tester) async {
    await pumpService(tester, const SadaqahScreen());
    await expectLater(
      find.byType(SadaqahScreen),
      matchesGoldenFile('captures/sadaqah.png'),
    );
  });

  testWidgets('capture: qard', (tester) async {
    await pumpService(tester, const QardScreen());
    await expectLater(
      find.byType(QardScreen),
      matchesGoldenFile('captures/qard.png'),
    );
  });

  testWidgets('capture: invite', (tester) async {
    await pumpService(tester, const InviteScreen());
    await expectLater(
      find.byType(InviteScreen),
      matchesGoldenFile('captures/invite.png'),
    );
  });
}
