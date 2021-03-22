import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/colors.dart';
import '../../logic/connection/internet_cubit.dart';
import 'login/login_screen.dart';
import 'register/register_screen.dart';
import 'widgets/internet_disconnected_widget.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryBlueColor,
        body: Column(
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
              if (state is InternetDisconnected) {
                return InternetDisconnectedWidget();
              }
              return const Divider();
            }),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: const Text('Sign up')),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(RegisterScreen.routeName);
                    },
                    child: const Text('Log in')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
