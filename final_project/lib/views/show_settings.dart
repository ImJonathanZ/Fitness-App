import 'package:flutter/material.dart';

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
                child: RaisedButton(
                    child: Text('About Us'),
                    onPressed: () {
                      // _showAboutUs(context);
                    }),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
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

  void _showLicenses(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Fitness App',
      applicationVersion: 'Version 1.0.0',
      children: [
        Text('Fitness App'),
        Text('Copyright 2020\nSukhpreet Bansal\nJonathan Zhu\nMalaviya'),
      ],
    );
  }
}
