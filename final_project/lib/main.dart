import 'package:final_project/views/show_calendar.dart';
import 'package:final_project/views/workouts_list.dart';
import 'package:flutter/material.dart';

import 'views/home_page.dart';

void main() {
  runApp(LoadingScreen());
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFitness',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'MyFitness'),
      routes: <String, WidgetBuilder>{
        '/calendar': (BuildContext context) =>
            DisplayCalendar(title: 'Calendar View'),
        '/homePage': (BuildContext context) => HomePage(title: 'Home Page'),
        //'/showMap': (BuildContext context) => (title: 'Home Page'),
        '/workoutList': (BuildContext context) =>
            WorkoutList(title: 'Home Page'),
      },
    );
  }
}
