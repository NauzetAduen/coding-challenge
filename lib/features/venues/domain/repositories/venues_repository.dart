import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/venue.dart';

abstract class VenuesRepository {
  Future<Either<Failure, List<Venue>>> getVenues(
      Map<String, dynamic> queryParams);

  Future<Either<Failure, VenueDetails>> getDetails(String venueID);
}
