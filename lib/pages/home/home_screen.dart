import 'package:flutter/material.dart';

import '../../constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBlueColor,
        appBar: AppBar(
          backgroundColor: primaryOrangeColor,
          title: const Text(';--)'),
        ),
        body: const Text('Home Screen'),
      ),
    );
  }
}
