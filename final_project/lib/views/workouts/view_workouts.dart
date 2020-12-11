import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../../model/workout.dart';

class ViewWorkouts extends StatefulWidget {
  ViewWorkouts({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ViewWorkoutState createState() => _ViewWorkoutState(title);
}

class _ViewWorkoutState extends State<ViewWorkouts> {
  var selectedWorkout;
  var firebaseInitialized = true;
  var database;
  final String category;

  _ViewWorkoutState(this.category);

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
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('${widget.title}'),
      ),
      body: buildListView(context),
    );
  }

  // gets the workouts from firebase that have the category that is displayed
  Future<QuerySnapshot> getProducts() async {
    print('Selected workout: $selectedWorkout');
    return await database
        .collection('Workouts')
        .where('category', isEqualTo: category)
        .get();
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
    if (product.category == widget.title) {
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
                      width: 120,
                      height: 220,
                      alignment: Alignment.centerRight,
                      child: Image.network(product.image),
                    ),
                  ])),
        ),
      );
    }
  }

  Widget getWorkout(Workout workout) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              workout.workout,
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: 100,
            child: Text(workout.description,
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
