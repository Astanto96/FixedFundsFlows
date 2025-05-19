import 'package:fixedfundsflows/data/datasource/exceptions/data_source_exception.dart';

// HIVE-BASE
class HiveException extends DataSourceException {
  HiveException(super.message, {super.stackTrace});
}

// SPECIFICS
class HiveSaveException extends HiveException {
  HiveSaveException(super.message, {super.stackTrace});
}

class HiveReadException extends HiveException {
  HiveReadException(super.message, {super.stackTrace});
}

class HiveDeleteException extends HiveException {
  HiveDeleteException(super.message, {super.stackTrace});
}

class HiveUpdateException extends HiveException {
  HiveUpdateException(super.message, {super.stackTrace});
}

class HiveMissingReferenceException extends HiveException {
  HiveMissingReferenceException(super.message, {super.stackTrace});
}
