import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants.dart';
import 'pages/home/home_screen.dart';
import 'pages/login/login_screen.dart';
import 'pages/page_not_found/page_not_found_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TwitterCopycat',
      theme: ThemeData(
        primarySwatch: darkBlueColor,
      ),
      home: const HomeScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => const LoginScreen(),
      },
      onUnknownRoute: (_) {
        return MaterialPageRoute<PageNotFoundScreen>(
            builder: (ctx) => const PageNotFoundScreen());
      },
    );
  }
}
