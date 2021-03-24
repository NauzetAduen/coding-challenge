import 'package:coding_challenge/features/venues/presentation/bloc/favorite_bloc.dart';
import 'package:coding_challenge/features/venues/presentation/widgets/favorite_button.dart';
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
import '../widgets/text_error.dart';

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

      ///46 is the hue color of F2BB05, our accent color
      icon: BitmapDescriptor.defaultMarkerWithHue(46),
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
          title: Text(
            widget.venue.name,
            style: Theme.of(context).textTheme.headline1,
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: CustomHero(
                tag: "${widget.venue.id}like",
                child: BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, state) {
                  if (state is LoadedFavoriteState) {
                    return FavoriteButton(
                      color: state.keys.contains(widget.venue.id)
                          ? Colors.red
                          : Colors.grey,
                      venueID: widget.venue.id,
                    );
                  }
                  return FavoriteButton(
                    color: Colors.grey,
                    venueID: widget.venue.id,
                  );
                }),
              ),
            ),
          ],
        ),

        /*


        */
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            // mainAxisSize: MainAxisSize.max,
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
                              style: Theme.of(context).textTheme.headline2,
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
                                style: Theme.of(context).textTheme.bodyText2,
                              )),
                        ),
                      ),
                      VerticalDivider(
                        color: Theme.of(context).dividerColor,
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
                                style: Theme.of(context).textTheme.bodyText2,
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
                  return const Padding(
                    padding: EdgeInsets.only(top: 60),
                    child: LoadingBox(),
                  );
                } else if (state is LoadedDetailsState) {
                  return DetailsColumn(venueDetails: state.venueDetails);
                } else if (state is ErrorDetailsState) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 60),
                    child: TextError(data: state.message),
                  );
                }
                return const TextError(data: "Error");
              }),
            ],
          ),
        ));
  }
}
