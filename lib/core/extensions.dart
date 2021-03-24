import 'package:coding_challenge/features/venues/domain/entities/venue_details.dart';

extension EmptyValues on Contact {
  bool areNotAllEmpty() {
    //return true if one of them is not empty
    return facebook.isNotEmpty ||
        twitter.isNotEmpty ||
        instagram.isNotEmpty ||
        phone.isNotEmpty;
  }
}
