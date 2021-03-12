import 'package:coding_challenge/core/error/exceptions.dart';
import 'package:coding_challenge/core/network/network_info.dart';
import 'package:coding_challenge/features/venues/data/datasources/venues_data_source.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/core/error/failures.dart';
import 'package:coding_challenge/features/venues/domain/repositories/venues_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class VenuesRepositoryImpl implements VenuesRepository {
  final VenuesDataSource venuesDataSource;
  final NetworkInfo networkInfo;

  VenuesRepositoryImpl({
    @required this.venuesDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Venue>>> getVenues(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final venues = await venuesDataSource.getVenues(query);
        return Right(venues);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    return Left(ConnectionFailure());
  }
}
