import 'package:flutter/material.dart';

import './widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RegisterForm(),
      ),
    );
  }
}
