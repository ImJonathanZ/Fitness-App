import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:geolocator/geolocator.dart';

//How to parse a csv file was used from https://flutterframework.com/read-csv-file-by-dart/

class ShowMap extends StatefulWidget {
  ShowMap({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MapPage createState() => _MapPage();
}

class _MapPage extends State<ShowMap> {
  List<LatLng> positionList = [];
  var _mapController = MapController();
  var centre = LatLng(43.9375, -78.8885);
  var _geolocator = Geolocator();
  var zoomNum = 20.0;
  StreamSubscription streamSub;
  bool started = false;
  Icon currentIcon = Icon(Icons.play_arrow);

  void _updateLocation(Position userLocation) {
    setState(() {
      print(userLocation.toString());
      centre = LatLng(userLocation.latitude, userLocation.longitude);
      _mapController.move(centre, 20.0);
      positionList.add(centre);
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
              currentIcon = Icon(Icons.stop);
              streamOnOff(started);
              setState(() {
                positionList = [];
                started = true;
              });
            } else {
              currentIcon = Icon(Icons.play_arrow);
              streamOnOff(started);
              setState(() {
                started = false;
              });
            }
          });
        },
        child: currentIcon,
      ),
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
