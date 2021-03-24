import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../entities/venue_details.dart';
import '../repositories/venues_repository.dart';
import 'usecases.dart';

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
