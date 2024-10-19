import 'dart:async';

import 'package:flutter/material.dart';

class Custom_Timer{
  Duration duration;
  Duration remaining_time;
  bool is_running = false;

  Custom_Timer(this.duration):
    remaining_time = duration;

  Duration getDuration(){
    return duration;
  }


}