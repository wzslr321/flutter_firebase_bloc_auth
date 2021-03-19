import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../models/repositories/user_repository.dart';
import '../widgets/authentication_form.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({required this.userRepository});

  final UserRepository userRepository;

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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<UserRepository>('userRepository', userRepository));
  }
}
