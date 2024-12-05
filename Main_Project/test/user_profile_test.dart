import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:mockito/mockito.dart';
import '../lib/Utilities/theme_provider.dart'; // Adjust the import path
import '../lib/pages/user_profile.dart'; // Adjust the import path


class MockThemeProvider extends Mock implements ThemeProvider {}
void main() {
  group('ProfilePage', () {
    late MockThemeProvider mockThemeProvider;

    setUp(() {
      mockThemeProvider = MockThemeProvider();
    });

    testWidgets(
        'should validate and save profile data', (WidgetTester tester) async {
      // Set up the widget with a mock ThemeProvider
      await tester.pumpWidget(
        ChangeNotifierProvider<ThemeProvider>.value(
          value: mockThemeProvider,
          child: MaterialApp(
            home: ProfilePage(),
          ),
        ),
      );

      // Enter valid data into the form fields
      await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
      await tester.enterText(
          find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), '1234567890');

      // Tap the save button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that a snackbar is shown
      expect(find.byType(SnackBar), findsOneWidget);

      // Verify that the form data is saved (you can extend this for persistent storage)
      // ...
    });

    testWidgets('should display validation errors for invalid data', (
        WidgetTester tester) async {
      // ... (Similar setup as the previous test)

      // Enter invalid data into the form fields
      await tester.enterText(
          find.byType(TextFormField).at(0), ''); // Empty username
      await tester.enterText(find.byType(TextFormField).at(1), 'invalid_email');
      await tester.enterText(
          find.byType(TextFormField).at(2), '123'); // Invalid phone

      // Tap the save button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // Verify that validation errors are displayed
      expect(find.text('Please enter your username'), findsOneWidget);
      expect(find.text('Enter a valid email address'), findsOneWidget);
      expect(find.text('Enter a valid phone number'), findsOneWidget);
    });

    // Add more test cases as needed
  });
}