import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/preset.dart';
import 'pages/user_profile.dart';
import 'pages/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  MyApp({super.key});
  int time = 0;
  List names = ["Andy", "Karen", "Jacky", "Amy"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: const HomePage(), //Initial Page on app startup
      theme: ThemeData(primarySwatch: Colors.teal), //Set theme color of app

      routes:{  //List of pages for navigation
        '/homepage' : (context) => const HomePage(),
        'presetpage' : (context) => const PresetPage(),
        'profilepage' : (context) => const ProfilePage(),
        'settingspage' : (context) => const SettingsPage(),
      }
    );
  }
}
