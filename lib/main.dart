import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'core/router.dart';
import 'features/venues/presentation/bloc/venues_bloc.dart';
import 'injection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
  Widget build(BuildContext context) => BlocProvider(
      create: (context) => sl<VenuesBloc>(),
      child: MaterialApp(
          title: appName,
          onGenerateRoute: CustomRouter.generateRoute,
          initialRoute: '/',
          theme: themeData));
}
