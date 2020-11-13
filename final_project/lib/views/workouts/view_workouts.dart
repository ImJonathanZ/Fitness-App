import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../model/workout.dart';

class ViewWorkouts extends StatefulWidget {
  ViewWorkouts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ViewWorkoutState createState() => _ViewWorkoutState();
}

class _ViewWorkoutState extends State<ViewWorkouts> {
  var selectedWorkout;
  var firebaseInitialized = true;
  var database;

  List<Workout> workoutDatabase = [
    Workout(
        workout: 'Biceps Curls', description: 'description', image: 'image'),
    Workout(workout: 'Legs Press', description: 'description', image: 'image'),
  ];

  // intializes Firebase
  void initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      setState(() {
        firebaseInitialized = true;
        database = FirebaseFirestore.instance;
      });
    } catch (e) {
      firebaseInitialized = false;
    }
  }

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedWorkout = widget.title;
    if (firebaseInitialized == true) {
      print('Initialized firebase');
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: buildListView(context),
    );
  }

  Future<QuerySnapshot> getProducts() async {
    print('Selected workout: $selectedWorkout');
    return await database.collection('Workouts').get();
  }

  // builds list view for each category selected
  Widget buildListView(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getProducts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          print('No items in list');
          return Center(child: CircularProgressIndicator());
        } else {
          print('Items in list');
          return ListView(
            padding: const EdgeInsets.all(10.0),
            children: snapshot.data.docs
                .map((DocumentSnapshot document) =>
                    buildListItem(context, document))
                .toList(),
          );
        }
      },
    );
  }

  Widget buildListItem(BuildContext context, DocumentSnapshot productData) {
    // builds the list item with the workout name, description and image
    final product =
        Workout.fromMap(productData.data(), reference: productData.reference);
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 10),
      child: Container(
        width: 350,
        height: 150,
        child: Card(
            color: Colors.black,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  getWorkout(product),
                  Container(
                    padding: EdgeInsets.only(top: 10, left: 40),
                    alignment: Alignment.topRight,
                    child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.add),
                      iconSize: 25,
                      onPressed: () {
                        print('Button clicked');
                      },
                    ),
                  ),
                ])),
      ),
    );
  }

  Widget getWorkout(Workout workout) {
    return Container(
      width: 100,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            workout.workout,
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(workout.description,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          Text(workout.image,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
