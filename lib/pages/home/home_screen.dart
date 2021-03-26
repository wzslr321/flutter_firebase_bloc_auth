import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/colors.dart';
import '../../logic/auth_bloc/auth_bloc.dart';
import '../authentication/authentication_screen.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        //backgroundColor: primaryBlueColor,
        appBar: AppBar(
          backgroundColor: primaryOrangeColor,
          title: const Text('Home Screen '),
        ),
        body: Column(
          children: <Widget>[
            BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is Authenticated) {
                return Text('Hello ${state.user.email}');
              } else {
                return const Text('Hmm...');
              }
            }),
            ElevatedButton(
                onPressed: () {
                  BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AuthenticationScreen.routeName, (route) => false);
                },
                child: const Text('Log out')),
          ],
        ),
      ),
    );
  }
}
