import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/core/constants/referral_points.dart';
import 'package:ribh/core/constants/zakat_math.dart';
import 'package:ribh/data/models/models.dart';
import 'package:ribh/features/wallet/performance.dart';

void main() {
  group('referral points (mirrors redeem_referral_tree)', () {
    test('joined 10, verified 50, tree costs 50', () {
      expect(referralPoints(joined: 0, verified: 0), 0);
      expect(referralPoints(joined: 3, verified: 0), 30);
      expect(referralPoints(joined: 0, verified: 1), 50);
      expect(referralPoints(joined: 2, verified: 3), 170);
    });

    test('redeemable trees subtracts pledges already made, never negative', () {
      expect(redeemableTrees(points: 170, alreadyRedeemed: 0), 3);
      expect(redeemableTrees(points: 170, alreadyRedeemed: 2), 1);
      expect(redeemableTrees(points: 170, alreadyRedeemed: 3), 0);
      expect(redeemableTrees(points: 40, alreadyRedeemed: 0), 0);
      expect(redeemableTrees(points: 0, alreadyRedeemed: 2), 0);
    });
  });

  group('zakat math', () {
    test('total is assets minus debts, floored at zero', () {
      expect(
        zakatableTotal(
          cash: 5000000,
          gold: 2000000,
          silver: 0,
          business: 3000000,
          debts: 1000000,
        ),
        9000000,
      );
      expect(
        zakatableTotal(cash: 100, gold: 0, silver: 0, business: 0, debts: 500),
        0,
      );
    });

    test('due is 2.5% with poisha rounding', () {
      expect(zakatDue(10000000), 250000); // 100,000 taka -> 2,500 taka
      expect(zakatDue(0), 0);
      expect(zakatDue(101), 3); // 2.525 poisha rounds to 3
    });

    test('nisab threshold is 595 grams at the live price', () {
      expect(nisabThresholdPoisha(17600), 595 * 17600);
    });
  });

  group('monthlyPerformance', () {
    WalletTransaction tx(TxKind kind, int amount, DateTime at) =>
        WalletTransaction(
          id: at.toIso8601String(),
          walletId: 'w1',
          kind: kind,
          amount: amount,
          createdAt: at,
        );

    test('cumulative invested and profit over the real month range', () {
      final points = monthlyPerformance([
        tx(TxKind.deposit, 10000000, DateTime.utc(2026, 3, 5)),
        tx(TxKind.investment, 4000000, DateTime.utc(2026, 3, 20)),
        tx(TxKind.investment, 2000000, DateTime.utc(2026, 5, 2)),
        tx(TxKind.distribution, 800000, DateTime.utc(2026, 6, 15)),
      ], now: DateTime.utc(2026, 7, 12));

      expect(points, hasLength(5)); // March through July, the real range.
      expect(points[0].cumulativeInvested, 4000000);
      expect(points[0].cumulativeProfit, 0);
      expect(points[1].cumulativeInvested, 4000000); // April: no movement
      expect(points[2].cumulativeInvested, 6000000);
      expect(points[3].cumulativeProfit, 800000);
      expect(points[4].cumulativeInvested, 6000000);
      expect(points[4].cumulativeProfit, 800000);
    });

    test('empty ledger yields no points, and deposits alone move nothing', () {
      expect(monthlyPerformance([], now: DateTime.utc(2026, 7, 1)), isEmpty);
      final points = monthlyPerformance([
        tx(TxKind.deposit, 10000000, DateTime.utc(2026, 7, 1)),
      ], now: DateTime.utc(2026, 7, 12));
      expect(points.single.cumulativeInvested, 0);
      expect(points.single.cumulativeProfit, 0);
    });
  });
}
