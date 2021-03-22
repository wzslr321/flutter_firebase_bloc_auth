import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthSnackBarContent extends StatelessWidget {
  AuthSnackBarContent({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(text),
        const Icon(Icons.error),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('text', text));
  }
}
