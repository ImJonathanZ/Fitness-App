import 'package:flutter/material.dart';

import 'appbar_icons.dart';

class DisplayCalendar extends StatefulWidget {
  DisplayCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DisplayCalendarState createState() => _DisplayCalendarState();
}

class _DisplayCalendarState extends State<DisplayCalendar> {
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
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        leading: Icon(Icons.add),
        title: Text(widget.title),
        actions: <Widget>[
          Icon(Icons.edit),
        ],
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
            } else if (index == 1) {
              workoutList();
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

  Future<void> workoutList() async {
    var page = await Navigator.pushNamed(context, '/workoutList');

    print('New item: $page');
    //didChangeDependencies();
  }

  Future<void> showMap() async {
    var map = await Navigator.pushNamed(context, '/showMap');

    print('New item: $map');
    //didChangeDependencies();
  }
}
