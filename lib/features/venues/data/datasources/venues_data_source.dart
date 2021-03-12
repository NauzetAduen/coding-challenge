import 'package:coding_challenge/features/venues/domain/entities/venue.dart';

abstract class VenuesDataSource {
  Future<List<Venue>> getVenues(String query);
}
