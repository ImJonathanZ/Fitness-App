import 'package:flutter/material.dart';
import 'exercises/exercise.dart';
import 'exercises/exerciseModel.dart';

class CategoryWorkout {
  String category;
  int sets;

  CategoryWorkout({this.category, this.sets});
}

class ListCategoryWorkout {
  List<CategoryWorkout> workouts = List<CategoryWorkout>();
  int totalSets = 0;

  ListCategoryWorkout({this.workouts});

  Future<void> initializeDataModel(ExerciseModel model) async {
    List<Exercise> e = await model.getAllEvents();
    final map = <String, int>{};
    for (int i = 0; i < e.length; i++) {
      map[e[i].category] = map.containsKey(e[i].category)
          ? map[e[i].category] + (e[i].sets * e[i].reps)
          : (e[i].sets * e[i].reps);
    }

    List<CategoryWorkout> w = List<CategoryWorkout>();

    map.forEach((key, value) {
      print('Key: $key, Value: $value');
      w.add(CategoryWorkout(category: key, sets: value));
    });

    workouts = w;

    print('Workouts list');
    for (int i = 0; i < workouts.length; i++) {
      print(workouts[i].category);
    }
  }

  // added values from List
  void initializeData(List<Exercise> e) {
    final map = <String, int>{};
    for (int i = 0; i < e.length; i++) {
      map[e[i].category] = map.containsKey(e[i].category)
          ? map[e[i].category] + (e[i].sets * e[i].reps)
          : (e[i].sets * e[i].reps);
    }

    List<CategoryWorkout> w = List<CategoryWorkout>();

    map.forEach((key, value) {
      w.add(CategoryWorkout(category: key, sets: value));
    });

    workouts = w;
  }

  Widget buildTable() {
    getTotalWorkouts();
    return DataTable(
      columnSpacing: 28,
      dataRowHeight: 30,
      columns: <DataColumn>[
        DataColumn(
          label: Text(
            'Category',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        DataColumn(
          label: Text(
            'Workouts(%)',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
      rows: workouts
          .map((CategoryWorkout workout) => DataRow(cells: <DataCell>[
                DataCell(Text(
                  workout.category,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
                DataCell(Container(
                    padding: EdgeInsets.only(right: 5),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${((workout.sets / totalSets) * 100).toInt()}%',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ))),
              ]))
          .toList(),
    );
  }

  void getTotalWorkouts() {
    for (int i = 0; i < workouts.length; i++) {
      totalSets = totalSets + workouts[i].sets;
    }
  }
}
