import 'package:final_project/views/workouts/view_workouts.dart';
import 'package:flutter/material.dart';

class WorkoutListItem {
  IconData icon;
  String category;

  WorkoutListItem({this.icon, this.category});
}

class WorkoutList extends StatefulWidget {
  WorkoutList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WorkoutListState createState() => WorkoutListState();
}

class WorkoutListState extends State<WorkoutList> {
  @override
  List<WorkoutListItem> workouts = [
    WorkoutListItem(icon: Icons.fitness_center, category: 'Arms'),
    WorkoutListItem(icon: Icons.fitness_center, category: 'Legs'),
    WorkoutListItem(icon: Icons.fitness_center, category: 'Back'),
    WorkoutListItem(icon: Icons.fitness_center, category: 'Core'),
  ];

  var selectedCategory = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Workouts'),
      ),
      body: buildListView(context),
    );
  }

  Widget getIcon() {
    return Container(
      alignment: Alignment(1.5, -0.2),
      padding: EdgeInsets.only(left: 20),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white,
            child: Icon(Icons.fitness_center, color: Colors.red[900]),
          ),
        ],
      ),
    );
  }

  Widget getWorkout(WorkoutListItem workout, int index) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(workout.category,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Container(
            padding: EdgeInsets.only(left: 40),
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.navigate_next),
              iconSize: 40,
              onPressed: () {
                selectedCategory = index;
                print('Button $index clicked');
                showWorkoutList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(WorkoutListItem workout, int index) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      //decoration: BoxDecoration(borderRadius: BorderRadius.zero),
      child: Container(
        width: 300,
        height: 100,
        child: Card(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getIcon(),
              getWorkout(workout, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView.separated(
      itemCount: workouts.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListItem(workouts[index], index);
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.white),
    );
  }

  Future<void> showWorkoutList() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ViewWorkouts(title: '${workouts[selectedCategory].category}')),
    );
  }
}
