import 'package:flutter/material.dart';

class PresetExercise {
  final String name;
  final String description;
  final String tutorial_url;

  // Static list of preset exercises
  static final List<PresetExercise> _presetExerciseList = [
    PresetExercise("Alternating Dumbbell Curl", "Hold a dumbbell in each hand palms facing forward. Curl one dumbbell while keeping the other arm down. Lower slowly and repeat with the other arm.", "https://www.youtube.com/watch?v=iixND1P2lik&list=PLyqKj7LwU2Rt1cwOsHwdXa2TiRzjA6uoB"),
    PresetExercise('Dips','Grip the parallel bars with your arms straight and shoulders above your hands. Lower your body by bending your elbows until your upper arms are parallel to the ground. Push back up to the starting position and repeat.','https://www.youtube.com/watch?v=4LA1kF7yCGo&list=PLyqKj7LwU2RtMd8vP3NEoig1RPJQK78Ea&index=7'),
    PresetExercise('Flat Dumbbell Bench Press','Lie flat on a bench with a dumbbell in each hand, palms facing forward. Press the dumbbells upward until your arms are fully extended. Lower the dumbbells slowly to chest level and repeat.','https://www.youtube.com/watch?v=YQ2s_Y7g5Qk&list=PLyqKj7LwU2RuyZwWCIiDHuFZGN11QW3Ff&index=6'),
    PresetExercise('Lat Pull-down','Sit at a lat pull-down machine and grip the bar with palms facing away. Pull the bar down to your chest while keeping your back straight and elbows pointed downward. Slowly return to the starting position and repeat.','https://www.youtube.com/watch?v=EUIri47Epcg&list=PLyqKj7LwU2RsCtKw3UlE85HYgPM3-xoO1&index=16'),
    PresetExercise("Lateral Raise", "Stand with a dumbbell in each hand at your sides. Keep your arms straight and lift the dumbbells out to your sides until they reach should height, then lower weights slowly.",'https://www.youtube.com/watch?v=OuG1smZTsQQ&list=PLyqKj7LwU2RuNVJBl0CtfZdxQ99IhKCcu&index=5'),
    PresetExercise("Leg Extension", "Sit on the machine with your legs under the padded bar. Extend your legs straight out, then lower them back down while controlling the weight.", "https://www.youtube.com/watch?v=m0FOpMEgero&list=PLyqKj7LwU2RuAg-us4mzap6izNcc1fuRW&index=6"),
    PresetExercise("Hanging Knee Raise", "Hang form a pull-up bar with an overhand grip. Keep your legs together and lift your keens toward your chest and lower them back down.", "https://www.youtube.com/watch?v=RD_A-Z15ER4&list=PLyqKj7LwU2RvTgEW_QlCCjtIL5d_KP_-I&index=1"),
    PresetExercise("Machine Shoulder Press", "Sit on the shoulder press machine with your back against the pad. Grip the handles, press them upward util your arms are fully extended, then lower them back down.", "https://www.youtube.com/watch?v=WvLMauqrnK8&list=PLyqKj7LwU2RtjiVutSXk5uC2h7KVMu1Az&index=5"),
    PresetExercise("Push-ups", "Start in a plank position with your hands shoulder width apart. Lower your chest toward the floor while keeping your body straight, then push back up to the starting position.", "https://www.youtube.com/watch?v=mm6_WcoCVTA&list=PLyqKj7LwU2RuyZwWCIiDHuFZGN11QW3Ff&index=26"),
    PresetExercise("Plank","Start in a forearm plank position with elbows under shoulders and body in a straight line. Engage your core and hold the position without letting your hips sag or rise.","https://www.youtube.com/watch?v=Ff4_A3y7JR0&list=PLyqKj7LwU2RvTgEW_QlCCjtIL5d_KP_-I&index=10"),
    PresetExercise('Seated Cable Row','Sit at the cable row machine with your feet secured on the platform and knees slightly bent. Grab the handle with both hands, keeping your back straight. Pull the handle toward your torso, squeezing your shoulder blades together. Slowly extend your arms back to the starting position and repeat.','https://www.youtube.com/watch?v=UCXxvVItLoM&list=PLyqKj7LwU2RsCtKw3UlE85HYgPM3-xoO1&index=21'),
    PresetExercise("Seated Hamstring Curl","Sit on a hamstring curl machine with your legs under the padded bar. Pull the bar down by bending your knees until your legs are fully curled, then return to the starting position.",'https://www.youtube.com/watch?v=Orxowest56U&list=PLyqKj7LwU2Rvx_O313dzJNFKPiEqRMWiV&index=7'),
    PresetExercise("Squats","Stand with your feet shoulder-width apart. Lower your hips back down as if sitting into a chair, keeping your chest up and knees over your toes. Push through your heels to return to standing.",'https://www.youtube.com/watch?v=i7J5h7BJ07g&list=PLyqKj7LwU2RuAg-us4mzap6izNcc1fuRW&index=5'),
    PresetExercise("Smith Machine Squats","Position the barbell on your shoulders and stand with your feet shoulder-width apart under the Smith machine. Unlock the bar lower your hips back and down into a squat, keeping your chest up. Push through your heels to return to standing.",'https://www.youtube.com/watch?v=-eO_VydErV0&list=PLyqKj7LwU2RuAg-us4mzap6izNcc1fuRW&index=1'),

  ];

  // Getter for the preset exercise list
  static List<PresetExercise> getPresetExerciseList() {
    return _presetExerciseList;
  }

  PresetExercise(this.name, this.description, this.tutorial_url);
}
