import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final List<Venue> list;

  const MapView({Key key, this.list}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  GoogleMapController mapController;
  Venue firstVenue;
  Set<Marker> markersFromList = {};

  @override
  void initState() {
    super.initState();
    firstVenue = widget.list.first;
    for (final venue in widget.list) {
      markersFromList.add(Marker(
          //TODO ADD COLOR, INFO, AND NAVIGATION TO DETAILS
          markerId: MarkerId(venue.id),
          position: LatLng(venue.location.latitude, venue.location.longitude)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final CameraPosition cameraPosition = CameraPosition(
        target:
            LatLng(firstVenue.location.latitude, firstVenue.location.longitude),
        zoom: 14);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GoogleMap(
          initialCameraPosition: cameraPosition,
          markers: markersFromList,
          onMapCreated: (GoogleMapController controller) async {
            mapController = controller;

            //https://flutter.dev/docs/development/ui/assets-and-images
            mapController.setMapStyle(
                await rootBundle.loadString("assets/map/config.json"));
          }),
    );
  }
}
