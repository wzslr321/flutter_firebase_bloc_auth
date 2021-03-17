import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(Uninitialized());

  final UserRepository _userRepository;

  UserRepository get userRepository => _userRepository;

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthStarted) {
      yield* _mapAuthStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapAuthLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapAuthLoggedOutToState();
    }
  }

  Stream<AuthState> _mapAuthLoggedOutToState() async* {
    yield UnAuthenticated();
    await _userRepository.signOut();
  }

  Stream<AuthState> _mapAuthLoggedInToState() async* {
    final user = await _userRepository.getUser();
    if (user != null) {
      yield Authenticated(user);
    }
  }

  Stream<AuthState> _mapAuthStartedToState() async* {
    final isSignedIn = _userRepository.isSignedIn();
    if (isSignedIn) {
      final user = await _userRepository.getUser();
      yield Authenticated(user!);
    } else {
      yield UnAuthenticated();
    }
  }
}
