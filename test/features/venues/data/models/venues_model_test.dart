import 'dart:convert';

import 'package:coding_challenge/features/venues/data/models/venue_model.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/reader.dart';

void main() {
  const venueModel = VenueModel(
      id: "3fd66200f964a5209beb1ee3",
      name: "Peter Luger Steak House",
      location: Location(
        distance: 10,
        latitude: 40.70995790682886,
        locationName: "178 Broadway",
        longitude: -73.96229110893742,
      ),
      category: Category(
          name: "Steakhouse",
          photoUrl:
              "https://ss3.4sqi.net/img/categories_v2/food/steakhouse_32.png"));

  test(
    'should be a subclass of venue entity',
    () async {
      expect(venueModel, isA<Venue>());
    },
  );

  test('should get a valid model from a fixture', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('venue.json')) as Map<String, dynamic>;

    final result = VenueModel.fromJson(
        jsonMap['response']['venues'][0] as Map<String, dynamic>);
    expect(result, isA<VenueModel>());
  });
  test('should parse the correct model from a fixture', () async {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('venue.json')) as Map<String, dynamic>;

    final result = VenueModel.fromJson(
        jsonMap['response']['venues'][0] as Map<String, dynamic>);
    expect(result, venueModel);
  });
}
