import 'package:flutter/material.dart';

class CustomHero extends StatelessWidget {
  final String tag;
  final Widget child;

  const CustomHero({@required this.tag, @required this.child});
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        color: Colors.transparent,
        child: child,
      ),
    );
  }
}
