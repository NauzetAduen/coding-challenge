part of 'details_bloc.dart';

abstract class DetailsState extends Equatable {
  const DetailsState();
}

class DetailsInitialState extends DetailsState {
  @override
  List<Object> get props => [];
}

class LoadingDetailsState extends DetailsState {
  @override
  List<Object> get props => [];
}

class LoadedDetailsState extends DetailsState {
  final VenueDetails venueDetails;

  const LoadedDetailsState({@required this.venueDetails});
  @override
  List<Object> get props => [venueDetails];
}

class ErrorDetailsState extends DetailsState {
  final String message;
  const ErrorDetailsState({@required this.message});
  @override
  List<Object> get props => [message];
}
