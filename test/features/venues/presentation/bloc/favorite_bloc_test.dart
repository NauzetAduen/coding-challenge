import 'package:coding_challenge/features/venues/domain/usecases/toogle_favorite_status.dart';
import 'package:coding_challenge/features/venues/presentation/bloc/favorite_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockToogleFavoriteStatus extends Mock implements ToogleFavoriteStatus {}

void main() {
  final MockToogleFavoriteStatus mockToogleFavoriteStatus =
      MockToogleFavoriteStatus();

  final FavoriteBloc favoriteBloc =
      FavoriteBloc(toogleFavoriteStatus: mockToogleFavoriteStatus);

  test('initial state should be FavoriteInitialState', () async {
    expect(favoriteBloc.state, FavoriteInitialState());
  });

  group('toogleFavoriteStatus', () {
    test('should emit [Loaded] when usecase is successful', () async {
      when(mockToogleFavoriteStatus(venueID: "venueID"))
          .thenAnswer((_) => {"venueID"});

      favoriteBloc.add(const ToogleFavoriteStatusEvent(venueID: "venueID"));
      final expected = [
        const LoadedFavoriteState(keys: {"venueID"}),
      ];
      expectLater(favoriteBloc, emitsInOrder(expected));
    });
  });
}
