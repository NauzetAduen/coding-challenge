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
    venuesDataSourceImpl = VenuesDataSourceImpl(dio: mockDio);
  });
  test('should return a List of venues', () async {
    //
    // when(mockDio.get(any)).thenAnswer((_) async => Response(data: {}));
    await venuesDataSourceImpl.getVenues("query");
  });
}
