import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/venue_details.dart';
import '../../domain/usecases/get_details.dart';

part 'details_event.dart';
part 'details_state.dart';

const String unknownError = "Unknown error";

///State Managemenent
///
///When ui calls for GetDetailsEvent:
///
///use getDetails Usecase and yield states depending of returning types:
///
///Failures --> errorsStates
///
///details --> LoadedState
class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final GetDetails getDetails;

  DetailsBloc({@required this.getDetails}) : super(DetailsInitialState());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    //
    if (event is GetDetailsEvent) {
      yield LoadingDetailsState();
      final result = await getDetails(DetailsParam(venueID: event.venueID));

      yield result.fold((failure) {
        if (failure is ServerFailure) {
          return ErrorDetailsState(message: failure.message);
        } else if (failure is ConnectionFailure) {
          return ErrorDetailsState(message: failure.message);
        } else if (failure is PermissionFailure) {
          return ErrorDetailsState(message: failure.message);
        }
        return const ErrorDetailsState(message: unknownError);
      }, (details) => LoadedDetailsState(venueDetails: details));
    }
  }
}
