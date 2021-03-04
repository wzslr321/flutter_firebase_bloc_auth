import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  const PageNotFoundScreen({Key? key}) : super(key: key);

  static const routeName = '/error-404';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text("Page Not Found"),
    );
  }
}
