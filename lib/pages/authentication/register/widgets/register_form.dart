import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../logic/auth_bloc/auth_bloc.dart';
import '../../../../logic/register_bloc/register_bloc.dart';
import '../../../home/home_screen.dart';
import '../../widgets/auth_snack_bar.dart';

class RegisterForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get areControllersNotEmpty =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  bool canBeSubmitted(RegisterState state) {
    return state.isFormValid && areControllersNotEmpty && !state.isSubmitting;
  }

  late RegisterBloc _registerBloc;

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: passwordController.text));
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    emailController.addListener(_onEmailChange);
    passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: AuthSnackBarContent(text: 'Failed to authorize'),
            ));
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: AuthSnackBarContent(text: 'Authorizing...'),
            ));
        }

        if (state.isSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
      },
      child: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                  controller: emailController,
                  autocorrect: false,
                  autovalidateMode: AutovalidateMode.always,
                  decoration:
                      const InputDecoration(hintText: 'Enter the email'),
                  validator: (_) {
                    return !state.isEmailValid ? 'Invalid Email' : null;
                  }),
              TextFormField(
                  autovalidateMode: AutovalidateMode.always,
                  autocorrect: false,
                  controller: passwordController,
                  decoration:
                      const InputDecoration(hintText: 'Enter the password'),
                  validator: (_) {
                    return !state.isPasswordValid ? 'Invalid Password' : null;
                  }),
              ElevatedButton(
                onPressed: () {
                  if (canBeSubmitted(state)) {
                    _registerBloc.add(RegisterSubmitted(
                        email: emailController.text,
                        password: passwordController.text));
                  }
                },
                child: const Text('Login'),
              )
            ]),
          );
        },
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty<TextEditingController>(
          'emailController', emailController))
      ..add(DiagnosticsProperty<TextEditingController>(
          'passwordController', passwordController))
      ..add(DiagnosticsProperty<bool>(
          'areControllersNotEmpty', areControllersNotEmpty));
  }
}
