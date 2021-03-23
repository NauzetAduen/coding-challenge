import 'package:coding_challenge/core/error/failures.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';
import 'package:coding_challenge/features/venues/domain/repositories/venues_repository.dart';
import 'package:coding_challenge/features/venues/domain/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetDetails implements UseCase<VenueDetails, DetailsParam> {
  final VenuesRepository repository;

  GetDetails({@required this.repository});
  @override
  Future<Either<Failure, VenueDetails>> call(DetailsParam params) =>
      repository.getDetails(params.venueID);
}

class DetailsParam extends Equatable {
  final String venueID;

  const DetailsParam({@required this.venueID});

  @override
  List<Object> get props => [venueID];
}
