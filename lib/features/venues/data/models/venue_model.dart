import 'package:flutter/material.dart';

import '../../domain/entities/venue.dart';

///Has serialization, not like Venue, to avoid Venue being over exposed to datasources.
///
///Transforming raw data required conversion logic
class VenueModel extends Venue {
  const VenueModel({
    @required String id,
    @required String name,
    @required Location location,
    @required Category category,
  }) : super(id: id, name: name, location: location, category: category);

  factory VenueModel.fromJson(Map<String, dynamic> jsonMap) {
    final Location location = Location(
      locationName:
          jsonMap['location']['address'] as String ?? "No address provided.",
      distance: jsonMap['location']['distance'] as int ?? 10000,
      latitude: jsonMap['location']['lat'] as double ?? 0,
      longitude: jsonMap['location']['lng'] as double ?? 0,
    );
    String photoURL = "";
    String categoryName = "";
    if ((jsonMap['categories'] as List<dynamic>).isNotEmpty) {
      final String prefix =
          jsonMap['categories'][0]['icon']['prefix'] as String ?? "";
      final String suffix =
          jsonMap['categories'][0]['icon']['suffix'] as String ?? "";
      if (prefix.isNotEmpty && suffix.isNotEmpty) {
        photoURL = "${prefix}32$suffix";
      }
      categoryName = jsonMap['categories'][0]['name'] as String ?? "";
    }

    final Category category = Category(name: categoryName, photoUrl: photoURL);
    return VenueModel(
        id: jsonMap['id'] as String ?? "",
        name: jsonMap['name'] as String ?? "",
        location: location,
        category: category);
  }
}
