import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/core/constants/risk_tiers.dart';

void main() {
  group('recommendTier', () {
    test('majority answer wins', () {
      expect(
        recommendTier([RiskTier.short, RiskTier.short, RiskTier.diversified]),
        RiskTier.short,
      );
      expect(
        recommendTier([
          RiskTier.diversified,
          RiskTier.diversified,
          RiskTier.balanced,
        ]),
        RiskTier.diversified,
      );
    });

    test('unanimous answers win', () {
      expect(
        recommendTier([
          RiskTier.balanced,
          RiskTier.balanced,
          RiskTier.balanced,
        ]),
        RiskTier.balanced,
      );
    });

    test('a three-way tie falls back to balanced', () {
      expect(
        recommendTier([
          RiskTier.short,
          RiskTier.balanced,
          RiskTier.diversified,
        ]),
        RiskTier.balanced,
      );
    });

    test('empty answers fall back to balanced', () {
      expect(recommendTier(const []), RiskTier.balanced);
    });
  });

  group('RiskTier db round trip', () {
    test('every tier survives', () {
      for (final tier in RiskTier.values) {
        expect(RiskTier.fromDb(tier.dbValue), tier);
      }
      expect(RiskTier.fromDb(null), isNull);
      expect(RiskTier.fromDb('nonsense'), isNull);
    });
  });
}
