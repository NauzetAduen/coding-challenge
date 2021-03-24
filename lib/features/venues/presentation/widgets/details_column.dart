import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/extensions.dart';
import '../../domain/entities/venue_details.dart';
import 'contact_icon.dart';
import 'description.dart';
import 'fixed_box.dart';
import 'summary.dart';

class DetailsColumn extends StatelessWidget {
  final VenueDetails venueDetails;
  const DetailsColumn({
    Key key,
    @required this.venueDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (venueDetails.contact.areNotAllEmpty())
          FixedBox(
            child: Row(
              children: [
                ContactIcon(
                  link: "https://facebook.com/${venueDetails.contact.facebook}",
                  icon: const FaIcon(FontAwesomeIcons.facebookSquare,
                      color: Colors.blue),
                ),
                ContactIcon(
                  link: "https://twitter.com/${venueDetails.contact.twitter}",
                  icon: const FaIcon(FontAwesomeIcons.twitterSquare,
                      color: Colors.lightBlue),
                ),
                ContactIcon(
                  link:
                      "https://www.instagram.com/${venueDetails.contact.instagram}",
                  icon: const FaIcon(FontAwesomeIcons.instagramSquare,
                      color: Colors.pink),
                ),
                ContactIcon(
                  link: "tel://${venueDetails.contact.phone}",
                  icon: const FaIcon(FontAwesomeIcons.phoneSquare,
                      color: Colors.green),
                ),
                ContactIcon(
                  link: venueDetails.url,
                  icon: const FaIcon(FontAwesomeIcons.externalLinkAlt),
                ),
              ],
            ),
          ),
        Summary(summary: venueDetails.summary),
        Description(description: venueDetails.description),
      ],
    );
  }
}
