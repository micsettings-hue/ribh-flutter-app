import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/core/constants/profit_formula.dart';

void main() {
  group('investorProfit', () {
    test('one lac invested yields profit_per_lac times share', () {
      // 100,000 invested, 14,500 profit per lac, 60% investor share.
      expect(
        investorProfit(invested: 100000, profitPerLac: 14500, sharePercent: 60),
        closeTo(8700, 0.001),
      );
    });

    test('scales linearly below one lac', () {
      expect(
        investorProfit(invested: 50000, profitPerLac: 14500, sharePercent: 60),
        closeTo(4350, 0.001),
      );
    });

    test('scales linearly above one lac', () {
      expect(
        investorProfit(invested: 250000, profitPerLac: 16000, sharePercent: 55),
        closeTo(22000, 0.001),
      );
    });

    test('zero invested yields zero', () {
      expect(
        investorProfit(invested: 0, profitPerLac: 14500, sharePercent: 60),
        0,
      );
    });

    test('poisha variant agrees with the taka formula', () {
      // A lac is 100,000 TAKA; the poisha variant divides by 10^7, so the
      // two agree exactly (poisha result = taka result * 100). Feeding raw
      // poisha into investorProfit would overstate 100x; the seed campaign
      // terms here prove the poisha path yields the right order of magnitude.
      final taka = investorProfit(
        invested: 128400,
        profitPerLac: 14500,
        sharePercent: 60,
      );
      final poisha = investorProfitPoisha(
        investedPoisha: 12840000,
        profitPerLacPoisha: 1450000,
        sharePercent: 60,
      );
      expect(poisha, (taka * 100).round());
      // One lac taka into the open seed campaign: 14,500 * 60% = 8,700 taka.
      expect(
        investorProfitPoisha(
          investedPoisha: 10000000,
          profitPerLacPoisha: 1450000,
          sharePercent: 60,
        ),
        870000,
      );
    });
  });

  group('projectedAnnualisedRatePercent', () {
    test('seed campaign terms: 14.5k per lac, 60% share, 6 months = 17.4%', () {
      expect(
        projectedAnnualisedRatePercent(
          profitPerLacPoisha: 1450000,
          sharePercent: 60,
          tenureMonths: 6,
        ),
        closeTo(17.4, 0.0001),
      );
    });

    test('twelve-month tenure needs no scaling', () {
      expect(
        projectedAnnualisedRatePercent(
          profitPerLacPoisha: 1750000,
          sharePercent: 55,
          tenureMonths: 12,
        ),
        closeTo(9.625, 0.0001),
      );
    });
  });
}
