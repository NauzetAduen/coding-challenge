import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'injection.dart';

void main() {
  init();
  runApp(CodingChallengeApp());
}

const appName = "Coding Challenge";

class CodingChallengeApp extends StatefulWidget {
  @override
  _CodingChallengeAppState createState() => _CodingChallengeAppState();
}

class _CodingChallengeAppState extends State<CodingChallengeApp> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex = const CameraPosition(
      target: LatLng(37.42796133580664, -122.085749655962), zoom: 14.4746);
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          body: Center(
              child: SizedBox(
        width: 200,
        height: 200,
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ))));
}
