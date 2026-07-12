/// The canonical profit formula. Every calculator and projection in the app
/// uses these functions; no screen re-derives them.
///
///   investor_profit = (invested / lac) * profit_per_lac * investor_share%
///
/// "Per lac" means per 100,000 TAKA. [investorProfit] therefore expects both
/// `invested` and `profitPerLac` in taka; for database values (poisha) use
/// [investorProfitPoisha], which accounts for a lac of taka being 10,000,000
/// poisha. Passing poisha into [investorProfit] overstates the result 100x.
///
/// These are PROJECTIONS. Wherever their output is shown, the UI must label
/// it projected and carry a risk disclosure. Returns are never guaranteed.
library;

/// Projected investor profit in taka, for amounts given in taka.
/// `sharePercent` is 0..100.
double investorProfit({
  required num invested,
  required num profitPerLac,
  required num sharePercent,
}) {
  assert(invested >= 0, 'invested must be non-negative');
  assert(profitPerLac >= 0, 'profitPerLac must be non-negative');
  assert(
    sharePercent >= 0 && sharePercent <= 100,
    'sharePercent must be within 0..100',
  );
  return (invested / 100000) * profitPerLac * (sharePercent / 100);
}

/// One lac taka expressed in poisha.
const int _poishaPerLacTaka = 10000000;

/// Projected investor profit in poisha, for database amounts (poisha).
int investorProfitPoisha({
  required int investedPoisha,
  required int profitPerLacPoisha,
  required num sharePercent,
}) {
  assert(investedPoisha >= 0, 'investedPoisha must be non-negative');
  assert(profitPerLacPoisha >= 0, 'profitPerLacPoisha must be non-negative');
  assert(
    sharePercent >= 0 && sharePercent <= 100,
    'sharePercent must be within 0..100',
  );
  return ((investedPoisha / _poishaPerLacTaka) *
          profitPerLacPoisha *
          (sharePercent / 100))
      .round();
}

/// Projected annualised rate in percent, from a campaign's real terms:
/// the investor share of profit per lac, as a fraction of the lac, scaled
/// from the tenure to twelve months. Marked projected wherever shown.
double projectedAnnualisedRatePercent({
  required int profitPerLacPoisha,
  required num sharePercent,
  required int tenureMonths,
}) {
  assert(tenureMonths > 0, 'tenureMonths must be positive');
  final profitFractionOverTenure =
      profitPerLacPoisha * (sharePercent / 100) / _poishaPerLacTaka;
  return profitFractionOverTenure * (12 / tenureMonths) * 100;
}
