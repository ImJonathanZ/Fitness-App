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
      backgroundColor: Colors.grey[300],
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
      child: Stack(children: <Widget>[
        Container(
          width: 85,
          height: 100,
          color: Colors.white,
          child: Image(
            image: AssetImage('assets/images/$category.jpg'),
          ),
        ),
      ]),
    );
  }

  Widget getWorkout(String category, int index) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: Center(
        child: Text(FlutterI18n.translate(context, "workout-list.$category"),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget buildListItem(String category, int index) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[300],
        alignment: Alignment.center,
        padding: EdgeInsets.only(top: 20),
        child: Container(
          width: 300,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            border: Border.all(width: 5),
            borderRadius: BorderRadius.circular(10),
          ),
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
      ),
      onTap: () {
        setState(() {
          selectedCategory = index;
        });
        showWorkoutList();
      },
    );
  }

  Widget buildListView(BuildContext context) {
    return ListView.separated(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int index) {
        return buildListItem(categories[index], index);
      },
      separatorBuilder: (BuildContext context, int index) =>
          Divider(color: Colors.grey[300]),
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
