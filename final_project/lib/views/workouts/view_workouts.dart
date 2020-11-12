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
    Workout(workout: 'Biceps Curls', description: 'description'),
    Workout(workout: 'Legs Press', description: 'description'),
  ];

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
      body: buildProductList(context),
    );
  }

  Future<QuerySnapshot> getProducts() async {
    print('Selected workout: $selectedWorkout');
    return await database.collection('Workouts').get();
  }

  Widget buildProductList(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: getProducts(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          print("No data in firebase");
          return Center(child: CircularProgressIndicator());
        } else {
          print('Firebase data');
          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: snapshot.data.docs
                .map((DocumentSnapshot document) =>
                    _buildProduct(context, document))
                .toList(),
          );
        }
      },
    );
  }

  Widget _buildProduct(BuildContext context, DocumentSnapshot productData) {
    final product =
        Workout.fromMap(productData.data(), reference: productData.reference);
    print(product.category);
    return GestureDetector(
      child: ListTile(
        title: Text(product.category),
        subtitle: Text(product.workout),
        trailing: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
      ),
      onLongPress: () {
        setState(() {
          product.reference.delete();
        });
      },
    );
  }
}
