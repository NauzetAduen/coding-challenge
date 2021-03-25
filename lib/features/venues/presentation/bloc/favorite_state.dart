part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitialState extends FavoriteState {
  @override
  List<Object> get props => [];
}

class LoadedFavoriteState extends FavoriteState {
  final Set<String> keys;

  const LoadedFavoriteState({@required this.keys});
  @override
  List<Object> get props => [keys];
}
