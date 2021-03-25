import 'package:coding_challenge/features/venues/data/datasources/favorite_data_source.dart';
import 'package:coding_challenge/features/venues/data/repositories/favorite_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFavoriteDataSource extends Mock implements SPFavoriteDataSourceImpl {}

void main() {
  final MockFavoriteDataSource mockFavoriteDataSource =
      MockFavoriteDataSource();
  final FavoriteRepositoryImpl favoriteRepositoryImpl =
      FavoriteRepositoryImpl(favoriteDataSource: mockFavoriteDataSource);
  group('description', () {
    test('should return a Set<String> when calling datasource', () {
      when(mockFavoriteDataSource.toogleLikeStatus(any)).thenAnswer((_) => {});

      final result = favoriteRepositoryImpl.toogleFavoriteStatus("venueID");
      expect(result, isA<Set<String>>());
    });
  });
}
