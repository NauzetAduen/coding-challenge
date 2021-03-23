import 'dart:convert';

import 'package:coding_challenge/features/venues/data/models/venue_details_model.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/reader.dart';

void main() {
  const venueDetailModel = VenueDetailsModel(
    description: "description",
    url: "url",
    summary: "summary",
    verified: true,
    contact: Contact(
        facebook: "fb", instagram: "insta", twitter: "tw", phone: "1234"),
  );

  test(
    'should be a subclass of venue entity',
    () async {
      expect(venueDetailModel, isA<VenueDetails>());
    },
  );

  group('fromJson', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('details_response.json')) as Map<String, dynamic>;

    final result =
        VenueDetailsModel.fromJson(jsonMap['response'] as Map<String, dynamic>);

    test('should get a valid model from a fixture', () async {
      expect(result, isA<VenueDetailsModel>());
    });
    test('should parse the correct model from a fixture', () async {
      expect(result, venueDetailModel);
    });
  });
}
