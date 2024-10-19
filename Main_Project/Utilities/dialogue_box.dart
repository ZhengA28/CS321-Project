import 'package:flutter/material.dart';
import 'package:tutorial_project/Utilities/button.dart';

///Class for creating Dialogue Boxes
class DialogueBox extends StatelessWidget {
  final controller; //controller to recieve user input
  const DialogueBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: Colors.teal[300],
        content: Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
            ),

            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextField(  //
                    controller: controller,
                      decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter name of exercise",
                      )
                  ),

                  //Create row for Save and Cancel button
                  Row(
                    children: [
                      //Save Button
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Button(text: "Save", onPressed: () {}),
                        ),
                      ),

                      //Cancel Button
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Button(text: "Cancel", onPressed: () {}),
                        ),
                      ),
                    ],
                  )
                ])));
  }
}
