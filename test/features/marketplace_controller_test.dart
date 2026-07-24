import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/features/invest/marketplace_controller.dart';

Campaign _c(
  String id, {
  required CampaignStatus status,
  required DateTime createdAt,
  String title = '',
  String sector = 'printing',
  String contract = 'murabaha',
}) => Campaign(
  id: id,
  title: title,
  contract: contract,
  sector: sector,
  pool: 100000000,
  raised: 50000000,
  profitPerLac: 1450000,
  share: 60,
  tenure: 6,
  risk: 'moderate',
  status: status,
  createdAt: createdAt,
);

void main() {
  // Deliberately not in status order, and created_at does not match status
  // order, so a passing test proves the sort, not the input order.
  final campaigns = [
    _c('m1', status: CampaignStatus.matured, createdAt: DateTime.utc(2026, 7, 20)),
    _c('o1', status: CampaignStatus.open, createdAt: DateTime.utc(2026, 7, 1)),
    _c('r1', status: CampaignStatus.inRecovery, createdAt: DateTime.utc(2026, 7, 18)),
    _c('o2', status: CampaignStatus.open, createdAt: DateTime.utc(2026, 7, 15)),
    _c('run1', status: CampaignStatus.running, createdAt: DateTime.utc(2026, 7, 5)),
  ];

  MarketplaceData data({Set<String> saved = const {}}) =>
      MarketplaceData(campaigns: campaigns, savedIds: saved);

  test('All: open leads, then running, matured, recovery; newest within group', () {
    final ids = data()
        .visible(MarketFilter.all, '')
        .map((c) => c.id)
        .toList();
    expect(ids, ['o2', 'o1', 'run1', 'm1', 'r1']);
  });

  test('Open filter returns only open campaigns, newest first', () {
    final ids = data()
        .visible(MarketFilter.open, '')
        .map((c) => c.id)
        .toList();
    expect(ids, ['o2', 'o1']);
  });

  test('Matured filter returns only matured', () {
    final ids = data()
        .visible(MarketFilter.matured, '')
        .map((c) => c.id)
        .toList();
    expect(ids, ['m1']);
  });

  test('Saved filter returns only the watchlist, still status-ordered', () {
    final ids = data(saved: {'m1', 'o1'})
        .visible(MarketFilter.saved, '')
        .map((c) => c.id)
        .toList();
    expect(ids, ['o1', 'm1']);
  });

  test('search matches title, sector, and contract, case-insensitively', () {
    final tagged = [
      _c('a', status: CampaignStatus.open, createdAt: DateTime.utc(2026, 7, 1), title: 'Printing Zone'),
      _c('b', status: CampaignStatus.open, createdAt: DateTime.utc(2026, 7, 2), sector: 'machinery'),
      _c('c', status: CampaignStatus.open, createdAt: DateTime.utc(2026, 7, 3), contract: 'musharakah'),
    ];
    final d = MarketplaceData(campaigns: tagged, savedIds: const {});
    expect(d.visible(MarketFilter.all, 'ZONE').map((c) => c.id), ['a']);
    expect(d.visible(MarketFilter.all, 'machin').map((c) => c.id), ['b']);
    expect(d.visible(MarketFilter.all, 'MUSHARAKAH').map((c) => c.id), ['c']);
  });
}
