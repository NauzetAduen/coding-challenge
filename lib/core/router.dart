import 'package:flutter/material.dart';

import '../features/venues/domain/entities/venue.dart';
import '../features/venues/presentation/pages/detailed_view.dart';
import '../features/venues/presentation/pages/main_view.dart';
import '../features/venues/presentation/pages/map_view.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return pageRouteBuilder(MainView());
      case '/detailed':
        if (args is Venue) {
          return pageRouteBuilder(DetailedVenueView(venue: args));
        }
        return pageRouteBuilder(MainView());

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
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, another, child) {
        animation =
            CurvedAnimation(parent: animation, curve: Curves.decelerate);
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      });
}
