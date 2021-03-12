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
      //TODO (DioError [DioErrorType.RESPONSE]: Http status error [400])
      print(response.statusCode);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
