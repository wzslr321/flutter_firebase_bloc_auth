import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSubscription =
        connectivity.onConnectivityChanged.listen((result) {
      switch (result) {
        case ConnectivityResult.wifi:
          emitInternetConnected(ConnectionType.wifi);
          break;
        case ConnectivityResult.mobile:
          emitInternetConnected(ConnectionType.mobile);
          break;
        default:
          emitInternetDisconnected();
      }
    });
  }

  final Connectivity connectivity;
  StreamSubscription? connectivityStreamSubscription;

  void emitInternetConnected(ConnectionType _connectionType) =>
      emit(InternetConnected(connectionType: _connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSubscription?.cancel();
    return super.close();
  }
}
