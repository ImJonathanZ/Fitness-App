import 'package:final_project/views/workouts/view_workouts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class WorkoutList extends StatefulWidget {
  WorkoutList({Key key, this.title}) : super(key: key);

  final String title;

  @override
  WorkoutListState createState() => WorkoutListState();
}

class WorkoutListState extends State<WorkoutList> {
  // list to display the items
  List<String> categories = ['Arms', 'Legs', 'Cardio', 'Abs', 'Back'];

  var selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        title: Text(FlutterI18n.translate(context, "workout-list.Appbar")),
      ),
      body: buildListView(context),
      drawer: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.only(bottom: 20),
            children: <Widget>[
              Container(
                height: 75,
                padding: EdgeInsets.only(left: 20, top: 30),
                color: Colors.blueGrey[900],
                child: Text('Languages',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    )),
              ),
              ListTile(
                tileColor: Colors.black,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/CanadaFlag.png'),
                ),
                title: Text(
                  'EN (CAN)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  Locale newLocale = Locale('en');
                  await FlutterI18n.refresh(context, newLocale);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
              ListTile(
                tileColor: Colors.black,
                leading: CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/images/CanadaFlag.png'),
                ),
                title: Text(
                  'FR (CAN)',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  Locale newLocale = Locale('fr');
                  await FlutterI18n.refresh(context, newLocale);
                  setState(() {});
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getIcon(String category) {
    return Container(
      alignment: Alignment(1.5, -0.2),
      padding: EdgeInsets.only(left: 20),
      child: Stack(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/$category.jpg'),
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget getWorkout(String category, int index) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(FlutterI18n.translate(context, "workout-list.$category"),
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(left: 30),
            child: IconButton(
              color: Colors.white,
              icon: Icon(Icons.navigate_next),
              iconSize: 30,
              onPressed: () {
                selectedCategory = index;
                print('Button $index clicked');
                showWorkoutList();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(String category, int index) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: 300,
        height: 100,
        child: Card(
          color: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getIcon(category),
              getWorkout(category, index),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListItem(categories[index], index);
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.white),
    );
  }

  Future<void> showWorkoutList() async {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ViewWorkouts(title: '${categories[selectedCategory]}')),
    );
  }
}
