import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

/*
  Simple venue entity
  which use own Location and Category classes
*/
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

class Location extends Equatable {
  final String locationName;
  final double latitude;
  final double longitude;
  final int distance;

  const Location({
    @required this.locationName,
    @required this.latitude,
    @required this.longitude,
    @required this.distance,
  });

  @override
  List<Object> get props => [locationName, latitude, longitude, distance];
}

class Category extends Equatable {
  final String name;
  final String photoUrl;

  const Category({@required this.name, @required this.photoUrl});

  @override
  List<Object> get props => [name, photoUrl];
}
