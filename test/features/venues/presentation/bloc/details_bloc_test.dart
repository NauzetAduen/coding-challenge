import 'package:coding_challenge/core/error/failures.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';
import 'package:coding_challenge/features/venues/domain/usecases/get_details.dart';
import 'package:coding_challenge/features/venues/presentation/bloc/details_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockGetDetails extends Mock implements GetDetails {}

void main() {
  DetailsBloc detailsBloc;
  MockGetDetails mockGetDetails;

  setUp(() {
    mockGetDetails = MockGetDetails();
    detailsBloc = DetailsBloc(getDetails: mockGetDetails);
  });

  test('initial state should be VenuesInitialState', () async {
    expect(detailsBloc.state, DetailsInitialState());
  });

  group('getDetails', () {
    const VenueDetails venueDetails = VenueDetails(
      url: "url.com",
      summary: "summary",
      verified: true,
      description: "description",
      contact: Contact(
          facebook: "1234fb",
          phone: "1234",
          instagram: "1234insta",
          twitter: "1234tw"),
    );
    test('should get called with the correct params', () async {
      when(mockGetDetails(any))
          .thenAnswer((_) async => const Right(venueDetails));

      detailsBloc.add(const GetDetailsEvent(venueID: "venueID"));
      await untilCalled(mockGetDetails(any));

      verify(mockGetDetails(const DetailsParam(venueID: "venueID")));
    });

    test('should emit [Loading, Loaded] when usecase is successful', () async {
      when(mockGetDetails(any))
          .thenAnswer((_) async => const Right(venueDetails));

      detailsBloc.add(const GetDetailsEvent(venueID: "venueID"));
      final expected = [
        LoadingDetailsState(),
        const LoadedDetailsState(venueDetails: venueDetails),
      ];
      expectLater(detailsBloc, emitsInOrder(expected));
    });
    test('should emit [Loading, Error] when there is a server failure',
        () async {
      final ServerFailure serverFailure = ServerFailure();
      when(mockGetDetails(any)).thenAnswer((_) async => Left(serverFailure));

      detailsBloc.add(const GetDetailsEvent(venueID: "venueID"));
      final expected = [
        LoadingDetailsState(),
        ErrorDetailsState(message: serverFailure.message),
      ];
      expectLater(detailsBloc, emitsInOrder(expected));
    });
    test('should emit [Loading, Error] when there is a connection problem',
        () async {
      final ConnectionFailure connectionFailure = ConnectionFailure();
      when(mockGetDetails(any))
          .thenAnswer((_) async => Left(connectionFailure));

      detailsBloc.add(const GetDetailsEvent(venueID: "venueID"));
      final expected = [
        LoadingDetailsState(),
        ErrorDetailsState(message: connectionFailure.message),
      ];
      expectLater(detailsBloc, emitsInOrder(expected));
    });
  });
}
