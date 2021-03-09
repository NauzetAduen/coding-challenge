import 'package:flutter/material.dart';

void main() => runApp(CodingChallengeApp());

const appName = "Coding Challenge";

class CodingChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(body: Center(child: Text("Abc"))));
}
