import 'package:final_project/model/DBUtils.dart';
import 'package:final_project/model/exercises/exercise.dart';
import 'package:final_project/model/exercises/exerciseModel.dart';
import 'package:final_project/model/workout.dart';
import 'package:final_project/views/exercisesPages/show_add.dart';
import 'package:flutter/material.dart';
import 'package:final_project/model/utils.dart';

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
  bool didAdd = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    reload();
  }

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
        return ListTile(
          title: Text(exerciseList[index].exerciseName),
          subtitle: Text(
              '${exerciseList[index].sets} sets of ${exerciseList[index].reps}'),
        );
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
                "On this page are the you will see all the workouts that you need to finish for today. Click the add button at the top to add more!\n\nDon't worry if you add by accident."),
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
