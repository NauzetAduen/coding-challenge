import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/venue.dart';

abstract class VenuesRepository {
  Future<Either<Failure, List<Venue>>> getVenues(String query);
}
