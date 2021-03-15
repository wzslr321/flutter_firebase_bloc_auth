import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthState {}

class Authenticated extends AuthState {
  Authenticated(this.username);

  final String username;

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'Authenticated(userName: $username';
  }
}

class UnAuthenticated extends AuthState {}
