import 'package:coding_challenge/features/venues/domain/entities/venue.dart';
import 'package:coding_challenge/features/venues/presentation/pages/main_view.dart';
import 'package:coding_challenge/features/venues/presentation/pages/map_view.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return pageRouteBuilder(MainView());
      //TODO DETAILED
      // case '/detailed':
      //   return pageRouteBuilder(DetailedView());

      case '/map':
        if (args is List<Venue>) {
          return pageRouteBuilder(MapView(list: args));
        }
        return pageRouteBuilder(MainView());
      default:
        return pageRouteBuilder(MainView());
    }
  }
}

PageRouteBuilder pageRouteBuilder(Widget destination) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, another) => destination,
      // transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, another, child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.decelerate);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}
