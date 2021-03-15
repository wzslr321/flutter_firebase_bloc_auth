import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthStarted extends AuthEvent {}

class LoggedIn extends AuthEvent {}

class LoggedOut extends AuthEvent {}
