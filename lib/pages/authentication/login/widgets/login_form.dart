import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twitter_copycat/pages/authentication/widgets/auth_snack_bar_content.dart';

import '../../../../logic/auth_bloc/auth_bloc.dart';
import '../../../../logic/login_bloc/login_bloc.dart';
import '../../../home/home_screen.dart';
import '../../widgets/auth_form_field.dart';

class LoginForm extends StatefulWidget {
  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool get areControllersNotEmpty =>
      emailController.text.isNotEmpty && passwordController.text.isNotEmpty;

  bool canBeSubmitted(LoginState state) {
    return state.isFormValid && areControllersNotEmpty && !state.isSubmitting;
  }

  late LoginBloc _loginBloc;

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: passwordController.text));
  }

  String? _loginEmailValidator(LoginState state) {
    return !state.isEmailValid ? 'Invalid Email' : null;
  }

  String? _loginPasswordValidator(LoginState state) {
    return !state.isPasswordValid ? 'Invalid Password' : null;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
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
            ..showSnackBar(
              SnackBar(
                content: AuthSnackBarContent(
                  text: 'Failed to login',
                ),
              ),
            );
        }

        if (state.isSubmitting) {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: AuthSnackBarContent(text: 'Logging in...'),
              ),
            );
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
              AuthFormField(
                  controller: emailController,
                  validator: _loginEmailValidator(state)),
              AuthFormField(
                  controller: passwordController,
                  validator: _loginPasswordValidator(state)),
              ElevatedButton(
                onPressed: () {
                  if (canBeSubmitted(state)) {
                    _loginBloc.add(LoginWithCredentialsPressed(
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
