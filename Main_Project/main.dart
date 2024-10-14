import 'package:flutter/material.dart';

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
      home: Scaffold( //Contains content on screen
        backgroundColor: Colors.black54,

        //Creates a bar at top of app
        appBar: AppBar(
          title: Center(
            child: Text("FlexTimer",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          backgroundColor: Colors.teal[700],
          //elevation: 0, //If elevation set to 0, removes app bar shadow
          leading: Icon(Icons.menu),  //Creates Icon on left hand side
          actions: [IconButton(onPressed: null, icon: Icon(Icons.add, color: Colors.black54))],  //Create icon on right hand side
        ),

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
              flex: 2,  //Specifcy size of child compared to other child (ex. 2 = double in size)
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
            itemCount: names.length,  //Specify how mnay instances to create
            itemBuilder: (context, index) => ListTile(
              title: Text(names[index]),
            )
        ),*/
        body: GridView.builder(
            itemCount: 20,  //SPecify how many instances to create
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), //Specify how many grid in each row
            itemBuilder: (context, index) => Container(
              color: Colors.teal[600],
              margin: EdgeInsets.all(2),  //Specify spacing between each container
              child: IconButton(onPressed:null, icon: Icon(Icons.access_time, color: Colors.black, size: 65)),
            )
        ),

        //Create body containing a centered widget
        /*body: Center (  //Centers containing widgets
          child: Container(
            height: 300,
            width: 300,

            decoration: BoxDecoration(
              color: Colors.teal[700],
              borderRadius: BorderRadius.circular(20),  //Curves the container edge
            ),

            padding: EdgeInsets.all(50),  //Creates padding for text

            //GestureDetector for detecting screen taps
            /*child: GestureDetector(
              onTap: (){
                time++;
                print("Time: $time");
              },
              child: IconButton(onPressed: null, icon: Icon(Icons.access_time, color: Colors.white, size: 65)),
            ),*/

            //Creating Text child
            /*child: Text(
                "Welcome to Flextimer",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
              ),
            ),*/

          ),
        ),*/
      ),
    );

  }
}