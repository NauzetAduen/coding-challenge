import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/venue.dart';
import '../../domain/entities/venue_details.dart';
import '../../domain/repositories/venues_repository.dart';
import '../datasources/venues_data_source.dart';

class VenuesRepositoryImpl implements VenuesRepository {
  final VenuesDataSource venuesDataSource;
  final NetworkInfo networkInfo;

  VenuesRepositoryImpl({
    @required this.venuesDataSource,
    @required this.networkInfo,
  });
  @override
  Future<Either<Failure, List<Venue>>> getVenues(
      Map<String, dynamic> queryParams) async {
    if (await networkInfo.isConnected) {
      try {
        final venues = await venuesDataSource.getVenues(queryParams);
        return Right(venues);
      } on ServerException {
        return Left(ServerFailure());
      } on PermissionException {
        return Left(PermissionFailure());
      } on DioError {
        return Left(ConnectionFailure());
      }
    }
    return Left(ConnectionFailure());
  }

  @override
  Future<Either<Failure, VenueDetails>> getDetails(String venueID) async {
    if (await networkInfo.isConnected) {
      try {
        final details = await venuesDataSource.getDetails(venueID);
        return Right(details);
      } on ServerException {
        return Left(ServerFailure());
      }
      //we don't need On PermissionException here
    }
    return Left(ConnectionFailure());
  }
}
