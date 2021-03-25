import 'package:flutter/foundation.dart';

import '../repositories/favorite_repository.dart';

class ToogleFavoriteStatus {
  final FavoriteRepository favoriteRepository;

  ToogleFavoriteStatus({@required this.favoriteRepository});

  Set<String> call({@required String venueID}) =>
      favoriteRepository.toogleFavoriteStatus(venueID);
}
