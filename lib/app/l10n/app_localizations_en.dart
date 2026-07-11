// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'RIBH';

  @override
  String get tabHome => 'Home';

  @override
  String get tabInvest => 'Invest';

  @override
  String get tabGrow => 'Grow';

  @override
  String get tabBarakah => 'Barakah';

  @override
  String get tabMe => 'Me';

  @override
  String get milestonePlaceholderBody =>
      'This area is not live yet. It arrives in an upcoming milestone with real data, not demo content.';
}
