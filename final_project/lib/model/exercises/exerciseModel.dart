import 'package:final_project/model/exercises/exercise.dart';
import 'package:sqflite/sqflite.dart';
import 'package:final_project/model/DBUtils.dart';

class EventModel {
  Future<void> insertGrade(Event event) async {
    final db = await DBUtils.init();
    db.insert(
      'event_items',
      event.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Event>> getAllEvents() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('event_items');
    List<Event> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(Event.fromMap(maps[i]));
      }
    }

    return result;
  }
}
