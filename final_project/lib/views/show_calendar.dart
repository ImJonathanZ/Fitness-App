import 'package:flutter/material.dart';

class DisplayCalendar extends StatefulWidget {
  DisplayCalendar({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _DisplayCalendarState createState() => _DisplayCalendarState();
}

class _DisplayCalendarState extends State<DisplayCalendar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Center(),
    );
  }
}
