import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class PantallaFullMap extends StatefulWidget {
  @override
  _PantallaFullMapState createState() => _PantallaFullMapState();
}

class _PantallaFullMapState extends State<PantallaFullMap> {
  MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
            target: LatLng(10.595120, -67.045467), zoom: 14),
        // onStyleLoadedCallback: onStyleLoadedCallback,
      ),
    );
  }
}
