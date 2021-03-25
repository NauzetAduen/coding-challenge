import 'package:coding_challenge/features/venues/data/repositories/favorite_repository_impl.dart';
import 'package:coding_challenge/features/venues/domain/usecases/toogle_favorite_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFavoriteRepositoryImpl extends Mock
    implements FavoriteRepositoryImpl {}

void main() {
  final MockFavoriteRepositoryImpl mockFavoriteRepositoryImpl =
      MockFavoriteRepositoryImpl();
  final ToogleFavoriteStatus usecase =
      ToogleFavoriteStatus(favoriteRepository: mockFavoriteRepositoryImpl);

  test('should get a Set<String> from the repository', () async {
    when(mockFavoriteRepositoryImpl.toogleFavoriteStatus("venueID"))
        .thenAnswer((_) => {});

    final result = usecase(venueID: "venueID");
    expect(result, isA<Set<String>>());
  });
}
