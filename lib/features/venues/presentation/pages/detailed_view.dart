import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../domain/entities/venue.dart';
import '../../domain/entities/venue_details.dart';
import '../bloc/details_bloc.dart';
import '../widgets/check_icon.dart';
import '../widgets/custom_hero.dart';
import '../widgets/details_column.dart';
import '../widgets/fixed_box.dart';
import '../widgets/loading_box.dart';

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
  VenueDetails venueDetails;

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

    BlocProvider.of<DetailsBloc>(context)
        .add(GetDetailsEvent(venueID: widget.venue.id));
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
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 350,
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
                child: FixedBox(
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
                      BlocBuilder<DetailsBloc, DetailsState>(
                          builder: (context, state) {
                        if (state is LoadedDetailsState) {
                          return CheckIcon(
                            verified: state.venueDetails.verified,
                          );
                        }
                        return const CheckIcon(verified: false);
                      }),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: FixedBox(
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
                                style: const TextStyle(fontSize: 14),
                              )),
                        ),
                      ),
                      const VerticalDivider(
                        thickness: 2,
                        endIndent: 15,
                        indent: 15,
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
              ),
              BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
                if (state is DetailsInitialState) {
                  return Container();
                } else if (state is LoadingDetailsState) {
                  return const LoadingBox();
                } else if (state is LoadedDetailsState) {
                  return DetailsColumn(venueDetails: state.venueDetails);
                } else if (state is ErrorDetailsState) {
                  return Center(child: Text(state.message));
                }
                return const Text("Error");
              }),
            ],
          ),
        ));
  }
}
