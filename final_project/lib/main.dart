import 'package:final_project/views/main_screen.dart';
import 'package:final_project/views/show_exercises.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(LoadingScreen());
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFitness',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: NavigationPages(title: 'MyFitness'),
    );
  }
}
