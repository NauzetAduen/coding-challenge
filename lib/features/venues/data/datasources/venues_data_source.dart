import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/entities/venue.dart';
import '../../domain/entities/venue_details.dart';
import '../models/venue_details_model.dart';
import '../models/venue_model.dart';
import 'venues_data_source_config.dart';

abstract class VenuesDataSource {
  Future<List<Venue>> getVenues(Map<String, dynamic> queryParams);
  Future<VenueDetails> getDetails(String venueID);
}

///Layer to acess data
///
///[Throws DioErrors and PermissionExceptions]
///
///Uses Dio httpclient for simpliticy in timeouts and other query params
class VenuesDataSourceImpl implements VenuesDataSource {
  final Dio dio;

  VenuesDataSourceImpl({@required this.dio});

  ///Get a List of Venues if Geolocator works
  ///
  ///if not, throws Exceptions
  ///
  ///if response status is not 200, return empty array
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
      final BaseOptions baseOptions = BaseOptions(
          method: 'GET',
          baseUrl: baseURL,
          connectTimeout: connectTimeout,
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
      //rethrow dio errors
      rethrow;
    }
  }

  ///get details of a single venue
  ///
  ///Hast a limit usage (90~ per day)
  ///
  /// return a VenueDetails or null depending on statusCode
  @override
  Future<VenueDetails> getDetails(String venueID) async {
    try {
      final BaseOptions baseOptions = BaseOptions(
          method: 'GET',
          baseUrl: baseURL,
          connectTimeout: connectTimeout,
          queryParameters: {
            'client_id': clientID,
            'client_secret': clientSecret,
            'v': version,
          });

      dio.options = baseOptions;
      final Response response = await dio.request('/$venueID');
      if (response.statusCode == 200) {
        return VenueDetailsModel.fromJson(
            response.data['response'] as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
