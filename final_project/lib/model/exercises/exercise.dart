class Exercise {
  String date, category, exerciseName;
  int sets, reps;

  Exercise({this.date, this.category, this.exerciseName, this.sets, this.reps});

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      'category': this.category,
      'exerciseName': this.exerciseName,
      'sets': this.sets,
      'reps': this.reps,
    };
  }

  Exercise.fromMap(Map<String, dynamic> map) {
    this.date = map['date'];
    this.category = map['category'];
    this.exerciseName = map['exerciseName'];
    this.sets = map['sets'];
    this.reps = map['reps'];
  }

  @override
  String toString() {
    return 'Date: $date, Category: $category, Exercise: $exerciseName, Sets: $sets, Reps: $reps';
  }
}
