import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/features/grow/ribh_fund_controller.dart';
import 'package:ribh/features/home/portfolio_controller.dart';

Campaign _campaign(
  String id, {
  required String sector,
  required CampaignStatus status,
  required int profitPerLac,
  required double share,
  required int tenure,
}) => Campaign(
  id: id,
  title: id,
  contract: 'murabaha',
  sector: sector,
  pool: 1000000000,
  raised: 500000000,
  profitPerLac: profitPerLac,
  share: share,
  tenure: tenure,
  risk: 'moderate',
  status: status,
  createdAt: DateTime.utc(2026, 7, 1),
);

PortfolioHolding _holding(Campaign campaign, int amountPoisha) =>
    PortfolioHolding(
      investment: Investment(
        id: 'i-${campaign.id}',
        profileId: 'u1',
        campaignId: campaign.id,
        amount: amountPoisha,
        riskAck1: true,
        riskAck2: true,
        source: 'wallet',
        createdAt: DateTime.utc(2026, 7, 10),
      ),
      campaign: campaign,
    );

void main() {
  test('empty holdings summarise to an empty fund', () {
    final fund = RibhFundSummary.fromHoldings(const []);
    expect(fund.isEmpty, isTrue);
    expect(fund.deployed, 0);
    expect(fund.inRecovery, 0);
    expect(fund.deploymentCount, 0);
    expect(fund.sectorCount, 0);
    expect(fund.sectors, isEmpty);
    expect(fund.blendedProjectedRate, isNull);
  });

  test('deployed excludes recovery; in-recovery sums separately', () {
    final holdings = [
      _holding(
        _campaign('open', sector: 'printing', status: CampaignStatus.open,
            profitPerLac: 1450000, share: 60, tenure: 6),
        10000000, // 100,000 taka
      ),
      _holding(
        _campaign('run', sector: 'machinery', status: CampaignStatus.running,
            profitPerLac: 1600000, share: 60, tenure: 9),
        30000000, // 300,000 taka
      ),
      _holding(
        _campaign('mat', sector: 'construction', status: CampaignStatus.matured,
            profitPerLac: 1500000, share: 60, tenure: 12),
        20000000, // 200,000 taka
      ),
      _holding(
        _campaign('rec', sector: 'cement', status: CampaignStatus.inRecovery,
            profitPerLac: 1500000, share: 60, tenure: 12),
        5000000, // 50,000 taka
      ),
    ];
    final fund = RibhFundSummary.fromHoldings(holdings);

    expect(fund.isEmpty, isFalse);
    expect(fund.deployed, 60000000); // open + running + matured
    expect(fund.inRecovery, 5000000);
    expect(fund.deploymentCount, 3);
    expect(fund.sectorCount, 3);
  });

  test('sectors are shares of deployed capital, largest first', () {
    final holdings = [
      _holding(
        _campaign('open', sector: 'printing', status: CampaignStatus.open,
            profitPerLac: 1450000, share: 60, tenure: 6),
        10000000,
      ),
      _holding(
        _campaign('run', sector: 'machinery', status: CampaignStatus.running,
            profitPerLac: 1600000, share: 60, tenure: 9),
        30000000,
      ),
      _holding(
        _campaign('mat', sector: 'construction', status: CampaignStatus.matured,
            profitPerLac: 1500000, share: 60, tenure: 12),
        20000000,
      ),
    ];
    final fund = RibhFundSummary.fromHoldings(holdings);

    expect(fund.sectors.map((s) => s.sector).toList(),
        ['machinery', 'construction', 'printing']);
    expect(fund.sectors[0].share, closeTo(0.5, 1e-9)); // 30M / 60M
    expect(fund.sectors[1].share, closeTo(1 / 3, 1e-9)); // 20M / 60M
    expect(fund.sectors[2].share, closeTo(1 / 6, 1e-9)); // 10M / 60M
  });

  test('blended rate is amount-weighted over earning holdings only', () {
    final holdings = [
      // open, rate 17.4%, weight 10M
      _holding(
        _campaign('open', sector: 'printing', status: CampaignStatus.open,
            profitPerLac: 1450000, share: 60, tenure: 6),
        10000000,
      ),
      // running, rate 12.8%, weight 30M
      _holding(
        _campaign('run', sector: 'machinery', status: CampaignStatus.running,
            profitPerLac: 1600000, share: 60, tenure: 9),
        30000000,
      ),
      // matured: NOT earning, excluded from the blend
      _holding(
        _campaign('mat', sector: 'construction', status: CampaignStatus.matured,
            profitPerLac: 9999999, share: 60, tenure: 12),
        20000000,
      ),
      // recovery: excluded entirely
      _holding(
        _campaign('rec', sector: 'cement', status: CampaignStatus.inRecovery,
            profitPerLac: 9999999, share: 60, tenure: 12),
        5000000,
      ),
    ];
    final fund = RibhFundSummary.fromHoldings(holdings);

    // (10M*17.4 + 30M*12.8) / 40M = 13.95
    expect(fund.blendedProjectedRate, closeTo(13.95, 1e-6));
  });

  test('blended rate is null when nothing is still earning', () {
    final holdings = [
      _holding(
        _campaign('mat', sector: 'construction', status: CampaignStatus.matured,
            profitPerLac: 1500000, share: 60, tenure: 12),
        20000000,
      ),
    ];
    final fund = RibhFundSummary.fromHoldings(holdings);
    expect(fund.blendedProjectedRate, isNull);
    expect(fund.deployed, 20000000); // matured still counts as deployed capital
  });
}
