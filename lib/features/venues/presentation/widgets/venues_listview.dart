import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:flutter/material.dart';

const double iconSize = 30;

class VenuesListView extends StatelessWidget {
  final List<Venue> list;

  const VenuesListView({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(list[index].name),
          subtitle: Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: [
              Text(list[index].location.locationName),
              Text("${list[index].location.distance.toString()}m",
                  //TODO THEME
                  style: const TextStyle(fontSize: 10)),
            ],
          ),
          leading: list[index].category.photoUrl.isNotEmpty
              ? Container(
                  //TODO use theme
                  color: Colors.black,
                  width: iconSize,
                  height: iconSize,
                  child: Center(
                      child: Image.network(list[index].category.photoUrl)))
              : const SizedBox(width: iconSize, height: iconSize),
          trailing: const Icon(Icons.favorite, size: iconSize),
        );
      },
      itemCount: list.length,
    );
  }
}
