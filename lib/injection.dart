import 'package:coding_challenge/core/network/network_info.dart';
import 'package:coding_challenge/features/venues/data/datasources/venues_data_source.dart';
import 'package:coding_challenge/features/venues/data/repositories/venues_repository_impl.dart';
import 'package:coding_challenge/features/venues/domain/repositories/venues_repository.dart';
import 'package:coding_challenge/features/venues/presentation/bloc/details_bloc.dart';
import 'package:coding_challenge/features/venues/presentation/bloc/venues_bloc.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/venues/domain/usecases/get_details.dart';
import 'features/venues/domain/usecases/get_venues.dart';

final GetIt sl = GetIt.instance;

void init() {
  //BLOC
  sl.registerFactory(() => VenuesBloc(getVenues: sl()));
  sl.registerFactory(() => DetailsBloc(getDetails: sl()));

  //USECASES
  sl.registerFactory(() => GetVenues(repository: sl()));
  sl.registerFactory(() => GetDetails(repository: sl()));

  //REPOSITORIES
  sl.registerFactory<VenuesRepository>(() => VenuesRepositoryImpl(
        venuesDataSource: sl(),
        networkInfo: sl(),
      ));

  //DATASOURCES
  sl.registerFactory<VenuesDataSource>(() => VenuesDataSourceImpl(dio: sl()));

  //CORE
  sl.registerFactory<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerFactory(() => Dio());
  sl.registerFactory(() => DataConnectionChecker());
}
