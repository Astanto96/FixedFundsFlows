class JsonBackupException implements Exception {
  final String message;
  JsonBackupException(this.message);

  @override
  String toString() => 'JsonBackupException: $message';
}
