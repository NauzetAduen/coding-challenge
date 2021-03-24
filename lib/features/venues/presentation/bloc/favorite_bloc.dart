import 'package:coding_challenge/features/venues/domain/usecases/toogle_favorite_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final ToogleFavoriteStatus toogleFavoriteStatus;

  FavoriteBloc({@required this.toogleFavoriteStatus})
      : super(FavoriteInitialState());

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is ChangeFavoriteStatusEvent) {
      final result = toogleFavoriteStatus(venueID: event.venueID);

      yield LoadedFavoriteState(keys: result);
    }
  }
}
