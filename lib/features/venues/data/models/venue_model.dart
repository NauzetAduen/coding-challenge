import 'package:flutter/material.dart';

import '../../domain/entities/venue.dart';

class VenueModel extends Venue {
  const VenueModel({
    @required String id,
    @required String name,
    @required Location location,
    @required Category category,
  }) : super(
          id: id,
          name: name,
          location: location,
          category: category,
        );

//TODO (control which fields can be null)
  factory VenueModel.fromJson(Map<String, dynamic> jsonMap) {
    final Location location = Location(
      locationName: jsonMap['location']['address'] as String,
      distance: jsonMap['location']['distance'] as int,
      latitude: jsonMap['location']['lat'] as double,
      longitude: jsonMap['location']['lng'] as double,
    );
    final Category category = Category(
      name: jsonMap['categories'][0]['name'] as String,
      photoUrl:
          "${jsonMap['categories'][0]['icon']['prefix']}32${jsonMap['categories'][0]['icon']['suffix']}",
    );
    return VenueModel(
        id: jsonMap['id'] as String,
        name: jsonMap['name'] as String,
        location: location,
        category: category);
  }
}
