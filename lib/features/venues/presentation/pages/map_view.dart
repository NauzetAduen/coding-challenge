import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/venue.dart';
import '../bloc/favorite_bloc.dart';

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
  // FavoriteBloc favoriteBloc;
  Set<String> favoriteSet = {};

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FavoriteBloc>(context)
        .add(const ToogleFavoriteStatusEvent(venueID: ""));

    final favoriteBlocState = BlocProvider.of<FavoriteBloc>(context).state;
    if (favoriteBlocState is LoadedFavoriteState) {
      favoriteSet = favoriteBlocState.keys;
    }

    firstVenue = widget.list.first;
    cameraPosition = CameraPosition(
        target:
            LatLng(firstVenue.location.latitude, firstVenue.location.longitude),
        zoom: 14);
    updateMarkers();
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
            mapController.setMapStyle(
                await rootBundle.loadString("assets/map/config.json"));
          },
        ),
      );
  void updateMarkers() {
    BlocProvider.of<FavoriteBloc>(context)
        .add(const ToogleFavoriteStatusEvent(venueID: ""));

    final favoriteBlocState = BlocProvider.of<FavoriteBloc>(context).state;
    if (favoriteBlocState is LoadedFavoriteState) {
      favoriteSet = favoriteBlocState.keys;
    }
    firstVenue = widget.list.first;
    double hue;
    for (final venue in widget.list) {
      if (favoriteSet.contains(venue.id)) {
        hue = 356;
      } else {
        hue = 46;
      }
      markersFromList.add(Marker(
          markerId: MarkerId(venue.id),
          position: LatLng(venue.location.latitude, venue.location.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(hue),
          //46 is the hue color of F2BB05, our accent color
          //TODO color red for favorites?
          infoWindow: InfoWindow(
              title: venue.name,
              snippet: venue.location.locationName,
              onTap: () {
                Navigator.pushNamed(context, "/detailed", arguments: venue)
                    .then((value) {
                  setState(() {
                    updateMarkers();
                  });
                });
              })));
    }
  }
}
