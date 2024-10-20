import 'package:flutter/material.dart';
import 'package:tutorial_project/Utilities/custom_timer.dart';

class Exercise extends StatelessWidget {
  final String name; //Name of the exercise
  Custom_Timer timer; //

  //Constructor
  Exercise(this.name, Duration time) : timer = Custom_Timer(time) {
    super.key;
  }

  /**
   * Return the name of exercise
   */
  String getName() {
    return name;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( //Create padding around screen border
          left: 20.0,
          right: 20.0,
          top: 20.0),

      child: Container(
        padding: EdgeInsets.all(20.0), //Create padding within the container
        decoration: BoxDecoration(
          color: Colors.teal[800], //Set container color
          borderRadius:
              BorderRadius.circular(15), //Curve the corner of each container
        ),

        child: Row(
          children: [
            Expanded(
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      '$name',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ))),

            Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(child: Padding(  //Add padding to right of icon
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(Icons.access_time, color: Colors.white))
                        ),

                        TextSpan( //Text to display the duration of timer
                            text: timer.getDuration().inMinutes.toString() +
                            " : " +
                            timer.getDuration().inSeconds.toString(),
                            style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
