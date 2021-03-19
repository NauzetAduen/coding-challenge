import 'package:coding_challenge/core/error/exceptions.dart';
import 'package:coding_challenge/features/venues/data/models/venue_model.dart';
import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'venues_data_source_config.dart';

abstract class VenuesDataSource {
  Future<List<Venue>> getVenues(Map<String, dynamic> queryParams);
}

class VenuesDataSourceImpl implements VenuesDataSource {
  final Dio dio;

  VenuesDataSourceImpl({@required this.dio});
  @override
  Future<List<Venue>> getVenues(Map<String, dynamic> queryParams) async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw PermissionException();

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied) {
        throw PermissionException();
      }
    }

    try {
      final Position position = await Geolocator.getCurrentPosition();
      final BaseOptions baseOptions =
          BaseOptions(method: 'GET', baseUrl: baseURL,
              // connectTimeout: connectTimeout,
              queryParameters: {
            'client_id': clientID,
            'client_secret': clientSecret,
            'v': version,
          });
      baseOptions.queryParameters.putIfAbsent(
        'll',
        () => "${position.latitude},${position.longitude}",
      );
      baseOptions.queryParameters.putIfAbsent(
        'limit',
        () => 15,
      );

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
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
