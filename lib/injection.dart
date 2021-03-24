import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/venues/data/datasources/favorite_data_source.dart';
import 'features/venues/data/datasources/venues_data_source.dart';
import 'features/venues/data/repositories/venues_repository_impl.dart';
import 'features/venues/domain/repositories/favorite_repository.dart';
import 'features/venues/domain/repositories/venues_repository.dart';
import 'features/venues/domain/usecases/get_details.dart';
import 'features/venues/domain/usecases/get_venues.dart';
import 'features/venues/domain/usecases/toogle_favorite_status.dart';
import 'features/venues/presentation/bloc/details_bloc.dart';
import 'features/venues/presentation/bloc/favorite_bloc.dart';
import 'features/venues/presentation/bloc/venues_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //BLOC
  sl.registerFactory(() => VenuesBloc(getVenues: sl()));
  sl.registerFactory(() => DetailsBloc(getDetails: sl()));
  sl.registerFactory(() => FavoriteBloc(toogleFavoriteStatus: sl()));

  //USECASES
  sl.registerFactory(() => GetVenues(repository: sl()));
  sl.registerFactory(() => GetDetails(repository: sl()));
  sl.registerFactory(() => ToogleFavoriteStatus(favoriteRepository: sl()));

  //REPOSITORIES
  sl.registerFactory<VenuesRepository>(() => VenuesRepositoryImpl(
        venuesDataSource: sl(),
        networkInfo: sl(),
      ));
  sl.registerFactory<FavoriteRepository>(
      () => FavoriteRepositoryImpl(favoriteDataSource: sl()));

  //DATASOURCES
  sl.registerFactory<VenuesDataSource>(() => VenuesDataSourceImpl(dio: sl()));
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerFactory<FavoriteDataSource>(
      () => SPFavoriteDataSourceImpl(sharedPreferences: sharedPreferences));

  //CORE
  sl.registerFactory<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerFactory(() => Dio());
  sl.registerFactory(() => DataConnectionChecker());
}
