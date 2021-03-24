import 'package:flutter/material.dart';

import '../../domain/entities/venue.dart';
import 'custom_hero.dart';

const double iconSize = 30;

///listview for listtiles with each venue
class VenuesListView extends StatelessWidget {
  final List<Venue> list;

  const VenuesListView({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: list.length,
      itemBuilder: (context, index) {
        final Venue venue = list[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 75,
            child: Center(
              child: ListTile(
                onTap: () {
                  Navigator.pushNamed(context, "/detailed", arguments: venue);
                },
                title:
                    CustomHero(tag: "${venue.id}name", child: Text(venue.name)),
                subtitle: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    CustomHero(
                        tag: "${venue.id}location",
                        child: Text(venue.location.locationName)),
                    CustomHero(
                      tag: "${venue.id}distance",
                      child: Text("${venue.location.distance.toString()}m",
                          //TODO THEME
                          style: const TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
                leading: CustomHero(
                  tag: "${venue.id}icon",
                  child: venue.category.photoUrl.isNotEmpty
                      ? Container(
                          //TODO use theme
                          color: Colors.black,
                          width: iconSize,
                          height: iconSize,
                          child: Center(
                              child: Image.network(venue.category.photoUrl)))
                      : const SizedBox(width: iconSize, height: iconSize),
                ),
                trailing: CustomHero(
                    tag: "${venue.id}like",
                    child: const Icon(Icons.favorite, size: iconSize)),
              ),
            ),
          ),
        );
      },
    );
  }
}
