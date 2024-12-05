import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/pages/preset.dart'; // Adjust the import path

void main() {
  group('PresetPage', () {
    testWidgets('should display preset exercises and add button', (WidgetTester tester) async {
      // Build the PresetPage widget
      await tester.pumpWidget(MaterialApp(home: PresetPage(onAddExercise: (name) {})));

      // Verify that the app bar title is displayed
      expect(find.text('Preset Exercise'), findsOneWidget);

      // Verify that the list view is displayed
      expect(find.byType(ListView), findsOneWidget);

      // Verify that the first preset exercise is displayed
      expect(find.text('Alternating Dumbbell Curl'), findsOneWidget); // Assuming 'Push-ups' is the first preset

      // Verify that the add button is displayed for the first preset
      expect(find.byIcon(Icons.add), findsOneWidget);

      // Tap the add button for the first preset
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
    });

    // Add more test cases as needed
  });
}