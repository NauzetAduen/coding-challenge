import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  final String data;
  const TextError({
    Key key,
    @required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Center(
          child: Text(
        data,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ));
}
