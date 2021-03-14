import 'dart:convert';

import 'package:coding_challenge/core/error/exceptions.dart';
import 'package:coding_challenge/core/error/failures.dart';
import 'package:coding_challenge/core/network/network_info.dart';
import 'package:coding_challenge/features/venues/data/datasources/venues_data_source.dart';
import 'package:coding_challenge/features/venues/data/models/venue_model.dart';
import 'package:coding_challenge/features/venues/data/repositories/venues_repository_impl.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/reader.dart';

class MockVenuesDataSource extends Mock implements VenuesDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  VenuesRepositoryImpl venuesRepositoryImpl;
  MockVenuesDataSource mockVenuesDataSource;
  MockNetworkInfo mockNetworkInfo;
  setUp(() {
    mockVenuesDataSource = MockVenuesDataSource();
    mockNetworkInfo = MockNetworkInfo();
    venuesRepositoryImpl = VenuesRepositoryImpl(
      venuesDataSource: mockVenuesDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('getVenues', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('response.json')) as Map<String, dynamic>;

    final venueModel = VenueModel.fromJson(
        jsonMap['response']['venues'][0] as Map<String, dynamic>);

    final List<Venue> mockVenueList = [venueModel];

    group('is connected', () {
      setUp(() {
        //we return true for all the tests in this group
        when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(true));
      });
      test('should check if there is internet conection', () async {
        await venuesRepositoryImpl.getVenues({});

        verify(mockNetworkInfo.isConnected); //is connected is called
      });
      test('should return a List<Venue> when calling datasource', () async {
        when(mockVenuesDataSource.getVenues(any))
            .thenAnswer((_) async => mockVenueList);

        final result = await venuesRepositoryImpl.getVenues({});
        expect(result, Right(mockVenueList));
      });

      test('should return ServerFailure when call ins unsuccessful', () async {
        when(mockVenuesDataSource.getVenues(any)).thenThrow(ServerException());
        final result = await venuesRepositoryImpl.getVenues({});

        expect(result, Left(ServerFailure()));
      });
    });
  });
  group('is not connected', () {
    setUp(() {
      //we return false for all the tests in this group
      when(mockNetworkInfo.isConnected).thenAnswer((_) => Future.value(false));
    });

    test('should return ConnectionFailure when is not connected to inet',
        () async {
      final result = await venuesRepositoryImpl.getVenues({});

      expect(result, Left(ConnectionFailure()));
    });
  });
}
