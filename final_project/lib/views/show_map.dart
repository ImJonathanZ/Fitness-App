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
  var _mapController = MapController();
  var centre = LatLng(43.94595872178117, -78.89598774418127);
  var _geolocator = Geolocator();
  var zoomNum = 14.0;

  @override
  Widget build(BuildContext context) {
    _geolocator.checkGeolocationPermissionStatus();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Find a Fitness Facility'),
      ),
      body: buildMap(),
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
        MarkerLayerOptions(),
        PolylineLayerOptions(polylines: []),
      ],
    );
  }
}
