import 'package:coding_challenge/features/venues/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return pageRouteBuilder(SearchPage());

      default:
        return pageRouteBuilder(SearchPage());
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
