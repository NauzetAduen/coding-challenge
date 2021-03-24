import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/venue.dart';

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
  CameraPosition cameraPosition;

  @override
  void initState() {
    super.initState();
    firstVenue = widget.list.first;
    for (final venue in widget.list) {
      markersFromList.add(Marker(
          markerId: MarkerId(venue.id),
          position: LatLng(venue.location.latitude, venue.location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(46),
          //46 is the hue color of F2BB05, our accent color
          //TODO color red for favorites?
          infoWindow: InfoWindow(
              title: venue.name,
              snippet: venue.location.locationName,
              onTap: () {
                Navigator.pushNamed(context, "/detailed", arguments: venue);
              })));

      cameraPosition = CameraPosition(
          target: LatLng(
              firstVenue.location.latitude, firstVenue.location.longitude),
          zoom: 14);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text("Map", style: Theme.of(context).textTheme.headline1),
          centerTitle: true,
          elevation: 0,
        ),
        body: GoogleMap(
          compassEnabled: false,
          myLocationButtonEnabled: false,
          initialCameraPosition: cameraPosition,
          markers: markersFromList,
          onMapCreated: (GoogleMapController controller) async {
            mapController = controller;

            //https://flutter.dev/docs/development/ui/assets-and-images
            //TODO use theme colors
            mapController.setMapStyle(
                await rootBundle.loadString("assets/map/config.json"));
          },
        ),
      );
}
