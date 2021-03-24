import 'dart:convert';

import 'package:coding_challenge/features/venues/data/datasources/venues_data_source.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/reader.dart';

class MockDio extends Mock implements Dio {}

class MockGeolocator extends Mock implements Geolocator {}

//TODO MOCK GEOLOCATOR
//https://stackoverflow.com/questions/58238435/how-to-mock-a-static-method-in-flutter-with-mockito
//You cannot mock static members. If you need to mock then, don't make them static – Rémi Rousselet
//https://github.com/dart-lang/mockito/issues/214
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  VenuesDataSourceImpl venuesDataSourceImpl;
  MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    venuesDataSourceImpl = VenuesDataSourceImpl(dio: mockDio);
    // venuesDataSourceImpl = VenuesDataSourceImpl(dio: Dio());
  });
  group('getVenues', () {
    test('should return a empty List of venues when passed an empty list',
        () async {
      when(mockDio.request(any)).thenAnswer((_) async => Response(data: {
            'response': {"venues": []}
          }, statusCode: 200));
      final result = await venuesDataSourceImpl.getVenues({"limit": 3});
      expect(result, isA<List<Venue>>());
      expect(result.isEmpty, true);
    });
    test('should return a List of venues with size 1 when passed fixture',
        () async {
      when(mockDio.request(any)).thenAnswer((_) async => Response(
          data: json.decode(fixture('response.json')), statusCode: 200));
      final result = await venuesDataSourceImpl
          .getVenues({"near": "Las Palmas", "limit": 1});
      expect(result.length, 1);
    });
  });
  group('getDetails', () {
    test('should return a venues details ', () async {
      when(mockDio.request(any)).thenAnswer((_) async => Response(
          data: json.decode(fixture('details_response.json')),
          statusCode: 200));
      final result = await venuesDataSourceImpl.getDetails("");
      expect(result, isA<VenueDetails>());
    });
  });
}
