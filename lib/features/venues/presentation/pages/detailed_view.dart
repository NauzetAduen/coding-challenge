import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/features/venues/presentation/widgets/custom_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DetailedVenueView extends StatefulWidget {
  final Venue venue;

  const DetailedVenueView({Key key, this.venue}) : super(key: key);

  @override
  _DetailedVenueViewState createState() => _DetailedVenueViewState();
}

class _DetailedVenueViewState extends State<DetailedVenueView> {
  CameraPosition cameraPosition;
  Marker marker;
  GoogleMapController mapController;
  double iconSize = 30;

  @override
  void initState() {
    super.initState();
    cameraPosition = CameraPosition(
        target: LatLng(
            widget.venue.location.latitude, widget.venue.location.longitude),
        zoom: 15);

    marker = Marker(
      markerId: MarkerId(widget.venue.id),
      position: LatLng(
          widget.venue.location.latitude, widget.venue.location.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(widget.venue.name),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CustomHero(
                  tag: "${widget.venue.id}like",
                  child: const Icon(Icons.favorite, size: 30)),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child: GoogleMap(
                  initialCameraPosition: cameraPosition,
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                  markers: {marker},
                  onMapCreated: (GoogleMapController controller) async {
                    mapController = controller;

                    //https://flutter.dev/docs/development/ui/assets-and-images
                    //TODO use theme colors
                    mapController.setMapStyle(
                        await rootBundle.loadString("assets/map/config.json"));
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomHero(
                        tag: "${widget.venue.id}icon",
                        child: widget.venue.category.photoUrl.isNotEmpty
                            ? Container(
                                //TODO use theme
                                color: Colors.black,
                                width: iconSize,
                                height: iconSize,
                                child: Center(
                                    child: Image.network(
                                        widget.venue.category.photoUrl)))
                            : SizedBox(width: iconSize, height: iconSize)),
                    Expanded(
                      child: CustomHero(
                          tag: "${widget.venue.id}name",
                          child: Text(
                            widget.venue.name,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 22),
                          )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 3,
                      child: Center(
                        child: CustomHero(
                            tag: "${widget.venue.id}location",
                            child: Text(
                              widget.venue.location.locationName,
                              style: const TextStyle(fontSize: 22),
                            )),
                      ),
                    ),
                    Flexible(
                      child: Center(
                        child: CustomHero(
                            tag: "${widget.venue.id}distance",
                            child: Text(
                              "${widget.venue.location.distance.toString()}m",
                              style: const TextStyle(fontSize: 14),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
