import 'package:final_project/model/exercises/exercise.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_project/model/DBUtils.dart';

class ExerciseModel {
  Future<void> insertExercise(Exercise event) async {
    final db = await DBUtils.init();
    db.insert(
      'exercise_items',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Exercise>> getAllEvents() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('exercise_items');
    List<Exercise> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Exercise.fromMap(maps[i]));
      }
    }

    return result;
  }

  Future<void> deleteAllItems() async {
    final db = await DBUtils.init();

    db.delete('exercise_items');
  }

  Future<void> deleteById(int id) async {
    final db = await DBUtils.init();

    await db.delete('exercise_items', where: 'id = ?', whereArgs: [id]);
  }
}
