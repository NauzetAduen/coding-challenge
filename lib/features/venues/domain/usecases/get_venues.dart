import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/failures.dart';
import '../entities/venue.dart';
import '../repositories/venues_repository.dart';
import 'usecases.dart';

//usecase for simple venues, w/o anything extra, like intents
class GetVenues implements UseCase<List<Venue>, QueryParams> {
  VenuesRepository repository;

  GetVenues({@required this.repository});
  @override
  Future<Either<Failure, List<Venue>>> call(QueryParams params) async =>
      repository.getVenues(params.query);
}

class QueryParams extends Equatable {
  final Map<String, dynamic> query;

  const QueryParams({@required this.query});

  @override
  List<Object> get props => [query];
}
