import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  // Set dark mode as the default state
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get themeData {
    return _isDarkMode
        ? ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black, // Dark mode background
      primaryColor: Colors.teal,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.teal, // Text color for TextButton in dark mode
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.teal),
    )
        : ThemeData.light().copyWith(
      scaffoldBackgroundColor: Colors.white, // Light mode background
      primaryColor: Colors.teal,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black, // Text color for TextButton in light mode
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.teal),
    );
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}


