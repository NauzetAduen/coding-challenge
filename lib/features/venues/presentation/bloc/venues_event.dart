part of 'venues_bloc.dart';

abstract class VenuesEvent extends Equatable {
  const VenuesEvent();
}

class GetVenuesEvent extends VenuesEvent {
  final Map<String, dynamic> queryParams;

  const GetVenuesEvent({@required this.queryParams});
  @override
  List<Object> get props => [queryParams];
}
