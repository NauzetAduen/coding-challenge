part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
}

class ChangeFavoriteStatusEvent extends FavoriteEvent {
  final String venueID;

  const ChangeFavoriteStatusEvent({@required this.venueID});
  @override
  List<Object> get props => [];
}
