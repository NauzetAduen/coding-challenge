import 'package:coding_challenge/features/venues/presentation/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/venue.dart';
import 'custom_hero.dart';
import 'favorite_button.dart';

const double iconSize = 30;

///listview for listtiles with each venue
///
///Navigate to detailed
class VenuesListView extends StatelessWidget {
  final List<Venue> list;

  const VenuesListView({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      //https://stackoverflow.com/questions/46761036/why-my-flutter-apps-listview-scroll-not-as-smooth-as-the-flutter-gallery-app/52166381
      //we add a fixed itemExtend for performance
      itemExtent: 85,
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final Venue venue = list[index];
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/detailed", arguments: venue);
                },
                title: CustomHero(
                    tag: "${venue.id}name",
                    child: Text(
                      venue.name,
                      style: Theme.of(context).textTheme.headline3,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // alignment: WrapAlignment.spaceBetween,
                  children: [
                    CustomHero(
                        tag: "${venue.id}location",
                        child: Text(
                          venue.location.locationName,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headline4,
                        )),
                    CustomHero(
                      tag: "${venue.id}distance",
                      child: Text(
                        "${venue.location.distance.toString()}m",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontSize: 10),
                      ),
                    ),
                  ],
                ),
                leading: CustomHero(
                  tag: "${venue.id}icon",
                  child: venue.category.photoUrl.isNotEmpty
                      ? Container(
                          color: Colors.black,
                          width: iconSize,
                          height: iconSize,
                          child: Center(
                              child: Image.network(venue.category.photoUrl)))
                      : const SizedBox(width: iconSize, height: iconSize),
                ),
                trailing: CustomHero(
                  tag: "${venue.id}like",
                  child: BlocBuilder<FavoriteBloc, FavoriteState>(
                      builder: (context, state) {
                    if (state is LoadedFavoriteState) {
                      return FavoriteButton(
                        color: state.keys.contains(venue.id)
                            ? Colors.red
                            : Colors.grey,
                        venueID: venue.id,
                      );
                    }
                    return FavoriteButton(
                      color: Colors.grey,
                      venueID: venue.id,
                    );
                  }),
                ),
              ),
            ));
      },
    );
  }
}
