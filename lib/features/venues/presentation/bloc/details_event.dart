part of 'details_bloc.dart';

abstract class DetailsEvent extends Equatable {
  const DetailsEvent();
}

class GetDetailsEvent extends DetailsEvent {
  final String venueID;

  const GetDetailsEvent({@required this.venueID});
  @override
  List<Object> get props => [venueID];
}
