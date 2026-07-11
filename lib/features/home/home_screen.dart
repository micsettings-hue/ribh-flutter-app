import 'package:flutter/material.dart';

import '../../app/l10n/app_localizations.dart';
import '../../shared/milestone_placeholder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MilestonePlaceholder(title: AppLocalizations.of(context)!.tabHome);
  }
}
