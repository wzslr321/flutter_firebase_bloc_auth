import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/auth_bloc/auth_bloc.dart';
import '../../../logic/login_bloc/login_bloc.dart';
import '../../../logic/register_bloc/register_bloc.dart';
import '../../home/home_screen.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm(
      {required this.buttonText, required this.isLoginScreen});

  final String buttonText;
  final bool isLoginScreen;

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(StringProperty('buttonText', buttonText))
      ..add(DiagnosticsProperty<bool>('isLoginScreen', isLoginScreen));
  }
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get areControllersNotEmpty =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  bool canBeSubmitted(LoginState state) {
    return state.isFormValid && areControllersNotEmpty && !state.isSubmitting;
  }

  late LoginBloc _loginBloc;
  late RegisterBloc _registerBloc;

  void _onEmailChange() {
    widget.isLoginScreen
        ? _loginBloc.add(LoginEmailChange(email: emailController.text))
        : _registerBloc.add(RegisterEmailChanged(email: emailController.text));
  }

  void _onPasswordChange() {
    widget.isLoginScreen
        ? _loginBloc
            .add(LoginPasswordChanged(password: passwordController.text))
        : _registerBloc
            .add(RegisterPasswordChanged(password: passwordController.text));
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Failed to login'),
                  Icon(Icons.error),
                ],
              ),
            ));
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text('Authorizing...'),
                  CircularProgressIndicator(),
                ],
              ),
            ));
        }

        if (state.isSuccess) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
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
                    widget.isLoginScreen
                        ? _loginBloc.add(LoginWithCredentialsPressed(
                            email: emailController.text,
                            password: passwordController.text))
                        : _registerBloc.add(RegisterSubmitted(
                            email: emailController.text,
                            password: passwordController.text));
                  }
                },
                child: Text(widget.buttonText),
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
