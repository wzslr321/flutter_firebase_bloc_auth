part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  Authenticated(this.user);

  final User user;

  @override
  List<Object> get props => [user];

  @override
  String toString() {
    return 'Authenticated(user: $user';
  }
}

class UnAuthenticated extends AuthState {}
