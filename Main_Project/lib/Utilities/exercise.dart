import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'custom_timer.dart';
import 'dart:async';

class Exercise extends StatefulWidget {
  final String name; //Name of the exercise
  final Duration duration; //
  Duration remaining_time;
  Function(BuildContext)? deleteExercise;
  Function(BuildContext)? completeExercise;

  ///Constructor
  Exercise({super.key,
    required this.name,
    required this.duration,
    required Function(dynamic context) this.deleteExercise,
    required Function(dynamic context) this.completeExercise}
      ) : remaining_time = duration;

  @override
  State<Exercise> createState() => Exercise_State();
}

class Exercise_State extends State<Exercise> {
  bool playButton = false;
  Timer? time;
  bool is_running = false; //is the timer currently running


  ///Return name of exercise
  String getName() {
    return widget.name;
  }

  ///Start the timer
  void start() {
    if (!is_running && widget.remaining_time.inSeconds > 0) {
      print("Hello");
      is_running = true;
      time = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (widget.remaining_time.inSeconds <= 0) {
          timer.cancel();
          is_running = false;
        }
        else {
          setState(() {
            widget.remaining_time -= const Duration(seconds: 1);
          });
        }
      });
    }
  }

  ///Pause the timer
  void Pause(){
    time?.cancel();
    is_running = false;
    //widget.remaining_time = widget.duration;
  }

  ///Display the time
  String getTime(){
    if (widget.remaining_time.inSeconds - (widget.remaining_time.inMinutes * 60) < 10){
      return widget.remaining_time.inMinutes.toString() +
          " : 0" +
          (widget.remaining_time.inSeconds - (widget.remaining_time.inMinutes * 60)).toString();
    }
    return widget.remaining_time.inMinutes.toString() +
        " : " +
        (widget.remaining_time.inSeconds - (widget.remaining_time.inMinutes * 60)).toString();
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
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          playButton = !playButton;

                          if(playButton){
                            start();
                          }
                          else {
                            Pause();
                          }
                        });
                      },
                      icon: Icon(playButton ? Icons.pause_circle : Icons.play_circle),
                      iconSize: 50,
                      color: Colors.black,)
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

