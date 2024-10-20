import 'package:flutter/material.dart';
import 'button.dart';

///Class for creating Dialogue Boxes
class DialogueBox extends StatelessWidget {
  //Controllers to receive user input
  final text_controller;
  final duration_controller;

  VoidCallback onSave;
  VoidCallback onCancel;

  DialogueBox(
      {super.key,
      required this.text_controller,
      required this.duration_controller,
      required this.onSave,
      required this.onCancel});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.teal[300],
        content: Container(
            height: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(  //Create textbox to get exercise name
                      //
                      controller: text_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter name of exercise",
                      )),

                  TextField(//Create textbox to get exercise duration
                      //
                      controller: duration_controller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Enter the time in seconds",
                      )),

                  //Create row for Save and Cancel button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Cancel Button
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Button(text: "Cancel", onPressed: onCancel),
                          ),
                        ),
                      ),

                      //Save Button
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Button(text: "Save", onPressed: onSave),
                          ),
                        ),
                      ),
                    ],
                  )
                ])));
  }
}
