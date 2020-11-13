import 'package:flutter/material.dart';

//page to edit workouts
class Edit extends StatefulWidget {
  Edit({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
