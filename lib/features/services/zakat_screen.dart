import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/l10n/app_localizations.dart';
import '../../app/theme/ribh_tokens.dart';
import '../../core/constants/zakat_math.dart';
import '../../core/failures/failure.dart';
import '../../core/formatters/taka.dart';
import '../../data/models/models.dart';
import '../../shared/barakah_banner.dart';
import '../../shared/empty_state.dart';
import '../../shared/failure_l10n.dart';
import '../../shared/ribh_sheet_scaffold.dart';
import 'give_sheet.dart';
import 'services_controllers.dart';

/// Zakat: three-slide banner (board-gated copy), the calculator with live
/// derived total and due, Nisab status against a real silver price source
/// (honestly unavailable while none is connected), welfare projects, and
/// giving through the no-fee give_welfare RPC.
class ZakatScreen extends ConsumerStatefulWidget {
  const ZakatScreen({super.key});

  @override
  ConsumerState<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends ConsumerState<ZakatScreen> {
  final _controllers = {
    for (final field in ['cash', 'gold', 'silver', 'business', 'debts'])
      field: TextEditingController(),
  };

  @override
  void dispose() {
    for (final controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  int _value(String field) => parseTakaToPoisha(_controllers[field]!.text) ?? 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final zakat = ref.watch(zakatControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.serviceZakat)),
      body: zakat.when(
        skipLoadingOnRefresh: false,
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  failureText(
                    l10n,
                    error is Failure ? error : UnknownFailure('$error'),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: () => ref.invalidate(zakatControllerProvider),
                  child: Text(l10n.retry),
                ),
              ],
            ),
          ),
        ),
        data: (data) => _body(context, l10n, data),
      ),
    );
  }

  Widget _body(BuildContext context, AppLocalizations l10n, ZakatData data) {
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;

    final total = zakatableTotal(
      cash: _value('cash'),
      gold: _value('gold'),
      silver: _value('silver'),
      business: _value('business'),
      debts: _value('debts'),
    );
    final due = zakatDue(total);
    final price = data.silverPrice;
    final threshold = price == null
        ? null
        : nisabThresholdPoisha(price.perGramPoisha);

    final fieldLabels = {
      'cash': l10n.zakatCashLabel,
      'gold': l10n.zakatGoldLabel,
      'silver': l10n.zakatSilverLabel,
      'business': l10n.zakatBusinessLabel,
      'debts': l10n.zakatDebtsLabel,
    };

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        BarakahBanner(
          slides: [
            BarakahSlide(
              icon: LucideIcons.droplets,
              title: l10n.zakatBanner1Title,
              subtitle: l10n.zakatBanner1Sub,
            ),
            BarakahSlide(
              icon: LucideIcons.scale,
              title: l10n.zakatBanner2Title,
              subtitle: l10n.zakatBanner2Sub,
            ),
            BarakahSlide(
              icon: LucideIcons.shieldCheck,
              title: l10n.zakatBanner3Title,
              subtitle: l10n.zakatBanner3Sub,
            ),
          ],
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.zakatCalcTitle, style: theme.textTheme.titleMedium),
                const SizedBox(height: 12),
                for (final entry in fieldLabels.entries) ...[
                  TextField(
                    controller: _controllers[entry.key],
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      labelText: entry.value,
                      prefixText: takaSign,
                      isDense: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
                Text(
                  l10n.zakatTotalLine(formatTaka(total, localeCode: locale)),
                  style: theme.textTheme.bodyMedium,
                ),
                Text(
                  l10n.zakatDueLine(formatTaka(due, localeCode: locale)),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: tokens.tealDeep,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  l10n.zakatGuidanceNote,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: tokens.inkSoft,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: threshold == null
                ? EmptyState(
                    icon: LucideIcons.scale,
                    title: l10n.zakatNisabTitle,
                    body: l10n.zakatNisabUnavailable,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.zakatNisabTitle,
                        style: theme.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        total >= threshold
                            ? l10n.zakatNisabAbove(
                                formatTaka(threshold, localeCode: locale),
                              )
                            : l10n.zakatNisabBelow(
                                formatTaka(threshold, localeCode: locale),
                              ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: tokens.ink,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        const SizedBox(height: 20),
        Text(l10n.welfareProjectsTitle, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final project in data.projects) _ProjectCard(project: project),
        const SizedBox(height: 12),
        FilledButton.icon(
          icon: const Icon(LucideIcons.handHeart, size: 18),
          label: Text(l10n.giveZakatCta),
          onPressed: data.projects.isEmpty
              ? null
              : () => showRibhSheet<void>(
                  context: context,
                  builder: (_) => GiveSheet(
                    title: l10n.giveZakatCta,
                    projects: data.projects,
                    onGive: ref.read(zakatControllerProvider.notifier).give,
                  ),
                ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({required this.project});

  final WelfareProject project;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tokens = context.tokens;
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final progress = project.target == 0
        ? 0.0
        : (project.raised / project.target).clamp(0.0, 1.0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(project.title, style: theme.textTheme.titleSmall),
            Text(
              project.district,
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(999),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 6,
                backgroundColor: tokens.mintSoft,
                color: tokens.green,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              l10n.projectProgress(
                formatTaka(project.raised, localeCode: locale),
                formatTaka(project.target, localeCode: locale),
              ),
              style: theme.textTheme.bodySmall?.copyWith(color: tokens.inkSoft),
            ),
          ],
        ),
      ),
    );
  }
}
