import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:ribh/app/l10n/app_localizations.dart';
import 'package:ribh/app/router/router.dart';
import 'package:ribh/app/theme/ribh_theme.dart';
import 'package:ribh/core/failures/failure.dart';
import 'package:ribh/core/result/result.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/data/repositories/campaign_repository.dart';
import 'package:ribh/data/repositories/goal_repository.dart';
import 'package:ribh/data/repositories/investment_repository.dart';
import 'package:ribh/data/repositories/news_repository.dart';
import 'package:ribh/data/repositories/providers.dart';
import 'package:ribh/data/repositories/wallet_repository.dart';
import 'package:ribh/data/prayer/prayer_service.dart';
import 'package:ribh/data/repositories/welfare_repository.dart';
import 'package:ribh/features/home/home_screen.dart';
import 'package:ribh/shared/barakah_banner.dart';
import 'package:ribh/shared/money_flow.dart';
import 'package:ribh/shared/service_tile.dart';

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

Investment _investment(String id, String campaignId, int amount) => Investment(
  id: id,
  profileId: 'u1',
  campaignId: campaignId,
  amount: amount,
  riskAck1: true,
  riskAck2: true,
  source: 'wallet',
  createdAt: DateTime.utc(2026, 7, 10),
);

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
  FakeInvestmentRepository({this.investments = const []}) : super(null);

  final List<Investment> investments;

  @override
  Future<Result<List<Investment>>> myInvestments() async => Ok(investments);
}

class FakeWalletRepository extends WalletRepository {
  FakeWalletRepository({this.balance = 12840000, this.balanceFailure})
    : super(null);

  int balance;
  Failure? balanceFailure;

  @override
  Future<Result<int>> myBalance() async =>
      balanceFailure == null ? Ok(balance) : Err(balanceFailure!);

  @override
  Future<Result<List<WalletTransaction>>> myTransactions({
    int limit = 50,
    DateTime? before,
  }) async => const Ok([]);

  @override
  Future<Result<List<MoneyRequest>>> myMoneyRequests({int limit = 20}) async =>
      const Ok([]);
}

class FakeGoalRepository extends GoalRepository {
  FakeGoalRepository({this.goals = const []}) : super(null);

  final List<Goal> goals;

  @override
  Future<Result<List<Goal>>> myGoals() async => Ok(goals);
}

class FakeNewsRepository extends NewsRepository {
  FakeNewsRepository({this.items = const []}) : super(null);

  final List<NewsItem> items;

  @override
  Future<Result<List<NewsItem>>> publishedNews({int limit = 10}) async =>
      Ok(items);
}

class FakeZakatRepository extends ZakatRepository {
  FakeZakatRepository() : super(null);

  @override
  Future<Result<List<WelfareProject>>> projects() async => const Ok([]);
}

/// No device location in widget tests: resolve instantly to the honest
/// unavailable state instead of touching platform channels.
class UnavailablePrayerService implements PrayerService {
  const UnavailablePrayerService();

  @override
  Future<Result<PrayerSnapshot>> today() async =>
      const Err(LocationUnavailableFailure());
}

ProviderScope scoped(
  Widget child, {
  FakeWalletRepository? wallet,
  FakeInvestmentRepository? investments,
  FakeGoalRepository? goals,
  FakeNewsRepository? news,
}) => ProviderScope(
  retry: (retryCount, error) => null,
  overrides: [
    campaignRepositoryProvider.overrideWithValue(FakeCampaignRepository()),
    investmentRepositoryProvider.overrideWithValue(
      investments ??
          FakeInvestmentRepository(
            investments: [
              _investment('i1', 'c2', 5000000),
              _investment('i2', 'c4', 3000000),
            ],
          ),
    ),
    walletRepositoryProvider.overrideWithValue(
      wallet ?? FakeWalletRepository(),
    ),
    zakatRepositoryProvider.overrideWithValue(FakeZakatRepository()),
    newsRepositoryProvider.overrideWithValue(news ?? FakeNewsRepository()),
    prayerServiceProvider.overrideWithValue(const UnavailablePrayerService()),
    goalRepositoryProvider.overrideWithValue(
      goals ??
          FakeGoalRepository(
            goals: [
              Goal(
                id: 'g1',
                profileId: 'u1',
                title: 'Hajj fund',
                icon: 'hajj',
                target: 50000000,
                saved: 12500000,
                createdAt: DateTime.utc(2026, 7, 1),
              ),
            ],
          ),
    ),
  ],
  child: child,
);

Future<void> pumpHome(
  WidgetTester tester, {
  FakeWalletRepository? wallet,
  FakeNewsRepository? news,
}) async {
  tester.view.physicalSize = const Size(800, 3200);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(
    scoped(
      MaterialApp(
        theme: RibhTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeScreen(),
      ),
      wallet: wallet,
      news: news,
    ),
  );
  await tester.pumpAndSettle();
}

NewsItem _news(String id, String category, String title) => NewsItem(
  id: id,
  category: category,
  title: title,
  published: true,
  createdAt: DateTime.utc(2026, 7, 20),
);

/// Disposes the tree so the banner's periodic timer is cancelled before the
/// test ends.
Future<void> teardownTree(WidgetTester tester) =>
    tester.pumpWidget(const SizedBox());

