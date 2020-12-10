import 'package:final_project/views/charts.dart';
import 'package:flutter/material.dart';

import '../model/utils.dart';
import 'workouts/workouts_list.dart';

import '../model/appbar_icons.dart';
import 'homepage/home_page.dart';
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
    AppbarIcon(title: 'Home', icon: Icons.home),
    AppbarIcon(title: 'Workouts', icon: Icons.fitness_center),
    AppbarIcon(title: 'Charts', icon: Icons.bar_chart),
    AppbarIcon(title: 'Map', icon: Icons.location_on),
  ];

  List<Widget> pages = [HomePage(), WorkoutList(), Charts(), ShowMap()];

  @override
  Widget build(BuildContext context) {
    print('Selected icon: $selectedIcon');
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIcon,
          backgroundColor: Colors.grey[300],
          type: BottomNavigationBarType.fixed,
          items: appbarIcons.map((AppbarIcon page) {
            Color color = Colors.grey[300];

            if (page.title == 'Charts') {
              color = Colors.orange[900];
            }
            return BottomNavigationBarItem(
              icon: Icon(
                page.icon,
                color: Colors.black,
              ),
              label: page.title,
              activeIcon: Icon(
                page.icon,
                color: Colors.red[900],
              ),
            );
          }).toList(),
          onTap: (int index) {
            setState(() {
              selectedIcon = index;
              //print(selectedIcon);
            });
          },
        ),
        body: Stack(children: [
          navigatePage(0),
          navigatePage(1),
          navigatePage(2),
          navigatePage(3),
        ]));
  }

  Map<String, WidgetBuilder> routeBuilders(BuildContext context, int index) {
    return {
      '/': (context) {
        return [HomePage(), WorkoutList(), Charts(), ShowMap()]
            .elementAt(index);
      }
    };
  }

  Widget navigatePage(int index) {
    var _routeBuilders = routeBuilders(context, index);

    return Offstage(
      offstage: selectedIcon != index,
      child: Navigator(
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) =>
                  _routeBuilders[routeSettings.name](context));
        },
      ),
    );
  }
}
