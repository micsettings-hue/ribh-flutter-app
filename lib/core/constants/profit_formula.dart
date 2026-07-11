/// The canonical profit formula. Every calculator and projection in the app
/// uses this function; no screen re-derives it.
///
///   investor_profit = (invested / 100000) * profit_per_lac * investor_share%
///
/// Units are caller-consistent: pass both `invested` and `profitPerLac` in
/// poisha (or both in taka) and the result is in the same unit.
/// `sharePercent` is 0..100.
///
/// This is a PROJECTION. Wherever its output is shown, the UI must label it
/// projected and carry a risk disclosure. Returns are never guaranteed.
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
