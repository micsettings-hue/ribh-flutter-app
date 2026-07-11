import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/data/models/models.dart';

void main() {
  test('WalletTransaction parses snake_case JSON including write_down', () {
    final tx = WalletTransaction.fromJson(const {
      'id': 'a1',
      'wallet_id': 'w1',
      'kind': 'write_down',
      'amount': 1200,
      'ref_type': 'recovery_case',
      'ref_id': 'r1',
      'signature': null,
      'created_at': '2026-07-11T10:00:00Z',
    });
    expect(tx.kind, TxKind.writeDown);
    expect(tx.amount, 1200);
    expect(tx.signedAmount, -1200);
    expect(tx.toJson()['kind'], 'write_down');
    expect(tx.toJson()['wallet_id'], 'w1');
  });

  test('Campaign parses in_recovery status and numeric share', () {
    final campaign = Campaign.fromJson(const {
      'id': 'c1',
      'business_id': null,
      'contract': 'murabaha',
      'sector': 'printing',
      'pool': 500000000,
      'raised': 210000000,
      'profit_per_lac': 1450000,
      'share': 60.00,
      'tenure': 6,
      'risk': 'moderate',
      'status': 'in_recovery',
      'created_at': '2026-07-01T00:00:00Z',
    });
    expect(campaign.status, CampaignStatus.inRecovery);
    expect(campaign.share, 60.0);
    expect(campaign.fundingPercent, closeTo(42.0, 0.001));
  });

  test('Campaign share parses when PostgREST sends an int', () {
    final campaign = Campaign.fromJson(const {
      'id': 'c2',
      'business_id': null,
      'contract': 'musharakah',
      'sector': 'machinery',
      'pool': 100,
      'raised': 0,
      'profit_per_lac': 10,
      'share': 55,
      'tenure': 12,
      'risk': 'elevated',
      'status': 'open',
      'created_at': '2026-07-01T00:00:00Z',
    });
    expect(campaign.share, 55.0);
  });

  test('Investment round-trips', () {
    final investment = Investment.fromJson(const {
      'id': 'i1',
      'profile_id': 'p1',
      'campaign_id': 'c1',
      'amount': 40000,
      'risk_ack_1': true,
      'risk_ack_2': true,
      'source': 'wallet',
      'created_at': '2026-07-11T10:00:00Z',
    });
    expect(investment.riskAck1 && investment.riskAck2, isTrue);
    expect(investment.toJson()['risk_ack_1'], true);
    expect(investment.toJson()['campaign_id'], 'c1');
  });

  test('Engagement parses jsonb maps', () {
    final engagement = Engagement.fromJson(const {
      'profile_id': 'p1',
      'adhkar_counts': {'morning': 33},
      'habit_days': {'2026-07-10': true},
      'prayer_streak': 4,
      'score': 62,
      'updated_at': '2026-07-11T10:00:00Z',
    });
    expect(engagement.adhkarCounts['morning'], 33);
    expect(engagement.prayerStreak, 4);
  });
}
