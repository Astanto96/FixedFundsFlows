import 'dart:convert';
import 'dart:io';
import 'package:fixedfundsflows/data/datasource/exceptions/json_exceptions.dart';
import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_json_data_source.g.dart';

@riverpod
LocalJsonDataSource localJsonDataSource(Ref ref) {
  return LocalJsonDataSource();
}

class LocalJsonDataSource {
  Future<File> saveBackupToFile(BackupDataDto dto, String filePath) async {
    try {
      final jsonString = jsonEncode(dto.toJson());
      final file = File(filePath);
      await file.writeAsString(jsonString);
      return file;
    } catch (e, st) {
      throw JsonFileWriteException("Failed to write backup to file: $e",
          stackTrace: st);
    }
  }

  Future<BackupDataDto> tryLoadBackup(File file) async {
    try {
      final jsonString = await file.readAsString();
      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      await _validateBackupJson(jsonMap);
      return BackupDataDto.fromJson(jsonMap);
    } on JsonException {
      rethrow; // bereits spezifiziert
    } on FormatException catch (e, st) {
      throw JsonParseException("Invalid JSON format: $e", stackTrace: st);
    } catch (e, st) {
      throw JsonFileReadException("Failed to read or parse backup file: $e",
          stackTrace: st);
    }
  }

  Future<void> _validateBackupJson(Map<String, dynamic> json) async {
    if (!json.containsKey('contracts') || !json.containsKey('categories')) {
      throw JsonValidationException(
        'No contracts or categories found.',
      );
    }

    final contracts = json['contracts'];
    final categories = json['categories'];

    if (contracts is! List || categories is! List) {
      throw JsonValidationException(
        'Invalid data format. Contracts and categories should be lists.',
      );
    }

    if (contracts.isEmpty || categories.isEmpty) {
      throw JsonValidationException(
        'Contracts or categories are empty.',
      );
    }

    const requiredContractKeys = [
      'description',
      'billingPeriod',
      'categoryId',
      'amount'
    ];

    //check contracts
    for (final entry in contracts) {
      if (entry is! Map<String, dynamic>) {
        throw JsonValidationException(
          'Invalid contract format.',
        );
      }
      //check if every field is present
      if (!requiredContractKeys.every(entry.containsKey)) {
        throw JsonValidationException(
          'Missing required contract fields.',
        );
      }
      //check every field type
      if (entry['description'] == null ||
          entry['description'] is! String ||
          entry['description'].toString().trim().isEmpty) {
        throw JsonValidationException(
            'Invalid contract: description must be a non-empty string.');
      }

      const validBillingPeriods = ['monthly', 'quarterly', 'yearly'];
      if (!validBillingPeriods.contains(entry['billingPeriod'])) {
        throw JsonValidationException(
          'Invalid contract: billingPeriod must be one of monthly, quarterly, yearly.',
        );
      }

      if (entry['categoryId'] == null || entry['categoryId'] is! int) {
        throw JsonValidationException(
            'Invalid contract: categoryId must be an integer.');
      }
      if (entry['amount'] == null || entry['amount'] is! int) {
        throw JsonValidationException(
            'Invalid contract: amount must be an integer.');
      }
    }
    //check categories
    for (final entry in categories) {
      if (entry is! Map<String, dynamic>) {
        throw JsonValidationException(
          'Invalid category format.',
        );
      }
      //check for field
      if (!entry.containsKey('description')) {
        throw JsonValidationException(
          'Missing required category fields.',
        );
      }
      //check field type
      if (entry['description'] == null ||
          entry['description'] is! String ||
          entry['description'].toString().trim().isEmpty) {
        throw JsonValidationException(
          'Invalid category: description must be a non-empty string.',
        );
      }
    }
  }
}
