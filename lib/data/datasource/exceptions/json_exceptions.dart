import 'package:fixedfundsflows/data/datasource/exceptions/data_source_exception.dart';

// JSON-BASE
class JsonException extends DataSourceException {
  JsonException(super.message, {super.stackTrace});
}

// SPECIFICS
class JsonParseException extends JsonException {
  JsonParseException(super.message, {super.stackTrace});
}

class JsonValidationException extends JsonException {
  JsonValidationException(super.message, {super.stackTrace});
}

class JsonFileReadException extends JsonException {
  JsonFileReadException(super.message, {super.stackTrace});
}

class JsonFileWriteException extends JsonException {
  JsonFileWriteException(super.message, {super.stackTrace});
}
