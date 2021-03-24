import 'package:flutter/material.dart';

const double height = 60;

class FixedBox extends StatelessWidget {
  final Widget child;

  const FixedBox({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: child,
    );
  }
}
