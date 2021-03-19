import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:flutter/material.dart';

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
        //no category name
        //usually you get what it is from the name
        final Venue venue = list[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 75,
            child: Center(
              child: ListTile(
                //TODO ADD FIXED WIDTH AND HEIGHT
                onTap: () {
                  //TODO PASS ARGUMENT ID
                  Navigator.pushNamed(context, "/detailed");
                },
                title: Text(venue.name),
                subtitle: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    Text(venue.location.locationName),
                    Text("${venue.location.distance.toString()}m",
                        //TODO THEME
                        style: const TextStyle(fontSize: 10)),
                  ],
                ),
                leading: venue.category.photoUrl.isNotEmpty
                    ? Container(
                        //TODO use theme
                        color: Colors.black,
                        width: iconSize,
                        height: iconSize,
                        child: Center(
                            child: Image.network(venue.category.photoUrl)))
                    : const SizedBox(width: iconSize, height: iconSize),
                trailing: const Icon(Icons.favorite, size: iconSize),
              ),
            ),
          ),
        );
      },
    );
  }
}
