import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/features/venues/domain/repositories/venues_repository.dart';
import 'package:coding_challenge/features/venues/domain/usecases/get_venues.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockVenuesRepository extends Mock implements VenuesRepository {}

void main() {
  GetVenues usecase;
  MockVenuesRepository mockVenuesRepository;
  setUp(() {
    mockVenuesRepository = MockVenuesRepository();
    usecase = GetVenues(repository: mockVenuesRepository);
  });

  //const variables, not modifiable by our setup function
  const Venue mockVenue = Venue(
      id: "id",
      name: "Hotel abc",
      location: Location(
          distance: 123,
          locationName: "Las Palmas 123",
          longitude: 1.0,
          latitude: 1.0),
      category: Category(name: "hotel", photoUrl: "123.com/1.png"));
  const List<Venue> mockVenueList = [mockVenue];
  const QueryParams mockQueryParams = QueryParams({"near": "Las Palmas"});

  test('should get a list of venues from the repository', () async {
    when(mockVenuesRepository.getVenues(any))
        .thenAnswer((_) async => const Right(mockVenueList));

    final result = await usecase(mockQueryParams);
    expect(result, const Right(mockVenueList));
  });
}
