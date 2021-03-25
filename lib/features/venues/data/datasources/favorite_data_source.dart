import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class FavoriteDataSource {
  Set<String> toogleLikeStatus(String venueID);
}

class SPFavoriteDataSourceImpl implements FavoriteDataSource {
  final SharedPreferences sharedPreferences;

  SPFavoriteDataSourceImpl({@required this.sharedPreferences});
  @override
  Set<String> toogleLikeStatus(String venueID) {
    final value = sharedPreferences.getString(venueID);
    //if exist, we remove it
    if (value != null) {
      sharedPreferences.remove(venueID);
    } else {
      sharedPreferences.setString(venueID, "");
    }
    return sharedPreferences.getKeys();
  }
}
