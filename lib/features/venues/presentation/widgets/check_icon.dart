import 'package:flutter/material.dart';

const double iconSize = 20;

class CheckIcon extends StatelessWidget {
  final bool verified;

  const CheckIcon({Key key, this.verified}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return verified
        ? const Icon(Icons.check_circle_outline,
            color: Colors.lightBlue, size: iconSize)
        : const Icon(Icons.check_circle_outline,
            color: Colors.grey, size: iconSize);
  }
}
