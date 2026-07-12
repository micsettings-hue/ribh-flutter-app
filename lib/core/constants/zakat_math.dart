/// Zakat arithmetic. All amounts in poisha, all integer math.
///
/// TODO(board): the silver standard (595 grams) and the 2.5% rate are the
/// conventional values from the prototype; Abdullah Jubair must sign off on
/// the standard, the rate, and all guidance copy before launch.
library;

/// Grams of silver in the Nisab under the silver standard.
const int nisabSilverGrams = 595;

/// Zakatable total: assets minus debts, floored at zero.
int zakatableTotal({
  required int cash,
  required int gold,
  required int silver,
  required int business,
  required int debts,
}) {
  final total = cash + gold + silver + business - debts;
  return total < 0 ? 0 : total;
}

/// Zakat due at 2.5%, rounded to the nearest poisha.
int zakatDue(int zakatableTotalPoisha) =>
    (zakatableTotalPoisha * 25 + 500) ~/ 1000;

/// The Nisab threshold in poisha for a given live silver price per gram.
int nisabThresholdPoisha(int silverPricePerGramPoisha) =>
    nisabSilverGrams * silverPricePerGramPoisha;
