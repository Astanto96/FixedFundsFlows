import 'dart:convert';
import 'dart:io';
import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_json_data_source.g.dart';

@riverpod
LocalJsonDataSource localJsonDataSource(Ref ref) {
  return LocalJsonDataSource();
}

class LocalJsonDataSource {
  Future<BackupDataDto> loadFromCustomFile(File file) async {
    final jsonString = await file.readAsString();
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return BackupDataDto.fromJson(jsonMap);
  }

  Future<File> saveBackupToFile(BackupDataDto dto, String filePath) async {
    final jsonString = jsonEncode(dto.toJson());
    final file = File(filePath);
    await file.writeAsString(jsonString);
    return file;
  }
}
