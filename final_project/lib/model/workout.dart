import 'package:cloud_firestore/cloud_firestore.dart';

//Class that represents a specific workout
class Workout {
  String category;
  String workout;
  String description;
  String image;
  List<String> day;
  DocumentReference reference;

  Workout(
      {this.category, this.workout, this.description, this.image, this.day});

  String workoutDays() {
    String d = '';
    for (int i = 0; i < day.length; i++) {
      d = d + '  ${day[i]}';
    }
    return d;
  }

  Workout.fromMap(Map<String, dynamic> map, {this.reference}) {
    this.category = map['category'];
    this.workout = map['workout'];
    this.description = map['description'];
    this.image = map['image'];
    //this.day = map['day'];
  }
}
