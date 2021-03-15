import 'package:firebase_auth/firebase_auth.dart';

class CustomFirebaseException implements Exception {
  CustomFirebaseException(this._error, this._stackTrace);

  final FirebaseException _error;
  final StackTrace _stackTrace;

  @override
  String toString() {
    final _message = 'FirebaseException: $_error, found in: $_stackTrace';
    return _message;
  }
}
