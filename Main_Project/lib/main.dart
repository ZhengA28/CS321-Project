import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/preset.dart';
import 'pages/user_profile.dart';
import 'pages/settings.dart';

import 'package:provider/provider.dart'; // Import provider
import 'Utilities/theme_provider.dart'; // Import ThemeProvider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(), // ThemeProvider Global
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  int time = 0;
  List names = ["Andy", "Karen", "Jacky", "Amy"];

  @override
  Widget build(BuildContext context) {
    // Access the current theme state
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // Set the theme based on ThemeProvider state
      theme: themeProvider.isDarkMode
          ? ThemeData.dark().copyWith(
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          primary: Colors.teal,
        ),
      )
          : ThemeData.light().copyWith(
        colorScheme: ThemeData.light().colorScheme.copyWith(
          primary: Colors.teal,
        ),
      ),

      home: const HomePage(), // Initial Page on app startup

      routes: { // List of pages for navigation
        '/homepage': (context) => const HomePage(),
        'presetpage': (context) => PresetPage(
          onAddExercise: (exerciseName) {
            print("");
          },
        ),
        'profilepage': (context) => const ProfilePage(),
        'settingspage': (context) => const SettingsPage(),
      },
    );
  }
}
