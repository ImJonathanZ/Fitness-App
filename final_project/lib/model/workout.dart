class Workout {
  String category;
  String workout;
  List<String> day;

  Workout({this.category, this.workout, this.day});

  String workoutDays() {
    String d = '';
    for (int i = 0; i < day.length; i++) {
      d = d + '  ${day[i]}';
    }
    return d;
  }
}
