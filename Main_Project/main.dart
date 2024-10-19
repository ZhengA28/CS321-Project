import 'package:flutter/material.dart';
import 'package:tutorial_project/pages/home.dart';
import 'package:tutorial_project/pages/preset.dart';
import 'package:tutorial_project/pages/user_profile.dart';
import 'package:tutorial_project/pages/settings.dart';

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