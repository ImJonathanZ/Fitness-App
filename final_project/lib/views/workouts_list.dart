import 'package:flutter/material.dart';

import 'appbar_icons.dart';

class WorkoutList extends StatefulWidget {
  WorkoutList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WorkoutListState createState() => WorkoutListState();
}

class WorkoutListState extends State<WorkoutList> {
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

  @override
  Widget build(BuildContext context) {
    print('Workouts');
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Workouts'),
      ),
      body: Center(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey[200],
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
            if (index == 0) {
              showHomePage();
            } else if (index == 2) {
              showCalendar();
            } else {
              showMap();
            }
          });
        },
      ),
    );
  }

  Future<void> showHomePage() async {
    var page = await Navigator.pushNamed(context, '/homepage');

    print('New item: $page');
    //didChangeDependencies();
  }

  Future<void> showCalendar() async {
    var c = await Navigator.pushNamed(context, '/showCalendar');

    print('New item: $c');
    //didChangeDependencies();
  }

  Future<void> showMap() async {
    var map = await Navigator.pushNamed(context, '/showMap');

    print('New item: $map');
    //didChangeDependencies();
  }
}
