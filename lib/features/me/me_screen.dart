import 'package:flutter/material.dart';

import '../../app/l10n/app_localizations.dart';
import '../../shared/milestone_placeholder.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MilestonePlaceholder(title: AppLocalizations.of(context)!.tabMe);
  }
}
