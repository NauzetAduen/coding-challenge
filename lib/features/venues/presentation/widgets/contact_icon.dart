import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

///show and launch the link if possible
class ContactIcon extends StatelessWidget {
  final String link;
  final FaIcon icon;

  const ContactIcon({
    Key key,
    @required this.link,
    @required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (link.endsWith("/") || link.isEmpty) return Container();
    return Expanded(
        child: Center(
            child: IconButton(
      icon: icon,
      iconSize: 26,
      onPressed: () async => await canLaunch(link) ? await launch(link) : null,
    )));
  }
}
