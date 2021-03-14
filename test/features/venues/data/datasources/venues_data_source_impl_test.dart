import 'package:coding_challenge/features/venues/data/datasources/venues_data_source.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockDio extends Mock implements Dio {}

void main() {
  VenuesDataSourceImpl venuesDataSourceImpl;
  MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    // venuesDataSourceImpl = VenuesDataSourceImpl(dio: mockDio);
    venuesDataSourceImpl = VenuesDataSourceImpl(dio: Dio());
  });
  test('should return a List of venues', () async {
    //
    when(mockDio.get(any))
        .thenAnswer((_) async => Response(data: {}, statusCode: 200));
    await venuesDataSourceImpl.getVenues({"near": "Las Palmas", "limit": 3});
  });
}
