class HttpException implements Exception {
  HttpException(this._error, this._stackTrace);

  final String _error;
  final StackTrace _stackTrace;

  @override
  String toString() {
    final _message = 'HttpException: $_error, found in: $_stackTrace';
    return _message;
  }
}
