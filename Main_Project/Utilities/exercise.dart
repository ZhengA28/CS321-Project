import 'package:flutter/material.dart';
import 'package:tutorial_project/Utilities/custom_timer.dart';

class Exercise extends StatelessWidget{

  final String name;
  Custom_Timer timer;

  Exercise(this.name, Duration time) : timer = Custom_Timer(time){
    super.key;
  }

  /*
  Return the name of exercise
   */
  String getName(){
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0), //Create padding around each child

      child: Container(
        padding: EdgeInsets.all(20.0),  //Create padding within the container
        decoration: BoxDecoration(
          color: Colors.teal[800],  //Set container color
          borderRadius: BorderRadius.circular(15),  //Curve the corner of each container
        ),

        child: Row(
          children: [
            Expanded(
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text('$name')
                )
            ),

            Expanded(
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text(timer.getDuration().inMinutes.toString() + " : " + timer.getDuration().inSeconds.toString())
                )
            )
          ],
        ),
      )
    );
  }
}