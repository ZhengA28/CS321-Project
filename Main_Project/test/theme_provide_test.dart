import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/Utilities/theme_provider.dart';

void main(){
  group('ThemeProvider Tests', () {
    test('Initial theme is dark mode', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.isDarkMode, true);
      expect(themeProvider.themeData.brightness, Brightness.dark);
    });

    test('Toggling theme changes to light mode', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme();
      expect(themeProvider.isDarkMode, false);
      expect(themeProvider.themeData.brightness, Brightness.light);
    });

    test('Toggling theme changes back to dark mode', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme();
      themeProvider.toggleTheme();
      expect(themeProvider.isDarkMode, true);
      expect(themeProvider.themeData.brightness, Brightness.dark);
    });

    test('Dark mode has correct theme data', () {
      final themeProvider = ThemeProvider();
      expect(themeProvider.themeData.scaffoldBackgroundColor, Colors.black);
      expect(themeProvider.themeData.primaryColor, Colors.teal);
      expect(themeProvider.themeData.textButtonTheme.style?.foregroundColor, Colors.teal);
      expect(themeProvider.themeData.iconTheme.color, Colors.teal);
    });

    test('Light mode has correct theme data', () {
      final themeProvider = ThemeProvider();
      themeProvider.toggleTheme();
      expect(themeProvider.themeData.scaffoldBackgroundColor, Colors.white);
      expect(themeProvider.themeData.primaryColor, Colors.teal);
      expect(themeProvider.themeData.textButtonTheme.style?.foregroundColor, Colors.black);
      expect(themeProvider.themeData.iconTheme.color, Colors.teal);
    });
  });
}
