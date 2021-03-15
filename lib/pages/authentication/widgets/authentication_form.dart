import 'package:flutter/material.dart';

class AuthenticationForm extends StatefulWidget {
  const AuthenticationForm({required this.buttonText});

  final String buttonText;

  @override
  _AuthenticationFormState createState() => _AuthenticationFormState();
}

class _AuthenticationFormState extends State<AuthenticationForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(children: <Widget>[
        TextFormField(
            controller: emailController,
            decoration: const InputDecoration(hintText: 'Enter the email'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill the field';
              }
              return null;
            }),
        TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(hintText: 'Enter the password'),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please fill the field';
              }
            }),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('Authorizing...')));
              // context.read<AuthenticationService>(authServicesProvider).signIn(
              //   email: emailController.text,
              //  password: passwordController.text,
              // );
            }
          },
          child: Text(this.widget.buttonText),
        )
      ]),
    );
  }
}
