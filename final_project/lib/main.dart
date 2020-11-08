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
    );
  }
}
