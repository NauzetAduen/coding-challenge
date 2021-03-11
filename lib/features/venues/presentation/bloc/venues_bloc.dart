import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'venues_event.dart';
part 'venues_state.dart';
class VenuesBloc extends Bloc<VenuesEvent, VenuesState> {
  VenuesBloc() : super(VenuesInitial());
  @override
  Stream<VenuesState> mapEventToState(
    VenuesEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
