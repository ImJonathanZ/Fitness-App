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

  ListCategoryWorkout workout = ListCategoryWorkout();

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
        category: 'Core',
        exerciseName: 'Excerise',
        sets: 2,
        reps: 10)
  ];

  Exercise e1 = Exercise(
      date: toDateString(DateTime.now()),
      category: 'Arms',
      exerciseName: 'Bicep Curls',
      sets: 3,
      reps: 10);

  Exercise e2 = Exercise(
      date: toDateString(DateTime.now()),
      category: 'Legs',
      exerciseName: 'Leg Press',
      sets: 3,
      reps: 10);

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

  Widget buildWorkoutWeekChart() {
    return Center(
      child: Column(
        children: <Widget>[
          Container(
            width: 250,
            height: 250,
            child: charts.BarChart(
              [
                new charts.Series<CategoryWorkout, String>(
                  id: 'Votes Up',
                  domainFn: (CategoryWorkout exercise, _) => exercise.category,
                  measureFn: (CategoryWorkout exercise, _) => exercise.sets,
                  data: workout.workouts,
                ),
              ],
              animate: true,
              vertical: true,
            ),
          ),
          Container(),
        ],
      ),
    );
  }

  Widget buildCategoryChart() {
    // database
    workout.initializeDataModel(model);

    // given workouts list
    //workout.initializeData(workouts);
    if (workout.workouts == null) {
      return Center(
        child: Text('You have no workout logs!'),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
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
              Container(
                  width: 230,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: workout.buildTable()),
            ],
          ),
        ),
      );
    }
  }
}
