import 'package:bloc/bloc.dart';

import 'bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthState get initialState => Uninitialized();
}
