import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/connection/internet_cubit.dart';

class AuthenticationScreen extends StatelessWidget {
  static const routeName = 'authentication';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(title: const Text('Authentication')),
      body: Column(
        children: <Widget>[
          BlocBuilder<InternetCubit, InternetState>(builder: (ctx, state) {
            if (state is InternetConnected) {
              state.connectionType == ConnectionType.wifi
                  ? const Text('WiFi')
                  : state.connectionType == ConnectionType.mobile
                      ? const Text('Mobile')
                      : const Text('Disconnected');
            }
            return const Text('Something seems to be wrong ;--(');
          }),
        ],
      ),
    ));
  }
}
