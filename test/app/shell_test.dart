import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ribh/app/app.dart';
import 'package:ribh/app/theme/ribh_tokens.dart';

void main() {
  Widget app() => const ProviderScope(child: RibhApp());

  testWidgets('launches to a themed Home shell with five tabs', (tester) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationDestination), findsNWidgets(5));
    // Home is the initial tab: its title in the app bar plus its nav label.
    expect(find.text('Home'), findsNWidgets(2));

    // Light theme tokens are applied to the scaffold.
    final context = tester.element(find.byType(NavigationBar));
    expect(Theme.of(context).scaffoldBackgroundColor, RibhTokens.light.paper);
    expect(Theme.of(context).extension<RibhTokens>(), isNotNull);
  });

  testWidgets('switching tabs shows each tab and preserves shell state', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    for (final label in ['Invest', 'Grow', 'Barakah', 'Me']) {
      await tester.tap(find.widgetWithText(NavigationDestination, label));
      await tester.pumpAndSettle();
      // Tab title appears in the app bar in addition to the nav label.
      expect(find.text(label), findsNWidgets(2));
    }

    await tester.tap(find.widgetWithText(NavigationDestination, 'Home'));
    await tester.pumpAndSettle();
    expect(find.text('Home'), findsNWidgets(2));
  });

  testWidgets('renders dark theme when the platform is dark', (tester) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    final context = tester.element(find.byType(NavigationBar));
    expect(Theme.of(context).brightness, Brightness.dark);
    expect(Theme.of(context).scaffoldBackgroundColor, RibhTokens.dark.paper);
  });

  testWidgets('renders in Bengali when the device locale is bn', (
    tester,
  ) async {
    tester.platformDispatcher.localesTestValue = [const Locale('bn')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);

    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('হোম'), findsNWidgets(2));
    expect(find.text('বিনিয়োগ'), findsOneWidget);
  });
}
