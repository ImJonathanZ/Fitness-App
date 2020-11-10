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
  ];

  Widget build(BuildContext context) {
    print('Workouts');
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
            backgroundColor: Colors.black,
            child: Icon(Icons.fitness_center),
          ),
        ],
      ),
    );
  }

  Widget getWorkout(WorkoutListItem workout) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(workout.category,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          IconButton(
            padding: EdgeInsets.only(left: 30),
            icon: Icon(Icons.navigate_next),
            iconSize: 40,
            onPressed: () {
              print('Button clicked');
            },
          ),
        ],
      ),
    );
  }

  Widget buildListItem(WorkoutListItem workout) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      //decoration: BoxDecoration(borderRadius: BorderRadius.zero),
      child: Container(
        width: 300,
        height: 100,
        child: Card(
          color: Colors.red[900],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getIcon(),
              getWorkout(workout),
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
        return buildListItem(workouts[index]);
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.white),
    );
  }
}
