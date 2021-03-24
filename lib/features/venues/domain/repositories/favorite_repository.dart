import 'package:coding_challenge/features/venues/data/datasources/favorite_data_source.dart';
import 'package:flutter/foundation.dart';

abstract class FavoriteRepository {
  Set<String> toogleFavoriteStatus(String venueID);
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource favoriteDataSource;

  FavoriteRepositoryImpl({@required this.favoriteDataSource});
  @override
  Set<String> toogleFavoriteStatus(String venueID) =>
      favoriteDataSource.changeLikeStatus(venueID);
}
