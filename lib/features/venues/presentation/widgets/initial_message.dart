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
  Widget build(BuildContext context) => Center(
          child: Text(
        message,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ));
}
