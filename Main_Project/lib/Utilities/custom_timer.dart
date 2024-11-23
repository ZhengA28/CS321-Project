import 'dart:async';
import 'package:flutter/material.dart';

class Custom_Timer{
  Duration duration;  //time that the timer is set to
  Duration remaining_time;  //remaining time of the timer
  bool is_running = false;  //is the timer currently running

  Timer? time;
  //Constructor
  Custom_Timer(this.duration):
    remaining_time = duration;

  /**
   * Start the timer
   */
  void start(){
    if (!is_running && remaining_time.inSeconds > 0){
      is_running = true;
      time = Timer.periodic(const Duration(seconds: 1), (timer){
        if (remaining_time.inSeconds <=0) {
          timer.cancel();
          is_running = false;
        }
        else{
          remaining_time -= const Duration(seconds: 1);
        }
      });

    }
  }

  /**
   * Pause the timer if it is running
   */
  void pause(){

  }

  /**
   * Stop timer and reset its duration
   */
  void stop(){

  }

  /**
   * Resume timer if it is not running
   */
  void resume(){

  }

  /**
   * Return the duration that the timer is set to
   */
  Duration getDuration(){
    return duration;
  }


}
