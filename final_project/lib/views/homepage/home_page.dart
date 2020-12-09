import 'package:final_project/views/exercisesPages/show_exercises.dart';
import 'package:flutter/material.dart';
import '../../model/utils.dart';
import '../../model/workout.dart';
import '../../model/notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIcon = 0;
  final _notifications = Notifications();

  //notification messages
  List _motivation = [
    "YOU GOT THIS!",
    "Keep Pushing!",
    "Strive For Greatness",
    "Time To Get Sweat & Pumped!"
  ];
  int random = Random().nextInt(4);
  // String _motivation = "YOU GOT THIS!";
  String _motivation2 = "KEEP GRINDING";
  String _workoutReminder = "Don't forget to workout today!";

  DateTime date = DateTime.now();
  var displayDate = toDateString(DateTime.now());

  List<Workout> workouts = [
    Workout(category: 'Arms', workout: 'Workout', day: ['M', 'TU', 'W']),
    Workout(category: 'Legs', workout: 'Workout', day: ['W', 'TH', 'F']),
    Workout(category: 'Abs', workout: 'Workout', day: ['S', 'TU'])
  ];

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones(); //initialize time

    _notifications.init();
    print('Selected icon: $selectedIcon');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            //ask user to confirm to add workout or not using a dialog
            _addConfirmation(context);
            print("Add");
          },
          tooltip: 'Add',
        ),
        title: Text('MyFitness'), //title of the page
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              //take user to the settings
              _showSettings();
              print("SETTINGS");
            },
            tooltip: 'Settings',
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              //ask user if they want to edit the workout or not using a dialog
              _editConfirmation(context);
              print("EDIT");
            },
            tooltip: 'Edit',
          ),
        ],
      ),
      body: buildUserWorkouts(context),
    );
  }

  Widget buildUserWorkouts(BuildContext context) {
    return ListView.separated(
      itemCount: workouts.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 20, left: 40),
            child: Text('$displayDate',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          );
        } else {
          return buildListItem(workouts[index - 1]);
        }
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.white),
    );
  }

  //Shows exercise screen
  Future<void> showExercises(
      BuildContext context, String passedCategory) async {
    // await Navigator.pushNamed(context, '/displayExercies',
    //     arguments: passedCategory);
    await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (__) => new DisplayExercises(
                  passedCategory: passedCategory,
                )));
  }

  Widget buildListItem(Workout workout) {
    //Switched to gesture detector in order to allow the widgets to be pressed to go to other screen
    return GestureDetector(
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20),
        //decoration: BoxDecoration(borderRadius: BorderRadius.zero),
        child: Container(
          width: 300,
          height: 100,
          child: Card(
            color: Colors.red[900],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                getIcon(),
                getWorkout(workout),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        //Switches to show exercises screen
        showExercises(context, workout.category);
      },
    );
  }

  Widget getIcon() {
    return Container(
      alignment: Alignment(1.5, -0.2),
      padding: EdgeInsets.only(left: 20),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.black,
            child: Icon(Icons.fitness_center),
          ),
        ],
      ),
    );
  }

  Widget getWorkout(Workout workout) {
    return Container(
      padding: EdgeInsets.only(left: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(workout.category,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(workout.workout,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
          Text(workout.workoutDays(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  void _editConfirmation(BuildContext context) async {
    await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Are You Sure You Want To Edit Your Workout?'),
            children: <Widget>[
              //user confirmation to edit workout or not using a dialog
              SimpleDialogOption(
                  child: Text('Yes'),
                  onPressed: () {
                    _showEdit();
                    //Continue to edit page
                  }),
              SimpleDialogOption(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                    //Do not continue to edit page
                  }),
            ],
          );
        });
  }

  void _addConfirmation(BuildContext context) async {
    await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Text('Time to create a new workout?'),
            children: <Widget>[
              //user confirmation to add workout or not
              SimpleDialogOption(
                  child: Text('Yes'),
                  onPressed: () {
                    //Continue to add page
                    _showAdd();
                    print(_motivation);
                    _notifications.sendNotificationNow(
                        _motivation[random], _motivation2, "");
                  }),
              SimpleDialogOption(
                onPressed: () async {
                  //Do not continue to add page
                  //send a reminder of working out today after 10 mins
                  Navigator.of(context).pop(false);
                  var when = tz.TZDateTime.now(tz.local)
                      .add(const Duration(minutes: 10));
                  await _notifications.sendNotificationLater(
                      _workoutReminder, "", when, "");
                  print(_workoutReminder);
                },
                child: Text('No'),
              ),
            ],
          );
        });
  }

  //navigation to other pages
  Future<void> _showSettings() async {
    var setting = await Navigator.pushNamed(context, '/settings');
  }

  Future<void> _showEdit() async {
    var edit = await Navigator.pushNamed(context, '/editPage');
  }

  Future<void> _showAdd() async {
    var add = await Navigator.pushNamed(context, '/addPage');
  }
}
