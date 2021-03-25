import 'package:flutter/foundation.dart';

import '../../domain/entities/venue_details.dart';

///Has serialization, not like VenueDetails entity, to avoid Venue being over exposed to datasources.
///
///Transforming raw data required conversion logic
class VenueDetailsModel extends VenueDetails {
  const VenueDetailsModel({
    @required String description,
    @required String url,
    @required String summary,
    @required bool verified,
    @required Contact contact,
  }) : super(
          summary: summary,
          description: description,
          url: url,
          verified: verified,
          contact: contact,
        );

  factory VenueDetailsModel.fromJson(Map<String, dynamic> json) {
    final Contact contact = Contact(
      twitter: json['venue']['contact']['twitter'] as String ?? "",
      instagram: json['venue']['contact']['instagram'] as String ?? "",
      facebook: json['venue']['contact']['facebook'] as String ?? "",
      phone: json['venue']['contact']['phone'] as String ?? "",
    );

    return VenueDetailsModel(
        description: json['venue']['description'] as String ??
            "No description provided.",
        url: json['venue']['url'] as String ?? "",
        summary: json['venue']['hereNow']['summary'] as String ??
            "No summary provided.",
        verified: json['venue']['verified'] as bool ?? false,
        contact: contact);
  }
}
