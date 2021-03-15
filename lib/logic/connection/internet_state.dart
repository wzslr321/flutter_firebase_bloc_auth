part of 'internet_cubit.dart';

@immutable
abstract class InternetState {}

class InternetLoading extends InternetState {}

class InternetConnected extends InternetState {
  InternetConnected({required this.connectionType});

  final ConnectionType connectionType;
}

class InternetDisconnected extends InternetState {}
