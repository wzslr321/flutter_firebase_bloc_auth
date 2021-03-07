import 'package:flutter/material.dart';
import 'package:twitter_copycat/pages/authentication/widgets/authentication_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sign in'),
        ),
        body: AuthenticationForm(
          buttonText: 'Sign in',
        ),
      ),
    );
  }
}
