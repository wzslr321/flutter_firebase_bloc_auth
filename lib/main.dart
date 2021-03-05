import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'constants.dart';
import 'pages/authentication/authentication_screen.dart';
import 'pages/authentication/login/login_screen.dart';
import 'pages/page_not_found/page_not_found_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TwitterCopycat',
      theme: ThemeData(
        primarySwatch: primaryBlueColor,
      ),
      home: AuthenticationScreen(),
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
      onUnknownRoute: (_) {
        return MaterialPageRoute<PageNotFoundScreen>(
            builder: (ctx) => PageNotFoundScreen());
      },
    );
  }
}
