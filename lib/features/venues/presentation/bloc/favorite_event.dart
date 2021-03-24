part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class ToogleFavoriteStatusEvent extends FavoriteEvent {
  final String venueID;

  const ToogleFavoriteStatusEvent({@required this.venueID});
  @override
  List<Object> get props => [];
}
