import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'fitness.db'),
      onCreate: (db, version) {
        db.execute(
            "CREATE TABLE exercise_items(id INTEGER PRIMARY KEY, date TEXT NOT NULL, category TEXT NOT NULL, exerciseName TEXT NOT NULL, sets INTEGER NOT NULL, reps INTEGER NOT NULL)");
        //db.execute(
        // "CREATE TABLE event_items(id INTEGER PRIMARY KEY, date TEXT NOT NULL, category TEXT NOT NULL, exerciseName TEXT NOT NULL, sets INTEGER NOT NULL, reps INTEGER NOT NULL)");
      },
      version: 1,
    );
    return database;
  }
}
