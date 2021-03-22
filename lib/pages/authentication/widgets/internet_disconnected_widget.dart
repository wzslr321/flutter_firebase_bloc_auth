import 'package:flutter/material.dart';

class InternetDisconnectedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CircularProgressIndicator(),
        Text('You do not have a internet connection'),
      ],
    );
  }
}
