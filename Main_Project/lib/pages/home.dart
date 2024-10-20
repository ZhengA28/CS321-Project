// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:tutorial_project/pages/preset.dart';
import 'package:tutorial_project/pages/settings.dart';
import 'package:tutorial_project/pages/user_profile.dart';
import 'package:tutorial_project/Utilities/exercise.dart';
import 'package:tutorial_project/Utilities/dialogue_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final text_controller = TextEditingController();
  final duration_controller = TextEditingController();

  int page_index = 0;
  final List pages = [  //Array to store pages
    ProfilePage(),
    SettingsPage(),
    PresetPage(),
  ];

  List exercise_list = <Exercise>[];  //Array to store created exercises

  ///Update the page index
  void updatePage(int index) {
    setState(() {
      page_index = index;
    });
  }

  ///Shows a dialogue box for user to create a new exercise
  void createExercise() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          text_controller: text_controller,
          duration_controller: duration_controller,
          onSave: saveExercise, //Save new exercise
          onCancel: () => Navigator.of(context).pop(),  //Close dialogue box
        );
      },
    );
  }


  ///Creates a new exercise object and add it to the list
  void saveExercise() {
    setState(() {
      Exercise exercise = Exercise(text_controller.text,
          Duration(seconds: int.parse(duration_controller.text)));
      exercise_list.add(exercise);

      //Clear the text box
      text_controller.clear();
      duration_controller.clear();
    });
    Navigator.of(context).pop();  //Closes dialogue box after adding to list
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,

      //Creates a bar at top of app
      appBar: AppBar(
        title: Center(
          child: Text(
            "FlexTimer",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        backgroundColor: Colors.teal[700],
        //elevation: 0, //If elevation set to 0, removes app bar shadow
        //leading: Icon(Icons.menu),  //Creates Icon on left hand side
        actions: const [
          IconButton(
              onPressed: null, icon: Icon(Icons.add, color: Colors.black54))
        ], //Create icon on right hand side
      ),

      //Creates a drawer (menu) on left hand side
      drawer: Drawer(
          backgroundColor: Colors.cyan[100],
          child: Column(children: [
            //Header of the drawer
            DrawerHeader(
                child: Icon(
                  Icons.timer,
                  size: 50,
                )),

            //List tile for home page
            ListTile(
                leading: Icon(Icons.home),
                title: Text("H O M E"),
                onTap: () {
                  //Pop drawer first (close drawer so it is not open when user decides to go back to previous page)
                  Navigator.pop(context);
                  //Return to home page
                  Navigator.pushNamed(context, 'homepage');
                }),

            //List tile for settings
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("S E T T I N G S"),
                onTap: () {
                  //Go to settings page
                  Navigator.pushNamed(context, 'settingspage');
                }),

            //List tile for workout routines
            ListTile(
                leading: Icon(Icons.more_time_rounded),
                title: Text("Preset Exercise"),
                onTap: () {
                  //Return to home page
                })
          ])),

      //Create a button for adding exercises
      floatingActionButton: FloatingActionButton(
          onPressed: createExercise,
          backgroundColor: Colors.teal,
          child: Icon(
            Icons.more_time_rounded,
            size: 20,
            color: Colors.white,
          )),

      //Display the exercises that are added by the user
      body: ListView.builder(
          itemCount: exercise_list.length,
          itemBuilder: (context, index) {
            return exercise_list[index];
          }),

        /**
         * body: Column - Creates columns containing multiple children vertically
         * body: Row - Creates rows containing multiple children horizontally
         * body: Listview - Similar to Column/Row but allows scrolling through screen if children size overflows the screen
         * body: Stack - stacks children on top of one another
         */
        /*body: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly, //Aligns main axis of children accordingly
          //crossAxisAlignment: CrossAxisAlignment.start, //Aligns cross axis of children accordingly
          scrollDirection: Axis.vertical, //Specify which direction to scroll when body: Listview
          children: [
            //1st Box
            Expanded( //Automatically resize child to fill screen
              flex: 2,  //Specify size of child compared to other child (ex. 2 = double in size)
              child: Container(
                  height: 500,
                  color: Colors.teal[600],
                ),
            ),

            //2nd Box
            Expanded( //Automatically resize child to fill screen
              child: Container(
                height: 300,
                color: Colors.teal[400],
              ),
            ),
            //3rd Box
            Expanded( //Automatically resize child to fill screen
              child: Container(
                height: 200,
                color: Colors.teal[200],
              ),
            ),
          ]

        ),*/

        /**
         * ListView.builder or GridView.builder can be used to create instances on demand
         */
        /*body: ListView.builder(
            itemCount: names.length,  //Specify how many instances to create
            itemBuilder: (context, index) => ListTile(
              title: Text(names[index]),
            )
        ),*/

        /*body: GridView.builder(
          itemCount: 20,  //Specify how many instances to create
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), //Specify how many grid in each row
          itemBuilder: (context, index) => Container(
            color: Colors.teal[600],
            margin: EdgeInsets.all(2),  //Specify spacing between each container
            child: IconButton(onPressed:null, icon: Icon(Icons.access_time, color: Colors.black, size: 65)),
          )
      ),*/
        );
  }
}