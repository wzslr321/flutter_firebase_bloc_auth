import 'package:flutter/material.dart';

import './widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
      body: LoginForm(),
    );
  }
}
