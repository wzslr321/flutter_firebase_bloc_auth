import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/auth_bloc/auth_bloc.dart';
import '../../logic/connection/internet_cubit.dart';
import '../home/home_screen.dart';
import 'login/login_screen.dart';
import 'register/register_screen.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.of(context).popAndPushNamed(HomeScreen.routeName);
        }
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.cyan,
          appBar: AppBar(title: const Text('Authentication')),
          body: Column(
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                  builder: (context, state) {
                if (state is InternetDisconnected) {
                  return Column(
                    children: const [
                      CircularProgressIndicator(),
                      Text('You do not have a internet connection'),
                    ],
                  );
                }
                return const Divider();
              }),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(LoginScreen.routeName);
                      },
                      child: const Text('Login')),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: const Text('Register')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
