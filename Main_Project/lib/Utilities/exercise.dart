import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'custom_timer.dart';

class Exercise extends StatefulWidget {
  final String name; //Name of the exercise
  Custom_Timer timer; //
  Function(BuildContext)? deleteExercise;
  Function(BuildContext)? completeExercise;

  ///Constructor
  Exercise({super.key,
    required this.name,
    required Duration time,
    required Function(dynamic context) this.deleteExercise,
    required Function(dynamic context) this.completeExercise})
      : timer = Custom_Timer(time);

  @override
  State<Exercise> createState() => Exercise_State();
}

class Exercise_State extends State<Exercise> {
  ///Return name of exercise
  String getName() {
    return widget.name;
  }

  ///Display the current time
  String getTime(){
    if (widget.timer.getDuration().inSeconds - (widget.timer.getDuration().inMinutes * 60) < 10){
      return widget.timer.getDuration().inMinutes.toString() +
          " : 0" +
          (widget.timer.getDuration().inSeconds - (widget.timer.getDuration().inMinutes * 60)).toString();
    }
    return widget.timer.getDuration().inMinutes.toString() +
        " : " +
        (widget.timer.getDuration().inSeconds - (widget.timer.getDuration().inMinutes * 60)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(
          //Create padding around screen border
            left: 20.0,
            right: 20.0,
            top: 20.0),
        //Make the container slide left and right for options
        child: Slidable(
          endActionPane: ActionPane(  //Slide the container left to delete
              motion: StretchMotion(),
              children: [
                SlidableAction(
                    onPressed: widget.deleteExercise,
                    icon: Icons.delete_forever,
                    backgroundColor: Colors.red.shade400,
                    borderRadius: BorderRadius.circular(15))
              ]),

          startActionPane: ActionPane(  //Slide the container right to complete exercise
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: widget.completeExercise,
                  icon: Icons.check_circle,
                  backgroundColor: Colors.green.shade400,
                  borderRadius: BorderRadius.circular(15),)
              ]),

          child: Container(
            padding: EdgeInsets.all(20.0), //Create padding within the container
            decoration: BoxDecoration(
              color: Colors.teal[800], //Set container color
              borderRadius: BorderRadius.circular(
                  15), //Curve the corner of each container
            ),

            child: Row(
              children: [
                Expanded(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ))),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                  )
                ),
                Expanded(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                                child: Padding(
                                  //Add padding to right of icon
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(Icons.access_time,
                                        color: Colors.white))),
                            TextSpan(
                              //Text to display the duration of timer
                                text: getTime(),
                                style:
                                TextStyle(fontSize: 20, color: Colors.white)),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ));
  }

}

