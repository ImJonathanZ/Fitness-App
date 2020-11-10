import 'package:flutter/material.dart';

import '../model/utils.dart';
import 'workouts/workouts_list.dart';

import 'appbar_icons.dart';
import 'homepage/home_page.dart';
import 'show_calendar.dart';
import 'show_map.dart';

class NavigationPages extends StatefulWidget {
  NavigationPages({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _NavigationPagesState createState() => _NavigationPagesState();
}

class _NavigationPagesState extends State<NavigationPages> {
  int selectedIcon = 0;

  DateTime date = DateTime.now();
  var displayDate = toDateString(DateTime.now());

  List<AppbarIcon> appbarIcons = [
    AppbarIcon(title: 'Homepage', icon: Icons.home),
    AppbarIcon(title: 'Workout List', icon: Icons.fitness_center),
    AppbarIcon(title: 'Calendar', icon: Icons.calendar_today),
    AppbarIcon(title: 'Map', icon: Icons.location_on),
  ];

  List<Widget> pages = [
    HomePage(),
    WorkoutList(),
    DisplayCalendar(),
    ShowMap()
  ];

  @override
  Widget build(BuildContext context) {
    print('Selected icon: $selectedIcon');
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIcon,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: appbarIcons.map((AppbarIcon page) {
          return BottomNavigationBarItem(
            icon: Icon(
              page.icon,
            ),
            label: '',
            activeIcon: Icon(
              page.icon,
              color: Colors.red[900],
            ),
          );
        }).toList(),
        onTap: (int index) {
          setState(() {
            selectedIcon = index;
            print(selectedIcon);
          });
        },
      ),
      body: pages.elementAt(selectedIcon),
    );
  }
}
