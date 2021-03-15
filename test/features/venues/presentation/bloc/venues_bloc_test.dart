import 'dart:convert';

import 'package:coding_challenge/core/error/failures.dart';
import 'package:coding_challenge/features/venues/data/models/venue_model.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/features/venues/domain/usecases/get_venues.dart';
import 'package:coding_challenge/features/venues/presentation/bloc/venues_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/reader.dart';

class MockGetVenues extends Mock implements GetVenues {}

void main() {
  VenuesBloc venuesBloc;
  MockGetVenues mockGetVenues;

  setUp(() {
    mockGetVenues = MockGetVenues();
    venuesBloc = VenuesBloc(getVenues: mockGetVenues);
  });

  test('initial state should be VenuesInitialState', () async {
    expect(venuesBloc.state, VenuesInitialState());

    //this is correct because we pass VenuesInitialState on
    //super after calling VenuesBloc constructor
  });

  group('getVenues', () {
    final Map<String, dynamic> jsonMap =
        json.decode(fixture('response.json')) as Map<String, dynamic>;

    final venueModel = VenueModel.fromJson(
        jsonMap['response']['venues'][0] as Map<String, dynamic>);

    final List<Venue> mockVenueList = [venueModel];
    test('should get called with the correct params', () async {
      when(mockGetVenues(any)).thenAnswer((_) async => const Right([]));

      venuesBloc.add(const GetVenuesEvent(queryParams: {}));
      await untilCalled(mockGetVenues(any));

      verify(mockGetVenues(const QueryParams(query: {})));
    });

    test('should emit [Loading, Loaded] when usecase is successful', () async {
      when(mockGetVenues(any)).thenAnswer((_) async => Right(mockVenueList));

      venuesBloc.add(const GetVenuesEvent(queryParams: {}));
      final expected = [
        LoadingVenuesState(),
        LoadedVenuesState(venuesList: mockVenueList),
      ];
      expectLater(venuesBloc, emitsInOrder(expected));
    });
    test('should emit [Loading, Error] when there is a server failure',
        () async {
      final ServerFailure serverFailure = ServerFailure();
      when(mockGetVenues(any)).thenAnswer((_) async => Left(serverFailure));

      venuesBloc.add(const GetVenuesEvent(queryParams: {}));
      final expected = [
        LoadingVenuesState(),
        ErrorVenuesState(message: serverFailure.message),
      ];
      expectLater(venuesBloc, emitsInOrder(expected));
    });
    test('should emit [Loading, Error] when there is a connection problem',
        () async {
      final ConnectionFailure connectionFailure = ConnectionFailure();
      when(mockGetVenues(any)).thenAnswer((_) async => Left(connectionFailure));

      venuesBloc.add(const GetVenuesEvent(queryParams: {}));
      final expected = [
        LoadingVenuesState(),
        ErrorVenuesState(message: connectionFailure.message),
      ];
      expectLater(venuesBloc, emitsInOrder(expected));
    });
  });
}
