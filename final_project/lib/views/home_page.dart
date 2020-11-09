import 'package:flutter/material.dart';

import '../model/utils.dart';
import '../model/workout.dart';
import '../views/workouts_list.dart';

import 'appbar_icons.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIcon = 0;

  DateTime date = DateTime.now();
  var displayDate = toDateString(DateTime.now());

  List<AppbarIcon> appbarIcons = [
    AppbarIcon(title: 'Homepage', icon: Icons.home, route: '/homepage'),
    AppbarIcon(
        title: 'Workout List',
        icon: Icons.fitness_center,
        route: '/workoutList'),
    AppbarIcon(
        title: 'Calendar', icon: Icons.calendar_today, route: '/calendar'),
    AppbarIcon(title: 'Map', icon: Icons.location_on, route: '/map'),
  ];

  List<Workout> workouts = [
    Workout(category: 'Arms', workout: 'Workout', day: ['M', 'TU', 'W']),
    Workout(category: 'Legs', workout: 'Workout', day: ['W', 'TH', 'F']),
    Workout(category: 'Arms', workout: 'Workout', day: ['S', 'TU'])
  ];

  @override
  Widget build(BuildContext context) {
    print('Selected icon: $selectedIcon');
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text('MyFitness'),
        actions: <Widget>[
          Icon(Icons.edit),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIcon,
        backgroundColor: Colors.blueGrey[100],
        type: BottomNavigationBarType.fixed,
        items: appbarIcons.map((AppbarIcon page) {
          return BottomNavigationBarItem(
            icon: Icon(
              page.icon,
            ),
            label: '',
          );
        }).toList(),
        onTap: (int index) {
          setState(() {
            selectedIcon = index;
            if (index == 1) {
              showWorkoutList(context);
            } else if (index == 2) {
              showCalendar(context);
            } else {
              showMap(context);
            }
          });
        },
      ),
      body: buildUserWorkouts(context),
    );
  }

  Future<void> showCalendar(BuildContext context) async {
    var c = await Navigator.pushNamed(context, '/calendar');

    print('New item: $c');
    //didChangeDependencies();
  }

  Future<void> showWorkoutList(BuildContext context) async {
    var page = await Navigator.pushNamed(context, '/workoutList');

    print('New item: $page');
    //didChangeDependencies();
  }

  Future<void> showMap(BuildContext context) async {
    var map = await Navigator.pushNamed(context, '/showMap');

    print('New item: $map');
    //didChangeDependencies();
  }

  Widget buildUserWorkouts(BuildContext context) {
    return ListView.separated(
      itemCount: workouts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            color: Colors.blueGrey[100],
            padding: EdgeInsets.only(top: 20, left: 40),
            child: Text('$displayDate',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          );
        } else {
          return buildListItem(workouts[index - 1]);
        }
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.blueGrey[100]),
    );
  }

  Widget buildListItem(Workout workout) {
    return Container(
      color: Colors.blueGrey[100],
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      //decoration: BoxDecoration(borderRadius: BorderRadius.zero),
      child: Container(
        width: 300,
        height: 100,
        child: Card(
          color: Colors.teal,
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

  Widget getIcon() {
    return Container(
      alignment: Alignment(1.5, -0.2),
      padding: EdgeInsets.only(left: 20),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.blueGrey[100],
            child: Icon(Icons.fitness_center),
          ),
        ],
      ),
    );
  }

  Widget getWorkout(Workout workout) {
    return Container(
      padding: EdgeInsets.only(left: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(workout.category,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(workout.workout,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          Text(workout.workoutDays(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
