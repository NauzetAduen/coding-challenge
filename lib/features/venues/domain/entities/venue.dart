import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Venue extends Equatable {
  final String id;
  final String name;
  final Location location;
  final Category category;

  const Venue({
    @required this.id,
    @required this.name,
    @required this.location,
    @required this.category,
  });

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
    @required this.locationName,
    @required this.latitude,
    @required this.longitude,
    @required this.distance,
  });
}

class Category {
  final String name;
  final String photoUrl;

  //TODO (Add @required to category constructor)
  const Category({@required this.name, @required this.photoUrl});
}
