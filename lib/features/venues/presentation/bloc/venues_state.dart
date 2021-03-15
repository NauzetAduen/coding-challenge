part of 'venues_bloc.dart';

abstract class VenuesState extends Equatable {
  const VenuesState();
}

class VenuesInitialState extends VenuesState {
  @override
  List<Object> get props => [];
}

class LoadingVenuesState extends VenuesState {
  @override
  List<Object> get props => [];
}

class LoadedVenuesState extends VenuesState {
  final List<Venue> venuesList;

  const LoadedVenuesState({@required this.venuesList});
  @override
  List<Object> get props => [venuesList];
}

class ErrorVenuesState extends VenuesState {
  final String message;

  const ErrorVenuesState({@required this.message});
  @override
  List<Object> get props => [message];
}
