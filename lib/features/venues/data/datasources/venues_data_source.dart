import 'package:coding_challenge/features/venues/data/models/venue_model.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'venues_data_source_config.dart';

abstract class VenuesDataSource {
  Future<List<Venue>> getVenues(Map<String, dynamic> queryParams);
}

class VenuesDataSourceImpl implements VenuesDataSource {
  final Dio dio;

  VenuesDataSourceImpl({@required this.dio});
  @override
  Future<List<Venue>> getVenues(Map<String, dynamic> queryParams) async {
    try {
      queryParams.forEach((key, value) {
        baseOptions.queryParameters.putIfAbsent(key, () => value);
      });

      dio.options = baseOptions;
      final Response response = await dio.request('/search');

      if (response.statusCode == 200) {
        final List<Venue> venuesList = [];
        final List<dynamic> result =
            response.data['response']['venues'] as List<dynamic>;

        for (final venueMap in result) {
          venuesList.add(VenueModel.fromJson(venueMap as Map<String, dynamic>));
        }

        return venuesList;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}
