import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/login_bloc/login_bloc.dart';
import '../../../models/repositories/user_repository.dart';
import '../widgets/authentication_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({required this.userRepository});

  final UserRepository userRepository;

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Log in')),
        body: BlocProvider(
          create: (context) => LoginBloc(userRepository: userRepository),
          child: const AuthenticationForm(
            buttonText: 'Login',
            isLoginScreen: true,
          ),
        ));
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
        DiagnosticsProperty<UserRepository>('userRepository', userRepository));
  }
}
