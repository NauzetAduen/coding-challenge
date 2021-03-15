import 'package:flutter/material.dart';

import 'core/router.dart';
import 'injection.dart';

void main() {
  init();
  runApp(CodingChallengeApp());
}

const appName = "Coding Challenge";

class CodingChallengeApp extends StatefulWidget {
  @override
  _CodingChallengeAppState createState() => _CodingChallengeAppState();
}

class _CodingChallengeAppState extends State<CodingChallengeApp> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        onGenerateRoute: CustomRouter.generateRoute,
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      );
}
