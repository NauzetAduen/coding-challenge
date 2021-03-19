import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:flutter/material.dart';

class MapView extends StatelessWidget {
  final List<Venue> list;

  const MapView({Key key, this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Test"));
  }
}
