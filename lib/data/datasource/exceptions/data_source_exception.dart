class DataSourceException implements Exception {
  final String message;
  final StackTrace? stackTrace;

  DataSourceException(this.message, {this.stackTrace});

  @override
  String toString() => message;
}
