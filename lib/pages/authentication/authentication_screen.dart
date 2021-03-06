import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

import '../../providers/authentication_provider.dart';
import '../home/home_screen.dart';
import 'register/register_screen.dart';

class AuthenticationScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final firebaseUser = watch(authStateProvider);

    return firebaseUser.when(
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const Text('Error:'),
        data: (user) {
          if (user != null) {
            return HomeScreen();
          }
          return RegisterScreen();
        });
  }
}
