import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/core/formatters/taka.dart';

void main() {
  group('formatTaka', () {
    test('western grouping for en', () {
      expect(formatTaka(12840000, localeCode: 'en'), '৳128,400');
      expect(formatTaka(100, localeCode: 'en'), '৳1');
      expect(formatTaka(0, localeCode: 'en'), '৳0');
    });

    test('Indian grouping for bn, the design-system example', () {
      // 1,28,400 taka is the documented example.
      expect(formatTaka(12840000, localeCode: 'bn'), '৳1,28,400');
      expect(formatTaka(1000000000, localeCode: 'bn'), '৳1,00,00,000');
      expect(formatTaka(99900, localeCode: 'bn'), '৳999');
    });

    test('poisha remainder shows two decimals, whole taka shows none', () {
      expect(formatTaka(150050, localeCode: 'en'), '৳1,500.50');
      expect(formatTaka(105, localeCode: 'en'), '৳1.05');
      expect(formatTaka(150000, localeCode: 'en'), '৳1,500');
    });

    test('negative amounts carry the sign outside the taka sign', () {
      expect(formatTaka(-5000, localeCode: 'en'), '-৳50');
    });
  });

  group('parseTakaToPoisha', () {
    test('accepts whole, one-decimal, two-decimal, and grouped input', () {
      expect(parseTakaToPoisha('1234'), 123400);
      expect(parseTakaToPoisha('1234.5'), 123450);
      expect(parseTakaToPoisha('1,234.56'), 123456);
      expect(parseTakaToPoisha(' 500 '), 50000);
    });

    test('rejects zero, negatives, three decimals, and junk', () {
      expect(parseTakaToPoisha('0'), isNull);
      expect(parseTakaToPoisha('0.00'), isNull);
      expect(parseTakaToPoisha('-5'), isNull);
      expect(parseTakaToPoisha('1.234'), isNull);
      expect(parseTakaToPoisha('abc'), isNull);
      expect(parseTakaToPoisha(''), isNull);
    });
  });
}
