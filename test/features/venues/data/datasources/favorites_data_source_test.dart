import 'package:coding_challenge/features/venues/data/datasources/favorite_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  final MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  final SPFavoriteDataSourceImpl favoriteDataSourceImpl =
      SPFavoriteDataSourceImpl(sharedPreferences: mockSharedPreferences);

  group('toogleFavoriteStatus', () {
    test('should return a Set of Strings when called', () async {
      when(mockSharedPreferences.getString(any)).thenAnswer((_) => "");
      when(mockSharedPreferences.getKeys()).thenAnswer((_) => {});

      final result = favoriteDataSourceImpl.changeLikeStatus("testID");

      expect(result, isA<Set<String>>());
    });
    test('should add an ID to list if not exist (null)', () async {
      when(mockSharedPreferences.getString("testID")).thenAnswer((_) => null);
      when(mockSharedPreferences.getKeys()).thenAnswer((_) => {"testID"});

      final result = favoriteDataSourceImpl.changeLikeStatus("testID");

      expect(result.contains("testID"), true);
    });

    test('should remove an ID to list if  exist (not null)', () async {
      when(mockSharedPreferences.getString("testID"))
          .thenAnswer((_) => "testID");
      when(mockSharedPreferences.getKeys()).thenAnswer((_) => {});

      final result = favoriteDataSourceImpl.changeLikeStatus("testID");

      expect(result.contains("testID"), false);
    });
  });
}
