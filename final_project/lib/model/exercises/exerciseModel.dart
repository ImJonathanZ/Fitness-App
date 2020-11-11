import 'package:final_project/model/exercises/exercise.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_project/model/DBUtils.dart';

class ExerciseModel {
  Future<void> insertGrade(Exercise event) async {
    final db = await DBUtils.init();
    db.insert(
      'exercise',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Exercise>> getAllEvents() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('exercise');
    List<Exercise> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Exercise.fromMap(maps[i]));
      }
    }

    return result;
  }
}
