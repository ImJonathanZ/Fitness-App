import 'package:final_project/model/category_workouts.dart';
import 'package:final_project/model/exercises/exercise.dart';
import 'package:final_project/model/exercises/exerciseModel.dart';
import 'package:final_project/model/utils.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Charts extends StatefulWidget {
  Charts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShowChart createState() => _ShowChart();
}

class _ShowChart extends State<Charts> {
  ExerciseModel model = ExerciseModel();

  ListCategoryWorkout workout;

  // the workouts list given to the chart
  List<Exercise> workouts = [
    Exercise(
        date: toDateString(DateTime.now()),
        category: 'Arms',
        exerciseName: 'Bicep Curls',
        sets: 3,
        reps: 10),
    Exercise(
        date: toDateString(DateTime.now()),
        category: 'Legs',
        exerciseName: 'Leg Press',
        sets: 2,
        reps: 10),
    Exercise(
        date: toDateString(DateTime.now()),
        category: 'Back',
        exerciseName: 'Excerise',
        sets: 2,
        reps: 10),
    Exercise(
        date: toDateString(DateTime.now()),
        category: 'Abs',
        exerciseName: 'Excerise',
        sets: 2,
        reps: 10),
    Exercise(
        date: toDateString(DateTime.now()),
        category: 'Cardio',
        exerciseName: 'Excerise',
        sets: 2,
        reps: 10)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text('Workouts for the Week'),
      ),
      body: buildCategoryChart(),
    );
  }

  // creates a chart for the number of sets done for each category of workouts
  Widget buildCategoryChart() {
    workout = ListCategoryWorkout();
    // database
    //workout.initializeDataModel(model);

    // given workouts list
    workout.initializeData(workouts);

    // displays a message if there is no data entered by the user
    if (workout.workouts == null) {
      return Center(
        child: Container(
          padding: EdgeInsets.all(5),
          height: 150,
          color: Colors.black,
          child: Card(
            color: Colors.red[900],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      AssetImage('assets/images/workout-image2.png'),
                ),
                Text(
                  'You have no workout logs!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return ListView(
        padding: EdgeInsets.only(
          top: 20,
        ),
        children: <Widget>[
          Center(
            child: Container(
              width: 250,
              height: 250,
              padding: EdgeInsets.only(top: 20),
              child: charts.BarChart(
                [
                  new charts.Series<CategoryWorkout, String>(
                    id: 'Number of workouts for each category',
                    domainFn: (CategoryWorkout exercise, _) =>
                        exercise.category,
                    measureFn: (CategoryWorkout exercise, _) => exercise.sets,
                    data: workout.workouts,
                    seriesColor:
                        charts.ColorUtil.fromDartColor(Colors.red[900]),
                  ),
                ],
                animate: true,
                vertical: true,
              ),
            ),
          ),
          // creates a table using the chart
          Center(
            child: Container(
              padding: EdgeInsets.only(top: 35),
              child: Container(
                  width: 230,
                  height: 45 * (workout.workouts.length.toDouble()),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: workout.buildTable()),
            ),
          ),
        ],
      );
    }
  }
}
