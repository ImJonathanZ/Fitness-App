import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

class ShowMap extends StatefulWidget {
  ShowMap({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<ShowMap> {
  List<LatLng> positionList = [];
  List<double> speedList = [];
  var _mapController = MapController();
  var centre;

  var _geolocator = Geolocator();
  var zoomNum = 20.0;
  StreamSubscription streamSub;
  bool started = false;
  bool didConfirm;
  Icon currentIcon = Icon(Icons.play_arrow);
  String locationName;

  @override
  void initState() {
    super.initState();
    setLocation();
  }

  void setLocation() {
    _geolocator
        .getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    )
        .then((Position userLocation) {
      setState(() {
        centre = LatLng(userLocation.latitude, userLocation.longitude);
        _mapController.move(centre, 20);
      });
    });
  }

  void _updateLocation(Position userLocation) {
    setState(() {
      print(userLocation
          .toString()); //////////////////////////////////////////////////////
      centre = LatLng(userLocation.latitude, userLocation.longitude);
      _mapController.move(centre, 20.0);
      positionList.add(centre);
      speedList.add(userLocation.speed);
    });
  }

  void streamOnOff(bool check) {
    if (streamSub == null) {
      streamSub = _geolocator
          .getPositionStream(
            LocationOptions(
              accuracy: LocationAccuracy.best,
              timeInterval: 3000,
            ),
          )
          .listen(_updateLocation);
      streamSub.pause();
    }
    setState(() {
      if (check == false) {
        streamSub.resume();
      } else {
        streamSub.pause();
      }
    });
  }

  @override
  void dispose() {
    streamSub.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _geolocator.checkGeolocationPermissionStatus();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Track Your Run'),
      ),
      body: buildMap(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (started == false) {
              _showConfirmation(context);
            } else if (started == true) {
              currentIcon = Icon(Icons.play_arrow);
              streamOnOff(started);
              setState(() {
                started = false;
              });
              _geolocator
                  .placemarkFromCoordinates(centre.latitude, centre.longitude)
                  .then((List<Placemark> places) {
                for (Placemark place in places) {
                  setState(() {
                    locationName =
                        'Today you ended at: ${place.subThoroughfare}, ${place.thoroughfare}';
                  });
                }
              });
              _showMessage(context);
            }
          });
        },
        child: currentIcon,
      ),
    );
  }

  void _showConfirmation(BuildContext context) async {
    var doesUserUnderstand = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(
              'Starting a new run will clear your old one. Do you wish to continue?'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Yes I Understand'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            SimpleDialogOption(
              child: Text('Nevermind I don\'t want to'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    );
    setState(() {
      didConfirm = doesUserUnderstand;

      if (didConfirm == true) {
        currentIcon = Icon(Icons.stop);

        positionList.clear();
        speedList.clear();

        streamOnOff(started);
        started = true;
      }
    });
  }

  void _showMessage(BuildContext context) {
    var avg = double.parse(
        (speedList.reduce((a, b) => a + b) / speedList.length)
            .toStringAsFixed(3));

    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nice!'),
          content: SingleChildScrollView(
            child: Text("$locationName \n\n Average Speed: $avg m/s"),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Thanks!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildMap() {
    return FlutterMap(
      options: MapOptions(
        zoom: zoomNum,
        minZoom: 6.0,
        maxZoom: 18.0,
        center: centre,
      ),
      mapController: _mapController,
      layers: [
        TileLayerOptions(
          urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: ['a', 'b', 'c'],
        ),
        PolylineLayerOptions(polylines: [
          Polyline(points: positionList, strokeWidth: 1.0, color: Colors.blue)
        ]),
      ],
    );
  }
}
