import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'venues_data_source_config.dart';

abstract class VenuesDataSource {
  Future<List<Venue>> getVenues(String query);
}

class VenuesDataSourceImpl implements VenuesDataSource {
  final Dio dio;

  VenuesDataSourceImpl({@required this.dio});
  @override
  Future<List<Venue>> getVenues(String query) async {
    try {
      final Response response = await dio.get(baseURL);
      if (response.statusCode == 200) {
        //SERIALIZE
      }
      print(response);
    } catch (e) {
      rethrow;
    }
  }
}
