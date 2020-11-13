import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      elevation: 50.0,
      backgroundColor: Colors.red[900],
      insetPadding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
      child: Text(
        'This app was developed and organized by three of us computer science students: Sukhpreet, Jonathan and Malaviya. Where we wanted to create an app that can make life easier for your fitness needs by providing a quick and organized user interface that can help you organize and schedule your gym workouts.',
        style: TextStyle(
          fontSize: 25.0,
          color: Colors.white,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
