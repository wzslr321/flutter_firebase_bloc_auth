import 'package:flutter/material.dart';

import '../pages/authentication/authentication_screen.dart';
import '../pages/home/home_screen.dart';
import '../pages/page_not_found/page_not_found_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute<AuthenticationScreen>(
          builder: (ctx) => AuthenticationScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute<HomeScreen>(
          builder: (ctx) => HomeScreen(),
        );
      default:
        return MaterialPageRoute<PageNotFoundScreen>(
          builder: (ctx) => PageNotFoundScreen(),
        );
    }
  }
}
