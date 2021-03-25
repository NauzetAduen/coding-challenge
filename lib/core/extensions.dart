import '../features/venues/domain/entities/venue_details.dart';

/// we use it for not showing anything if Everything is empty
///
/// instead of having 4 empty containers
extension EmptyValues on Contact {
  bool areNotAllEmpty() {
    //return true if one of them is not empty
    return facebook.isNotEmpty ||
        twitter.isNotEmpty ||
        instagram.isNotEmpty ||
        phone.isNotEmpty;
  }
}
