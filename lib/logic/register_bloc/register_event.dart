part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  RegisterEmailChanged({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends RegisterEvent {
  RegisterPasswordChanged({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class RegisterSubmitted extends RegisterEvent {
  RegisterSubmitted({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
