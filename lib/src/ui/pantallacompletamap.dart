import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;

import 'package:mapbox_gl/mapbox_gl.dart';

class PantallaFullMap extends StatefulWidget {
  @override
  _PantallaFullMapState createState() => _PantallaFullMapState();
}

class _PantallaFullMapState extends State<PantallaFullMap> {
  MapboxMapController mapController;
  final center = LatLng(10.595120, -67.045467);
  String colorSelecionado = "#FFB300";
  String seleccionEstilo =
      "mapbox://styles/darwinuzcategui/cklk8ydqc1if817l5g15gu39f";
  final oscuroEstilo =
      "mapbox://styles/darwinuzcategui/cklk8ydqc1if817l5g15gu39f";
  final colorOscuro = "#FFB300";

  final callesEstilo =
      "mapbox://styles/darwinuzcategui/cklk9j0vx03l517pjn9o6cgzp";
  final colorCalle = "#000033";

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
    _onStyleLoaded();
  }

  // metodo para cargar

  void _onStyleLoaded() {
    addImageFromAsset("assetImage", "assets/gmd.ico");
    addImageFromUrl(
        "networkImage", Uri.parse("https://via.placeholder.com/50"));
  }

  /// Adds an asset image to the currently displayed style
  Future<void> addImageFromAsset(String name, String assetName) async {
    final ByteData bytes = await rootBundle.load(assetName);
    final Uint8List list = bytes.buffer.asUint8List();
    return mapController.addImage(name, list);
  }

  /// Adds a network image to the currently displayed style
  Future<void> addImageFromUrl(String name, Uri uri) async {
    var response = await http.get(uri);
    return mapController.addImage(name, response.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMap(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        // Simbolos
        FloatingActionButton(
            child: Icon(Icons.settings_system_daydream_rounded),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              mapController.addSymbol(SymbolOptions(
                  geometry: center,
                  // iconSize: 1,
                  //iconImage: "attraction-15",
                  iconImage: 'assetImage',
                  textField: 'MI CASA ',
                  textOffset: Offset(0, 5),
                  textColor: colorSelecionado));
              if (seleccionEstilo == oscuroEstilo) {
                //seleccionEstilo = callesEstilo;
                colorSelecionado = colorCalle;
              } else {
                // seleccionEstilo = oscuroEstilo;
                colorSelecionado = colorOscuro;
              }
              print(colorOscuro + " color selecionado *** " + colorSelecionado);
              setState(() {
                _onStyleLoaded();
              });
            }),
        SizedBox(
          height: 5,
        ),

        // ZoomIn Acercar
        FloatingActionButton(
            child: Icon(Icons.zoom_in),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              //mapController.animateCamera(CameraUpdate.tiltTo(85)); // par inclinacion
              mapController.animateCamera(CameraUpdate.zoomIn());
            }),
        SizedBox(
          height: 5,
        ),
        // ZoomOut Alejar
        FloatingActionButton(
            child: Icon(Icons.zoom_out),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              //mapController.animateCamera(CameraUpdate.tiltTo(85)); // par inclinacion
              mapController.animateCamera(CameraUpdate.zoomOut());
            }),
        SizedBox(
          height: 5,
        ),

        // cambiar Estilos
        FloatingActionButton(
            child: Icon(Icons.add_box_outlined),
            backgroundColor: Colors.orangeAccent,
            onPressed: () {
              if (seleccionEstilo == oscuroEstilo) {
                seleccionEstilo = callesEstilo;
                colorSelecionado = colorCalle;
              } else {
                seleccionEstilo = oscuroEstilo;
                colorSelecionado = colorOscuro;
              }

              setState(() {
                _onStyleLoaded();
              });
            })
      ],
    );
  }

  MapboxMap crearMap() {
    return MapboxMap(
      styleString: seleccionEstilo,
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: center, zoom: 14),
      // onStyleLoadedCallback: onStyleLoadedCallback,
    );
  }
}
