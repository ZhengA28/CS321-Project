import 'dart:async';
import 'package:flutter/material.dart';

class Custom_Timer extends StatefulWidget {
  Duration duration; //time that the timer is set to
  Duration remaining_time; //remaining time of the timer

  ///Constructor
  Custom_Timer(this.duration) :
        remaining_time = duration;

  @override
  State<Custom_Timer> createState() => Timer_State();
}

class Timer_State extends State<Custom_Timer> {
  Timer? time;
  bool is_running = false; //is the timer currently running

  /**
   * Start the timer
   */
  void start(){
    if (!is_running && widget.remaining_time.inSeconds > 0){
      print("Hello");
      is_running = true;
      time = Timer.periodic(const Duration(seconds: 1), (timer){
        if (widget.remaining_time.inSeconds <=0) {
          timer.cancel();
          is_running = false;
        }
        else{
          setState(() {
            widget.remaining_time -= const Duration(seconds: 1);
          });

        }
      });

    }
  }

  /**
   * Stop timer and reset its duration
   */
  void stop(){
    time?.cancel();
    is_running = false;
    widget.remaining_time = widget.duration;
  }

  /**
   * Resume timer if it is not running
   */
  void resume(){
    if (!is_running && widget.remaining_time.inSeconds > 0) {
      start();
    }
  }

  /**
   * Return the duration that the timer is set to
   */
  Duration getDuration(){
    return widget.duration;
  }

  ///Display the current time
  String getTime(){
    if (getDuration().inSeconds - (getDuration().inMinutes * 60) < 10){
      return getDuration().inMinutes.toString() +
          " : 0" +
          (getDuration().inSeconds - (getDuration().inMinutes * 60)).toString();
    }
    return getDuration().inMinutes.toString() +
        " : " +
        (getDuration().inSeconds - (getDuration().inMinutes * 60)).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Text('Countdown: $time');
  }
}
