import 'package:flutter/material.dart';
import 'package:final_project/views/about_us.dart';

class Settings extends StatefulWidget {
  Settings({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                //when button clicked display go to about us dialog
                child: RaisedButton(
                    child: Text('About Us'),
                    onPressed: () {
                      _showAboutUs(context);
                    }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                //when button clicked display Copyrights and Licenses
                child: RaisedButton(
                    child: Text('Licenses'),
                    onPressed: () {
                      _showLicenses(context);
                    }),
              ),
            ]),
      ),
    );
  }

  //method to show Copyrights and Licenses
  void _showLicenses(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Fitness App',
      applicationVersion: 'Version 1.0.0',
      children: [
        Text('Fitness App'),
        Text('Copyright 2020\nSukhpreet Bansal\nJonathan Zhu\nMalaviya '),
      ],
    );
  }

  //method to display text describing the creators and purpose of the app
  void _showAboutUs(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AboutUs();
      },
    );
  }
}
