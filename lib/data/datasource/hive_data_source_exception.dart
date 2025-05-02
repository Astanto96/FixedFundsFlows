class HiveDataSourceException implements Exception {
  final String message;
  HiveDataSourceException(this.message);

  @override
  String toString() => 'HiveDataSourceException: $message';
}
