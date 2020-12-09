//import '../../views/show_add.dart';

class Exercise {
  String date, category, exerciseName;
  int sets, reps, id;
  //Add add;

  Exercise(
      { //this.add,
      this.id,
      this.date,
      this.category,
      this.exerciseName,
      this.sets,
      this.reps});

  Map<String, dynamic> toMap() {
    return {
      //'add': this.add,
      'id': this.id,
      'date': this.date,
      'category': this.category,
      'exerciseName': this.exerciseName,
      'sets': this.sets,
      'reps': this.reps,
    };
  }

  Exercise.fromMap(Map<String, dynamic> map) {
    //this.add = map['add'];
    this.id = map['id'];
    this.date = map['date'];
    this.category = map['category'];
    this.exerciseName = map['exerciseName'];
    this.sets = map['sets'];
    this.reps = map['reps'];
  }

  @override
  String toString() {
    return 'ID: $id, Date: $date, Category: $category, Exercise: $exerciseName, Sets: $sets, Reps: $reps';
  }
}
