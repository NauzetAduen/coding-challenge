import 'package:flutter/material.dart';

const String message = "What are you looking for?";

///Shows a message when you open the app
///
///Will not appear anymore
class InitialMessage extends StatelessWidget {
  const InitialMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Center(child: Text(message));
  //TODO use theme
}
