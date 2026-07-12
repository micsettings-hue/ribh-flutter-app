import '../../data/models/models.dart';

/// One month on the performance chart: cumulative invested capital and
/// cumulative distributed profit at month end, both in poisha.
class MonthPoint {
  const MonthPoint({
    required this.year,
    required this.month,
    required this.cumulativeInvested,
    required this.cumulativeProfit,
  });

  final int year;
  final int month;
  final int cumulativeInvested;
  final int cumulativeProfit;
}

/// Derives the performance series from the ledger: investments accumulate
/// into invested capital, distributions into profit, month by month over
/// the REAL date range from the first transaction to [now]. Nothing is
/// interpolated or smoothed; there is no daily volatility to draw.
List<MonthPoint> monthlyPerformance(
  List<WalletTransaction> transactions, {
  required DateTime now,
}) {
  if (transactions.isEmpty) return const [];
  final sorted = [...transactions]
    ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  final first = sorted.first.createdAt;

  final points = <MonthPoint>[];
  var invested = 0;
  var profit = 0;
  var index = 0;
  var year = first.year;
  var month = first.month;

  while (year < now.year || (year == now.year && month <= now.month)) {
    while (index < sorted.length &&
        (sorted[index].createdAt.year < year ||
            (sorted[index].createdAt.year == year &&
                sorted[index].createdAt.month <= month))) {
      final tx = sorted[index];
      if (tx.kind == TxKind.investment) invested += tx.amount;
      if (tx.kind == TxKind.distribution) profit += tx.amount;
      index++;
    }
    points.add(
      MonthPoint(
        year: year,
        month: month,
        cumulativeInvested: invested,
        cumulativeProfit: profit,
      ),
    );
    month++;
    if (month > 12) {
      month = 1;
      year++;
    }
  }
  return points;
}
