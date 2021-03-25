import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';
import 'package:coding_challenge/features/venues/domain/repositories/venues_repository.dart';
import 'package:coding_challenge/features/venues/domain/usecases/get_details.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockVenuesRepository extends Mock implements VenuesRepository {}

void main() {
  GetDetails usecase;
  MockVenuesRepository mockVenuesRepository;
  setUp(() {
    mockVenuesRepository = MockVenuesRepository();
    usecase = GetDetails(repository: mockVenuesRepository);
  });

  //const variables, not modifiable by our setup function
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

  test('should get a venueDetail from the repository', () async {
    when(mockVenuesRepository.getDetails(any))
        .thenAnswer((_) async => const Right(venueDetails));

    final result = await usecase(const DetailsParam(venueID: ""));
    expect(result, const Right(venueDetails));
  });
}
