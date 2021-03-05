import 'package:flutter/material.dart';

class PageNotFoundScreen extends StatelessWidget {
  static const routeName = '/error-404';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(';=)'),
      ),
      body: const Text('Page Not Found'),
    );
  }
}
