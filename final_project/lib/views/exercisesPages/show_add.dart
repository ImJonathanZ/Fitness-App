import 'package:flutter/material.dart';
import 'package:final_project/model/exercises/exercise.dart';
import 'package:final_project/model/picker.dart';
import 'package:numberpicker/numberpicker.dart';

//page to add workouts using forms
class Add extends StatefulWidget {
  Add({Key key, this.title, this.passedCategory}) : super(key: key);

  final String title, passedCategory;

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  final _formKey = GlobalKey<FormState>();
  String _name;
  int _reps = 10, _sets = 3, _id;
  NumberPicker integerNumberPicker;
  //Shows the picker to pick the amount of sets
  Future _showSetsDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          step: 1,
          initialIntegerValue: 3,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _sets = value);
      }
    });
  }

  //Displays the picker to pick amount of reps
  Future _showRepsDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 100,
          step: 1,
          initialIntegerValue: 10,
        );
      },
    ).then((num value) {
      if (value != null) {
        setState(() => _reps = value);
      }
    });
  }

  Widget build(BuildContext context) {
    String _category = widget.passedCategory;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add an exercise"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.help_outline,
                size: 30,
              ),
              onPressed: () {
                _showHelp(context);
              },
              tooltip: 'Tutorial',
            ),
          ],
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              ListTile(
                title: Text("Category: $_category"),
              ),
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
                    setState(() => _name = value);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      child: Row(
                    children: [
                      Text("Sets"),
                      Container(
                        width: 10,
                      ),
                      RaisedButton(
                        child: (Text("$_sets")),
                        onPressed: _showSetsDialog,
                      ),
                    ],
                  )),
                  Container(
                      child: Row(
                    children: [
                      Text("Reps"),
                      Container(
                        width: 10,
                      ),
                      RaisedButton(
                        child: (Text("$_reps")),
                        onPressed: _showRepsDialog,
                      ),
                    ],
                  )),
                ],
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();

              Exercise newExercise = Exercise(
                  id: _id,
                  date: "None",
                  category: _category,
                  exerciseName: _name,
                  sets: _sets,
                  reps: _reps);

              Navigator.of(context).pop(newExercise);
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  //Shows a dialog to tell user about the page
  void _showHelp(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Need help?'),
          content: SingleChildScrollView(
            child: Text(
                "On this page you will be able to add your own workout.\n\nPlease enter the name of an exercise and choose number of sets and reps."),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Thanks!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
