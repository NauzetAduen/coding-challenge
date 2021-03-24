import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/venue.dart';
import '../../domain/usecases/get_venues.dart';

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
          } else if (failure is PermissionFailure) {
            return ErrorVenuesState(message: failure.message);
          }
          return const ErrorVenuesState(message: unknownError);
        },
        (venuesList) {
          if (venuesList.isEmpty) return EmptyVenuesState();
          return LoadedVenuesState(venuesList: venuesList);
        },
      );
    }
  }
}
