import 'package:flutter/material.dart';

import '../../app/l10n/app_localizations.dart';
import '../../shared/milestone_placeholder.dart';

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MilestonePlaceholder(title: AppLocalizations.of(context)!.tabInvest);
  }
}
