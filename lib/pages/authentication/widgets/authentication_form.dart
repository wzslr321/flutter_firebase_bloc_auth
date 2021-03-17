import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/login_bloc/login_bloc.dart';
import '../../home/home_screen.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({required this.buttonText});

  final String buttonText;

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('buttonText', buttonText));
  }
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  late LoginBloc _loginBloc;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(children: <Widget>[
              TextFormField(
                  controller: emailController,
                  decoration:
                      const InputDecoration(hintText: 'Enter the email'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill the field';
                    }
                    return null;
                  }),
              TextFormField(
                  controller: passwordController,
                  decoration:
                      const InputDecoration(hintText: 'Enter the password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please fill the field';
                    }
                  }),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Authorizing...')));
                    _loginBloc.add(LoginWithCredentialsPressed(
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
          'passwordController', passwordController));
  }
}
