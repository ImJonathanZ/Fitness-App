import 'package:flutter/material.dart';
import '../model/picker.dart';
import '../model/exercises/exercise.dart';

//page to add workouts
class Add extends StatefulWidget {
  Add({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  ////TESTER
  List<Exercise> exerciseList;
  Exercise ex1 = Exercise(
      //add: Add(),
      date: 'Monday',
      category: 'Arms',
      exerciseName: 'Bicep Curls',
      sets: 3,
      reps: 10);
  ////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Picker(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //ADD EXERCIESE AND IMPLEMENT PICKER
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
