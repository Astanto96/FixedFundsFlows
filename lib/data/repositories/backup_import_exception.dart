class BackupImportException implements Exception {
  final String message;
  BackupImportException(this.message);
  @override
  String toString() => message;
}
