import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorial_project/Utilities/exercise.dart';

class LocalDatabase{
  List exercise_List = [];
  final myBox = Hive.box('myBox');

  void initialData(){
    exercise_List = [["Default", "0"], ["Default", "0"]];
  }

  void loadData(){
    exercise_List = myBox.get("EXERCISE");
  }

  void updateData(){
    myBox.put("EXERCISE", exercise_List);
  }

}