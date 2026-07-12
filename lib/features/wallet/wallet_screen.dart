import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ledger_row.dart';
import '../../shared/empty_state.dart';
import '../../shared/skeleton_box.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'deposit_sheet.dart';
import 'labels.dart';
import 'performance.dart';
import 'wallet_controller.dart';
import 'withdraw_sheet.dart';

/// The Amanah wallet: derived balance, pending money requests, and the
/// append-only ledger. Every figure on this screen is derived; no balance
/// is ever stored or invented.
class WalletScreen extends ConsumerWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final wallet = ref.watch(walletControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.walletTitle)),
      body: wallet.when(
        skipLoadingOnRefresh: false,
        loading: () => const _WalletSkeleton(),
        error: (error, _) => _WalletError(
          failure: error is Failure ? error : UnknownFailure('$error'),
          onRetry: () => ref.invalidate(walletControllerProvider),
        ),
        data: (data) => RefreshIndicator(
          onRefresh: () => ref.refresh(walletControllerProvider.future),
          child: _WalletBody(data: data),
        ),
      ),
    );
  }
}

class _WalletSkeleton extends StatelessWidget {
  const _WalletSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SkeletonBox(height: 148),
        const SizedBox(height: 12),
        for (var i = 0; i < 4; i++) ...[
          const SkeletonBox(),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _WalletError extends StatelessWidget {
  const _WalletError({required this.failure, required this.onRetry});

  final Failure failure;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              failureText(l10n, failure),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: onRetry, child: Text(l10n.retry)),
          ],
        ),
      ),
    );
  }
}

class _WalletBody extends ConsumerWidget {
  const _WalletBody({required this.data});

  final WalletData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final pending = data.pendingRequests;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: [
        _BalanceCard(balancePoisha: data.balance),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: FilledButton.icon(
                icon: const Icon(LucideIcons.plus, size: 18),
                label: Text(l10n.walletAddFunds),
                onPressed: () => showRibhSheet<void>(
                  context: context,
                  builder: (_) => const DepositSheet(),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(LucideIcons.arrowUpRight, size: 18),
                label: Text(l10n.walletWithdraw),
                onPressed: () => showRibhSheet<void>(
                  context: context,
                  builder: (_) =>
                      WithdrawSheet(available: data.availableForWithdrawal),
                ),
              ),
            ),
          ],
        ),
        if (pending.isNotEmpty) ...[
          const SizedBox(height: 24),
          Text(l10n.walletPendingRequests, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          for (final request in pending) _PendingRequestCard(request: request),
        ],
        const SizedBox(height: 24),
        Text(l10n.walletPerformanceTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        _PerformanceChart(transactions: data.transactions),
        const SizedBox(height: 24),
        Text(l10n.walletLedger, style: theme.textTheme.titleMedium),
        const SizedBox(height: 4),
        if (data.transactions.isEmpty)
          EmptyState(
            icon: LucideIcons.scrollText,
            title: l10n.emptyTitle,
            body: l10n.walletLedgerEmpty,
          )
        else
          for (final tx in data.transactions) LedgerRow(transaction: tx),
      ],
    );
  }
}

class _PerformanceChart extends StatelessWidget {
  const _PerformanceChart({required this.transactions});

  final List<WalletTransaction> transactions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final points = monthlyPerformance(transactions, now: DateTime.now());

    if (points.length < 2) {
      return Text(
        l10n.walletPerformanceEmpty,
        style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
      );
    }

    List<FlSpot> spots(int Function(MonthPoint) pick) => [
      for (var i = 0; i < points.length; i++)
        FlSpot(i.toDouble(), pick(points[i]) / 100),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(show: false),
              titlesData: FlTitlesData(
                topTitles: const AxisTitles(),
                rightTitles: const AxisTitles(),
                leftTitles: const AxisTitles(),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: (points.length / 4).ceilToDouble(),
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < 0 || index >= points.length) {
                        return const SizedBox.shrink();
                      }
                      final point = points[index];
                      return Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          DateFormat.MMM(
                            locale,
                          ).format(DateTime(point.year, point.month)),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: tokens.inkSoft,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              lineTouchData: const LineTouchData(enabled: false),
              lineBarsData: [
                LineChartBarData(
                  spots: spots((p) => p.cumulativeInvested),
                  color: tokens.teal,
                  barWidth: 2.5,
                  dotData: const FlDotData(show: false),
                  isCurved: false,
                ),
                LineChartBarData(
                  spots: spots((p) => p.cumulativeProfit),
                  color: tokens.goldText,
                  barWidth: 2.5,
                  dotData: const FlDotData(show: false),
                  isCurved: false,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _legendDot(tokens.teal, l10n.walletChartInvested, theme),
            const SizedBox(width: 16),
            _legendDot(tokens.goldText, l10n.walletChartProfit, theme),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          l10n.walletPerformanceNote,
          style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
      ],
    );
  }

  Widget _legendDot(Color color, String label, ThemeData theme) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
      const SizedBox(width: 6),
      Text(label, style: theme.textTheme.labelSmall),
    ],
  );
}

class _BalanceCard extends StatelessWidget {
  const _BalanceCard({required this.balancePoisha});

  final int balancePoisha;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [tokens.amanahGradientStart, tokens.amanahGradientEnd],
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.walletBalanceLabel,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            formatTaka(balancePoisha, localeCode: locale),
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.walletBalanceDerived,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}

class _PendingRequestCard extends ConsumerWidget {
  const _PendingRequestCard({required this.request});

  final MoneyRequest request;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final locale = Localizations.localeOf(context).languageCode;

    return Card(
      child: ListTile(
        leading: Icon(
          request.kind == MoneyRequestKind.deposit
              ? LucideIcons.arrowDownLeft
              : LucideIcons.arrowUpRight,
          color: tokens.amber,
        ),
        title: Text(
          '${requestKindLabel(l10n, request.kind)} '
          '${formatTaka(request.amount, localeCode: locale)}',
        ),
        subtitle: Text(
          '${paymentMethodLabel(l10n, request.method)} · '
          '${requestStatusLabel(l10n, request.status)}',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
        ),
        trailing: TextButton(
          onPressed: () => ref
              .read(walletControllerProvider.notifier)
              .cancelRequest(request.id),
          child: Text(l10n.cancel),
        ),
      ),
    );
  }
}
