import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthFormField extends StatelessWidget {
  AuthFormField({required this.controller, required this.validator});

  final TextEditingController controller;
  final String? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        autocorrect: false,
        autovalidateMode: AutovalidateMode.always,
        decoration: const InputDecoration(hintText: 'Enter the email'),
        validator: (_) {
          return validator;
        });
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(
          DiagnosticsProperty<TextEditingController>('controller', controller))
      ..add(StringProperty('validator', validator));
  }
}
