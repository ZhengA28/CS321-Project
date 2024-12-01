//import 'package:url_launcher/link.dart';
import 'package:Main_Project/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:Main_Project/Utilities/preset_exercise.dart';

class PresetPage extends StatelessWidget {
  final Function(String) onAddExercise;
  const PresetPage({super.key, required this.onAddExercise});

  @override
  Widget build(BuildContext context) {
    State<HomePage> createState() => HomePageState();
    List<PresetExercise> presets = PresetExercise.getPresetExerciseList();
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        title: Center(
          child: const Text(
            "Preset Exercise",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        backgroundColor: Colors.teal[700],
      ),
      body: ListView.separated(
        itemCount: presets.length,
        itemBuilder: (context, index) {
          PresetExercise exercise = presets[index];
          return Container(
            color: Colors.teal,
            child:
            ExpansionTile(
              title: Text(
                exercise.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),

              ),
              textColor: Colors.white,
              leading: const Icon(Icons.fitness_center, color: Colors.white),
              //trailing: const Icon(Icons.menu, color: Colors.white),
              trailing: SizedBox(
                child:
                FloatingActionButton(
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  backgroundColor: Colors.blue,

                  onPressed: () {
                    onAddExercise(exercise.name);//TODO add exercise to home page when pressed
                  },
                  tooltip: "Add to Home",
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                width: 40,
                height: 40,



              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                          exercise.description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,)
                      ),
                      const SizedBox(height: 10),
                      /*
                      Link(
                          uri: Uri.parse(exercise.tutorial_url),
                          builder: (context, followLink) {
                            return TextButton(
                              onPressed: followLink,
                              child: Text(
                                "Watch Video",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.blue,
                                ),
                              ),
                            );

                          }
                      ),
                      */
                      Text(
                        "Watch Video",
                        style: TextStyle(
                          color: Colors.blue.shade400,
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue.shade400,
                        ),

                      ),
                      /*GestureDetector(
                          onTap: () {
                            _launchURL(context, exercise.tutorial_url);
                          },
                          child: const Text(
                            "Watch Tutorial",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),*/
                      /*FloatingActionButton(
                          tooltip:"Add to Home",
                          backgroundColor: Colors.blue ,
                          onPressed: () {},
                          child: Icon(
                              Icons.add,
                              size: 25,
                              color: Colors.white,
                          )
                        )*/
                    ],//Column Children
                  ),
                ),
              ],//ExpansionTile Children
            ),
          );
        },
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) => const Divider(
          color: Colors.white,

        ),
      ),
    );
  }

}
