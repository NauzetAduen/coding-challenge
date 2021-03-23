import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class VenueDetails extends Equatable {
  final String description;
  final bool verified;
  final String url;
  final Contact contact;
  final String summary;

  const VenueDetails({
    @required this.verified,
    @required this.url,
    @required this.description,
    @required this.contact,
    @required this.summary,
  });
  @override
  List<Object> get props => [description, verified, url, contact, summary];
}

class Contact extends Equatable {
  final String phone;
  final String twitter;
  final String instagram;
  final String facebook;

  const Contact({
    @required this.phone,
    @required this.twitter,
    @required this.instagram,
    @required this.facebook,
  });
  @override
  List<Object> get props => [phone, twitter, instagram, facebook];
}
