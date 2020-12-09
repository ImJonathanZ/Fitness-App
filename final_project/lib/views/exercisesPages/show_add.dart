import 'package:flutter/material.dart';
import 'package:final_project/model/exercises/exercise.dart';
import 'package:final_project/model/picker.dart';

//page to add workouts
class Add extends StatefulWidget {
  Add({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    String _name, _category;
    int _reps, _sets;

    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add an exercise"),
        ),
        body: Container(
          child: Column(
            children: [
              ListTile(
                title: TextFormField(
                  decoration: InputDecoration(labelText: "Name of exercise"),
                  validator: (String value) {
                    if (value.length == 0) {
                      return "Need a name";
                    }
                    return null;
                  },
                  onSaved: (String value) {
                    _name = value;
                  },
                  controller: TextEditingController(text: _name),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
             if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                Exercise newExercise = Exercise(

                );
                

                Navigator.of(context).pop(newExercise);
              }
            },
          },
        ),
      ),
    );
  }
}
