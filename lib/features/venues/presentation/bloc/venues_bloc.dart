import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:coding_challenge/core/error/failures.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/features/venues/domain/usecases/get_venues.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
part 'venues_event.dart';
part 'venues_state.dart';

const String unknownError = "Unknown error";

class VenuesBloc extends Bloc<VenuesEvent, VenuesState> {
  final GetVenues getVenues;

  VenuesBloc({@required this.getVenues}) : super(VenuesInitialState());

  @override
  Stream<VenuesState> mapEventToState(
    VenuesEvent event,
  ) async* {
    if (event is GetVenuesEvent) {
      yield LoadingVenuesState();
      final result = await getVenues(QueryParams(query: event.queryParams));
      yield result.fold(
        (failure) {
          if (failure is ServerFailure) {
            return ErrorVenuesState(message: failure.message);
          } else if (failure is ConnectionFailure) {
            return ErrorVenuesState(message: failure.message);
          }
          return const ErrorVenuesState(message: unknownError);
        },
        (venuesList) => LoadedVenuesState(venuesList: venuesList),
      );
    }
  }
}
