import 'dart:convert';

import 'package:coding_challenge/features/venues/data/datasources/venues_data_source.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/reader.dart';

class MockDio extends Mock implements Dio {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  VenuesDataSourceImpl venuesDataSourceImpl;
  MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    venuesDataSourceImpl = VenuesDataSourceImpl(dio: mockDio);
    // venuesDataSourceImpl = VenuesDataSourceImpl(dio: Dio());
  });
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
    when(mockDio.request(any)).thenAnswer((_) async =>
        Response(data: json.decode(fixture('response.json')), statusCode: 200));
    final result = await venuesDataSourceImpl
        .getVenues({"near": "Las Palmas", "limit": 1});
    expect(result.length, 1);
  });
}
