import 'dart:html';

import 'package:equatable/equatable.dart';

class Venue extends Equatable {
  final String id;
  final String name;
  final Location location;
  final Category category;

  const Venue(this.id, this.name, this.location, this.category);

  @override
  List<Object> get props => [id, name, location, category];
}

class Location {
  final String locationName;
  final double latitude;
  final double longitude;
  final double distance;

  //TODO (Add @required to location constructor)
  const Location({
    this.locationName,
    this.latitude,
    this.longitude,
    this.distance,
  });
}

class Category {
  final String name;
  final String photoUrl;

  //TODO (Add @required to category constructor)
  const Category(this.name, this.photoUrl);
}
