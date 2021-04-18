import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapscreen extends StatefulWidget {
  static String routeName = "/MapScreen";

  final String myValue;
  final double longitude;
  final double latitude;

  Mapscreen({this.myValue, @required this.latitude, @required this.longitude});

  @override
  _MapscreenState createState() => _MapscreenState();
}

class _MapscreenState extends State<Mapscreen> {
  @override
  Widget build(BuildContext context) {
    List<Marker> allMarkers = [
      Marker(
          markerId: MarkerId('first_mark'),
          position: LatLng(widget.latitude, widget.longitude),
          infoWindow: InfoWindow(title: 'Your Location'))
    ];

    return Scaffold(
        appBar: (AppBar(
          title: Text("map"),
        )),
        body: Container(
            child: GoogleMap(
          markers: Set.from(allMarkers),
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(widget.latitude, widget.longitude),
            zoom: 17,
          ),
        )));
  }
}
