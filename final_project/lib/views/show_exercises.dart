import 'package:final_project/model/DBUtils.dart';
import 'package:final_project/model/exercises/exercise.dart';
import 'package:final_project/model/exercises/exerciseModel.dart';
import 'package:flutter/material.dart';

class DisplayExercises extends StatefulWidget {
  DisplayExercises({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DisplayExercisesState createState() => _DisplayExercisesState();
}

class _DisplayExercisesState extends State<DisplayExercises> {
  var addedSnackbar = SnackBar(
    content: Text('Exercise Added'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        //ToDo: Undo adding
      },
    ),
  );
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  var loggedSnackbar = SnackBar(
    content: Text('Today was logged to the calendar'),
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        //ToDo: Undo adding
      },
    ),
  );
  List<Exercise> exerciseList;
  ExerciseModel _model = ExerciseModel();

  @override
  void initState() {
    super.initState();
    reload();
  }

  void reload() {
    DBUtils.init().then((_) {
      _model.getAllEvents().then((exercises) {
        setState(() {
          exerciseList = exercises;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(addedSnackbar);
              //Todo:  show add exercise screen
              reload();
            },
            tooltip: "Add new exercise",
          ),
          IconButton(
            icon: Icon(Icons.article),
            tooltip: 'Log that you worked out today',
            onPressed: () {
              _scaffoldKey.currentState.showSnackBar(loggedSnackbar);
              //todo: Add todays date to database / add workouts to database to log current day
            },
          ),
        ],
      ),
      body: buildExerciseList(context),
    );
  }

  //Todo: Need to filter specific category
  Widget buildExerciseList(BuildContext context) {
    return ListView.separated(
      itemBuilder: (BuildContext conext, int index) {
        return ListTile(
          title: Text(exerciseList[index].exerciseName),
          subtitle: Text(
              '${exerciseList[index].sets} sets of ${exerciseList[index].reps}'),
          //leading: Add image that is selected by user here
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
      itemCount: exerciseList != null ? exerciseList.length : 0,
    );
  }
}
