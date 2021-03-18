import 'package:flutter/material.dart';

import '../widgets/authentication_form.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign in'),
        ),
        body: const AuthenticationForm(
          buttonText: 'Sign in',
          isLoginScreen: false,
        ),
      ),
    );
  }
}
