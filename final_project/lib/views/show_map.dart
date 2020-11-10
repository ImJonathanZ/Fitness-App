import 'package:flutter/material.dart';

class ShowMap extends StatefulWidget {
  ShowMap({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<ShowMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Find a Fitness Facility'),
      ),
      body: Center(),
    );
  }
}
