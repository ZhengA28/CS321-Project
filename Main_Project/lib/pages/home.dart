import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tutorial_project/Database/local_data.dart';
import 'preset.dart';
import 'settings.dart';
import 'user_profile.dart';
import '../Utilities/exercise.dart';
import '../Utilities/dialogue_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final myBox = Hive.box('MyBox');
  LocalDatabase db = LocalDatabase();

  final text_controller = TextEditingController();
  final duration_controller = TextEditingController();
  List pages = [];
  int page_index = 0;

  void initState() {
    //Check if app open for first time
    if(myBox.get("EXERCISE") == null){
      db.initialData();
    }
    else{
      db.loadData();
    }

    super.initState();
    pages = [
      ProfilePage(),
      SettingsPage(),
      PresetPage(
        onAddExercise: (exerciseName) {
          createExercise(exerciseName: exerciseName);
        },
      ),
    ];
  }

  //List exercise_list = []; //Array to store created exercises

  ///Update the page index
  void updatePage(int index) {
    setState(() {
      page_index = index;
    });
  }

  ///Shows a dialogue box for user to create a new exercise
  void createExercise({String exerciseName = ''}) {
    text_controller.text = exerciseName;
    showDialog(
      context: context,
      builder: (context) {
        return DialogueBox(
          text_controller: text_controller,
          duration_controller: duration_controller,
          onSave: saveExercise, //Save new exercise
          onCancel: () => Navigator.of(context).pop(), //Close dialogue box
        );
      },
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.exercise_List.removeAt(index);
    });
    db.updateData();
  }

  void completeTask(index) {
    setState(() {
      List temp = db.exercise_List[index];
      db.exercise_List.removeAt(index);
      db.exercise_List.add(temp);
    });
    db.updateData();
  }

  ///Creates a new exercise object and add it to the list
  void saveExercise() {
    setState(() {
      db.exercise_List.add([text_controller.text, duration_controller.text]);

      //Clear the text box
      text_controller.clear();
      duration_controller.clear();
    });
    Navigator.of(context).pop(); //Closes dialogue box after adding to list
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Creates a bar at top of app
      appBar: AppBar(
        title: Center(
          child: Text(
            "FlexTimer",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        backgroundColor: Colors.teal[700],
        //elevation: 0, //If elevation set to 0, removes app bar shadow

        actions: const [
          IconButton(
              onPressed: null, icon: Icon(Icons.add, color: Colors.black54))
        ], //Create icon on right hand side
      ),

      //Creates a drawer (menu) on left hand side
      drawer: Drawer(
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

        //List tile for preset exercise
        ListTile(
            leading: Icon(Icons.more_time_rounded),
            title: Text("P R E S E T"),
            onTap: () {
              //Return to home page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PresetPage(
                    onAddExercise: (exerciseName) {
                      createExercise(exerciseName: exerciseName);
                    },
                  ),
                ),
              );
            }),

        //List tile for user profile
        ListTile(
            leading: Icon(Icons.account_circle),
            title: Text("P R O F I L E"),
            onTap: () {
              //Go to user profile page
              Navigator.pushNamed(context, 'profilepage');
            }),
        //List tile for settings
        ListTile(
            leading: Icon(Icons.settings),
            title: Text("S E T T I N G S"),
            onTap: () {
              //Go to settings page
              Navigator.pushNamed(context, 'settingspage');
            }),
      ])),

      //Create a button for adding exercises
      floatingActionButton: FloatingActionButton(
          onPressed: createExercise,
          backgroundColor: Colors.teal,
          child: Icon(Icons.more_time_rounded, size: 20)),

      //Display the exercises that are added by the user
      body: ListView.builder(
          itemCount: db.exercise_List.isEmpty ? 1 : db.exercise_List.length,
          itemBuilder: (context, index) {
            if (db.exercise_List.isEmpty) {
              return Center(
                  child: Text("No Exercise in Current Workout Plan",
                      style: TextStyle(fontSize: 20)));
            } else {
              return Exercise(
                  name: db.exercise_List[index][0],
                  duration:
                      Duration(seconds: int.parse(db.exercise_List[index][1])),
                  deleteExercise: (context) => deleteTask(index),
                  completeExercise: (context) => completeTask(index));
            }
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
