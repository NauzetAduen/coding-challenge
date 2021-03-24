import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Summary extends StatelessWidget {
  final String summary;

  const Summary({Key key, @required this.summary}) : super(key: key);
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(FontAwesomeIcons.userFriends),
            const SizedBox(width: 16),
            Text(summary),
          ],
        ),
      );
}
