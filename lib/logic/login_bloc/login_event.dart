part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEmailChange extends LoginEvent {
  LoginEmailChange({
    required this.email,
  });

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged({
    required this.password,
  });

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginWIthCredentialsPressed extends LoginEvent {
  LoginWIthCredentialsPressed({
    required this.email,
    required this.password,
  });

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