void main() {
  test('moneyFlowStageFor maps status to stages, never inventing more', () {
    expect(moneyFlowStageFor(CampaignStatus.open), 1);
    expect(moneyFlowStageFor(CampaignStatus.running), 3);
    expect(moneyFlowStageFor(CampaignStatus.inRecovery), 3);
    expect(moneyFlowStageFor(CampaignStatus.matured), 5);
  });

  testWidgets('home hub: amanah figures derived, open campaigns, '
      'where\'s-my-money, goals, services grid, disclaimer', (tester) async {
    await pumpHome(tester);

    // Amanah: available from the balance RPC, deployed and in-recovery
    // summed from holdings by campaign status.
    expect(find.text('৳128,400'), findsOneWidget);
    expect(find.text('Deployed'), findsOneWidget);
    expect(find.text('৳50,000'), findsWidgets); // deployed sum (c2 running)
    expect(find.text('৳30,000'), findsWidgets); // in recovery (c4)

    // Open campaigns: only the open one, with its projected rate label.
    expect(find.text('Open campaigns'), findsOneWidget);
    expect(find.text('Printing Zone'), findsOneWidget);
    expect(find.text('~17.4% p.a. projected'), findsOneWidget);

    // Where's my money: largest running deployment with its stage strip.
    expect(find.text("Where's my money?"), findsOneWidget);
    expect(find.text('৳50,000 · Machinery Purchase'), findsOneWidget);
    expect(find.text('Goods with merchant'), findsOneWidget);

    // Goals, read-only.
    expect(find.text('Hajj fund'), findsOneWidget);
    expect(
      find.text('৳1,25,000 / ৳5,00,000'.replaceAll(',', ',')),
      findsNothing,
    ); // en locale groups western
    expect(find.text('৳125,000 / ৳500,000'), findsOneWidget);

    // Services grid: six tiles, Qard honestly marked SOON. Scoped to the
    // tiles because "Wallet" also appears as a money-flow step label.
    for (final label in [
      'Zakat',
      'Sadaqah',
      'Wallet',
      'Prayer',
      'Qard e Hasanah',
      'Invite',
    ]) {
      expect(
        find.descendant(
          of: find.byType(ServiceTile),
          matching: find.text(label),
        ),
        findsOneWidget,
      );
    }
    expect(find.text('SOON'), findsOneWidget);

    // Risk disclosure footer, since projected rates appear on this screen.
    expect(
      find.textContaining('Capital at risk. Returns are projections'),
      findsOneWidget,
    );

    await teardownTree(tester);
  });

  testWidgets('news and insight: published items render, empty shows honest '
      'message not a stub', (tester) async {
    // Happy path: published items appear under the section header.
    await pumpHome(
      tester,
      news: FakeNewsRepository(
        items: [
          _news('n1', 'New campaign', 'Printing Zone is open'),
          _news('n2', 'Insight', 'Why we show you everything'),
        ],
      ),
    );
    expect(find.text('News and Insight'), findsOneWidget);
    expect(find.text('Printing Zone is open'), findsOneWidget);
    expect(find.text('Why we show you everything'), findsOneWidget);
    await teardownTree(tester);

    // Empty: the honest empty line, never a fabricated card.
    await pumpHome(tester, news: FakeNewsRepository());
    expect(find.text('News and Insight'), findsOneWidget);
    expect(find.textContaining('No news yet'), findsOneWidget);
    await teardownTree(tester);
  });

  testWidgets('amanah failure is a real error state with working retry', (
    tester,
  ) async {
    final wallet = FakeWalletRepository(balanceFailure: const NetworkFailure());
    await pumpHome(tester, wallet: wallet);

    expect(
      find.text('Network unavailable. Check your connection and try again.'),
      findsOneWidget,
    );

    wallet.balanceFailure = null;
    await tester.tap(find.text('Retry').first);
    await tester.pumpAndSettle();
    expect(find.text('৳128,400'), findsOneWidget);

    await teardownTree(tester);
  });

  testWidgets('banner auto-advances every 4.2s and pauses under '
      'reduce-motion', (tester) async {
    const slides = [
      BarakahSlide(icon: LucideIcons.sprout, title: 'One', subtitle: 's1'),
      BarakahSlide(icon: LucideIcons.moon, title: 'Two', subtitle: 's2'),
    ];
    Widget host({required bool reduceMotion}) => MaterialApp(
      theme: RibhTheme.light(),
      home: MediaQuery(
        data: MediaQueryData(disableAnimations: reduceMotion),
        child: const Scaffold(body: BarakahBanner(slides: slides)),
      ),
    );

    // Motion allowed: advances after the interval.
    await tester.pumpWidget(host(reduceMotion: false));
    expect(find.text('One'), findsOneWidget);
    await tester.pump(BarakahBanner.advanceEvery);
    await tester.pump(const Duration(milliseconds: 350));
    expect(find.text('Two'), findsOneWidget);
    await teardownTree(tester);

    // Reduce motion: no timer, still on the first slide much later.
    await tester.pumpWidget(host(reduceMotion: true));
    await tester.pump(const Duration(seconds: 10));
    expect(find.text('One'), findsOneWidget);
    expect(find.text('Two'), findsNothing);
    await teardownTree(tester);
  });

  testWidgets('service tiles navigate to their real routes', (tester) async {
    tester.view.physicalSize = const Size(800, 3200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    late final ProviderContainer container;
    await tester.pumpWidget(
      scoped(
        Consumer(
          builder: (context, ref, _) {
            container = ProviderScope.containerOf(context);
            return MaterialApp.router(
              theme: RibhTheme.light(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              routerConfig: ref.watch(routerProvider),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(container, isNotNull);

    // Zakat is a real page since M7.
    await tester.tap(find.text('Zakat'));
    await tester.pumpAndSettle();
    expect(find.text('Zakat calculator'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Prayer is real since M7 wave 2; without device location in tests it
    // shows its honest unavailable state rather than estimated times.
    await tester.tap(find.text('Prayer'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Location is off or permission was refused'),
      findsOneWidget,
    );

    await teardownTree(tester);
  });
}
