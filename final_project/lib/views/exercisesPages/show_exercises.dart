import 'package:final_project/model/DBUtils.dart';
import 'package:final_project/model/exercises/exercise.dart';
import 'package:final_project/model/exercises/exerciseModel.dart';
import 'package:final_project/views/exercisesPages/show_add.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'package:final_project/model/notifications.dart';

class DisplayExercises extends StatefulWidget {
  DisplayExercises({Key key, this.title, this.passedCategory})
      : super(key: key);

  final String title, passedCategory;

  @override
  _DisplayExercisesState createState() => _DisplayExercisesState();
}

class _DisplayExercisesState extends State<DisplayExercises> {
  List<Exercise> exerciseList;
  ExerciseModel _model = ExerciseModel();
  String categoryToFilter;
  bool didAdd = false; //checks if the user has added an exercise
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _notification = Notifications();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    _notification.init();
    reload();
  }

  //reloads database
  void reload() {
    DBUtils.init().then((_) {
      _model.getAllEvents().then((exercises) {
        setState(() {
          if (widget.passedCategory != null) {
            categoryToFilter = widget.passedCategory;
          }
          exerciseList = _createListByCategory(exercises, categoryToFilter);
        });
      });
    });
  }

//Deletes an exercise that is selected
  Future<void> _deleteExercise(int id) async {
    await _model.deleteByID(id);
    reload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          IconButton(
            icon: Icon(Icons.timer_outlined, color: Colors.white, size: 30),
            tooltip: "Timer",
            onPressed: () async {
              //Sends a notification to users when they start the timer and another notification when they need to do their next set
              await _notification.sendNotificationNow(
                  "Timer Started! ", "You have a 60 second rest", "Come Back!");
              var when =
                  tz.TZDateTime.now(tz.local).add(const Duration(seconds: 60));
              await _notification.sendNotificationLater("Times Up! ",
                  "Its time for your next set", when, "Come Back!");
            },
          )
        ],
      ),
      body: buildExerciseList(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //Shows add exercise screen then it will show the snackbar to confirm
        onPressed: () {
          _addExercise(context);
        },
        tooltip: "Add new exercise",
      ),
    );
  }

  //Builds a list of exercises
  Widget buildExerciseList(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext conext, int index) {
        return Container(
            child: GestureDetector(
          child: ListTile(
            title: Text(exerciseList[index].exerciseName),
            subtitle: Text(
                '${exerciseList[index].sets} sets of ${exerciseList[index].reps}'),
          ),
          onLongPress: () {
            _deleteExercise(exerciseList[index].id);
          },
        ));
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: exerciseList != null ? exerciseList.length : 0,
    );
  }

  //Will change to new page and then add the exercise to the database.
  Future<void> _addExercise(BuildContext context) async {
    var addedSnackbar = SnackBar(
      content: Text('Exercise Added'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          _deleteExercise(exerciseList[exerciseList.length - 1].id);
        },
      ),
    );
    var newExercise = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (__) => new Add(
                  title: "Add Exercice",
                  passedCategory: widget.passedCategory,
                )));
    if (newExercise != null) {
      _scaffoldKey.currentState.showSnackBar(addedSnackbar);
      _model.insertExercise(newExercise);
    }
    reload();
  }

  //Will check the category of every instance to see where to add each exercise
  List<Exercise> _createListByCategory(
      List<Exercise> list, String categoryCheck) {
    List<Exercise> newList = [];

    for (int i = 0; i < list.length; i++) {
      if (list[i].category.toLowerCase() == categoryCheck.toLowerCase()) {
        newList.add(list[i]);
      }
    }
    return newList;
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
                "On this page are the you will see all the workouts that you need to finish for today. Click the add button at the top to add more!\n\nDon't worry if you add one by accident. Just long press an exercise or hit undo.\n\nPress the timer to time a rest of 60 seconds."),
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
