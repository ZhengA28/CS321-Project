import '.../lib/Utilities/exercise.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '.../lib/Utilities/button.dart'; 
import '.../lib/Utilities/custom_timer.dart';  
import '.../lib/Utilities/dialogue_box.dart';  

  group('Exercise Widget Tests', () {
    testWidgets('Exercise widget renders correctly with given name and duration', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Exercise(
              name: 'Push Ups',
              duration: Duration(minutes: 1),
              deleteExercise: (_) {},
              completeExercise: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Push Ups'), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(Slidable), findsOneWidget);
    });

    testWidgets('Exercise play button starts the timer', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Exercise(
              name: 'Push Ups',
              duration: Duration(seconds: 10),
              deleteExercise: (_) {},
              completeExercise: (_) {},
            ),
          ),
        ),
      );

      final playButton = find.byIcon(Icons.play_circle);

      expect(playButton, findsOneWidget);
      await tester.tap(playButton);
      await tester.pump();

      final pauseButton = find.byIcon(Icons.pause_circle);
      expect(pauseButton, findsOneWidget);
    });

    testWidgets('Exercise pause button pauses the timer', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Exercise(
              name: 'Push Ups',
              duration: Duration(seconds: 10),
              deleteExercise: (_) {},
              completeExercise: (_) {},
            ),
          ),
        ),
      );

      final playButton = find.byIcon(Icons.play_circle);

      await tester.tap(playButton);
      await tester.pump();
      expect(find.byIcon(Icons.pause_circle), findsOneWidget);

      final pauseButton = find.byIcon(Icons.pause_circle);

      await tester.tap(pauseButton);
      await tester.pump();

      expect(find.byIcon(Icons.play_circle), findsOneWidget);
    });

    testWidgets('Exercise slide to delete triggers delete callback', (WidgetTester tester) async {
      var deleteCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Exercise(
              name: 'Push Ups',
              duration: Duration(minutes: 1),
              deleteExercise: (_) {
                deleteCalled = true;
              },
              completeExercise: (_) {},
            ),
          ),
        ),
      );

      final deleteAction = find.byIcon(Icons.delete_forever);

      await tester.drag(deleteAction, const Offset(-500.0, 0.0));
      await tester.pumpAndSettle();

      expect(deleteCalled, true);
    });

    testWidgets('Exercise slide to complete triggers complete callback', (WidgetTester tester) async {
      var completeCalled = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Exercise(
              name: 'Push Ups',
              duration: Duration(minutes: 1),
              deleteExercise: (_) {},
              completeExercise: (_) {
                completeCalled = true;
              },
            ),
          ),
        ),
      );

      final completeAction = find.byIcon(Icons.check_circle);

      await tester.drag(completeAction, const Offset(500.0, 0.0));
      await tester.pumpAndSettle();

      expect(completeCalled, true);
    });

    testWidgets('Exercise widget displays correct time format', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Exercise(
              name: 'Push Ups',
              duration: Duration(minutes: 1, seconds: 5),
              deleteExercise: (_) {},
              completeExercise: (_) {},
            ),
          ),
        ),
      );

      expect(find.textContaining('1 : 05'), findsOneWidget);
    });

    ///Test for timers
    group('Custom Timer Tests', () {
    test('Timer initializes with correct duration', () {
      final timer = Custom_Timer(Duration(seconds: 60));
      expect(timer.duration, Duration(seconds: 60));
      expect(timer.remaining_time, Duration(seconds: 60));
    });

    testWidgets('Timer displays countdown text', (WidgetTester tester) async {
      final timer = Custom_Timer(Duration(seconds: 60));
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: timer,
          ),
        ),
      );
      expect(find.textContaining('Countdown:'), findsOneWidget);
    });

    test('Timer start and stop functionality', () {
      final state = Timer_State();
      state.widget.duration = Duration(seconds: 5);
      state.widget.remaining_time = Duration(seconds: 5);
      state.start();
      expect(state.is_running, true);
      state.stop();
      expect(state.is_running, false);
      expect(state.widget.remaining_time, state.widget.duration);
    });
  });

  group('DialogueBox Tests', () {
    testWidgets('DialogueBox renders with text and duration fields', (WidgetTester tester) async {
      final textController = TextEditingController();
      final durationController = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueBox(
              text_controller: textController,
              duration_controller: durationController,
              onSave: () {},
              onCancel: () {},
            ),
          ),
        ),
      );
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Enter name of exercise'), findsOneWidget);
      expect(find.text('Enter the time in seconds'), findsOneWidget);
    });

    testWidgets('DialogueBox calls onSave when Save button is pressed', (WidgetTester tester) async {
      final textController = TextEditingController();
      final durationController = TextEditingController();
      var wasSavePressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueBox(
              text_controller: textController,
              duration_controller: durationController,
              onSave: () {
                wasSavePressed = true;
              },
              onCancel: () {},
            ),
          ),
        ),
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();
      expect(wasSavePressed, true);
    });

    testWidgets('DialogueBox calls onCancel when Cancel button is pressed', (WidgetTester tester) async {
      final textController = TextEditingController();
      final durationController = TextEditingController();
      var wasCancelPressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueBox(
              text_controller: textController,
              duration_controller: durationController,
              onSave: () {},
              onCancel: () {
                wasCancelPressed = true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      expect(wasCancelPressed, true);
    });

    testWidgets('DialogueBox updates text controllers', (WidgetTester tester) async {
      final textController = TextEditingController();
      final durationController = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DialogueBox(
              text_controller: textController,
              duration_controller: durationController,
              onSave: () {},
              onCancel: () {},
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextField).at(0), 'Push Ups');
      await tester.enterText(find.byType(TextField).at(1), '30');
      expect(textController.text, 'Push Ups');
      expect(durationController.text, '30');
    });
  });