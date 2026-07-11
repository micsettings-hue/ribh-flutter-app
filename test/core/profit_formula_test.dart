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

    test('works identically in poisha (unit-consistent)', () {
      final taka = investorProfit(
        invested: 128400,
        profitPerLac: 14500,
        sharePercent: 60,
      );
      final poisha = investorProfit(
        invested: 12840000,
        profitPerLac: 1450000,
        sharePercent: 60,
      );
      expect(poisha, closeTo(taka * 100 * 100, 0.01));
    });
  });
}
