import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import '../lib/Utilities/theme_provider.dart';
import '../lib/pages/settings.dart';

void main(){

  Widget createTestableWidget(Widget child) {
    return ChangeNotifierProvider<ThemeProvider>(
      create: (_) => ThemeProvider(),
      child: MaterialApp(
        home: child,
      ),
    );
  }

  testWidgets('SettingsPage displays all list tiles', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const SettingsPage()));

    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.text('Enable Notifications'), findsOneWidget);
    expect(find.text('Help Number'), findsOneWidget);
    expect(find.text('Report a Problem'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Dark Mode switch toggles theme', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const SettingsPage()));

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsNWidgets(2)); // Dark Mode and Notifications

    final themeProvider = Provider.of<ThemeProvider>(tester.element(find.byType(SettingsPage)), listen: false);
    expect(themeProvider.isDarkMode, true);

    await tester.tap(switchFinder.first);
    await tester.pumpAndSettle();

    expect(themeProvider.isDarkMode, false);
  });

  testWidgets('Help Number displays a snackbar', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const SettingsPage()));

    await tester.tap(find.text('Help Number'));
    await tester.pump();

    expect(find.text('Dial 703-111-1111 for help'), findsOneWidget);
  });

  testWidgets('Report a Problem displays a snackbar', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const SettingsPage()));

    await tester.tap(find.text('Report a Problem'));
    await tester.pump();

    expect(find.text('Email: support@flextimer.com'), findsOneWidget);
  });

  testWidgets('About dialog opens with correct information', (WidgetTester tester) async {
    await tester.pumpWidget(createTestableWidget(const SettingsPage()));

    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    expect(find.text('About FlexTimer'), findsOneWidget);
    expect(find.text('App Version: 1.0.0'), findsOneWidget);
    expect(find.text('Last Updated: November 2024'), findsOneWidget);
    expect(find.text('Developed by: The FlexTimer Team'), findsOneWidget);

    await tester.tap(find.text('Close'));
    await tester.pumpAndSettle();

    expect(find.text('About FlexTimer'), findsNothing);
  });
}