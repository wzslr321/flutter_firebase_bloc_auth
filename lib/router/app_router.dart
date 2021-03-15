import 'package:flutter/material.dart';

import '../pages/authentication/authentication_screen.dart';
import '../pages/authentication/login/login_screen.dart';
import '../pages/authentication/register/register_screen.dart';
import '../pages/home/home_screen.dart';
import '../pages/page_not_found/page_not_found_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return MaterialPageRoute<HomeScreen>(
          builder: (ctx) => HomeScreen(),
        );
      case AuthenticationScreen.routeName:
        return MaterialPageRoute<AuthenticationScreen>(
          builder: (ctx) => AuthenticationScreen(),
        );
      case LoginScreen.routeName:
        return MaterialPageRoute<LoginScreen>(
          builder: (ctx) => LoginScreen(),
        );
      case RegisterScreen.routeName:
        return MaterialPageRoute<RegisterScreen>(
          builder: (ctx) => RegisterScreen(),
        );
      default:
        return MaterialPageRoute<PageNotFoundScreen>(
          builder: (ctx) => PageNotFoundScreen(),
        );
    }
  }
}
