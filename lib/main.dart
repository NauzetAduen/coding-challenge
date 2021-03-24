import 'package:coding_challenge/features/venues/presentation/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app_theme.dart';
import 'core/router.dart';
import 'features/venues/presentation/bloc/details_bloc.dart';
import 'features/venues/presentation/bloc/favorite_bloc.dart';
import 'features/venues/presentation/bloc/venues_bloc.dart';
import 'injection.dart';

// ignore: avoid_void_async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(CodingChallengeApp());
}

const appName = "Coding Challenge";

class CodingChallengeApp extends StatefulWidget {
  @override
  _CodingChallengeAppState createState() => _CodingChallengeAppState();
}

class _CodingChallengeAppState extends State<CodingChallengeApp> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
          providers: [
            BlocProvider<VenuesBloc>(
              create: (context) => sl<VenuesBloc>(),
            ),
            BlocProvider<DetailsBloc>(
              create: (context) => sl<DetailsBloc>(),
            ),
            //TODO ..add()
            BlocProvider<FavoriteBloc>(
                create: (context) => sl<FavoriteBloc>()
                  ..add(const ToogleFavoriteStatusEvent(venueID: ""))),
          ],
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: appName,
              onGenerateRoute: CustomRouter.generateRoute,
              initialRoute: '/',
              theme: themeData));
}
