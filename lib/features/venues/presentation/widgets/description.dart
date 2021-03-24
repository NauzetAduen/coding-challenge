import 'package:flutter/material.dart';

class Description extends StatelessWidget {
  final String description;

  const Description({Key key, @required this.description}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        description,
        textAlign: TextAlign.justify,
      ),
    );
  }
}
