import 'package:flutter/foundation.dart';

import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_data_source.dart';

///Implements Domain contract
///
///Doens't have any domain logic because the simplicity of the usecase
class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource favoriteDataSource;

  FavoriteRepositoryImpl({@required this.favoriteDataSource});
  @override
  Set<String> toogleFavoriteStatus(String venueID) =>
      favoriteDataSource.toogleLikeStatus(venueID);
}
