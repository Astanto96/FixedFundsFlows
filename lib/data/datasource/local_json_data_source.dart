import 'dart:convert';
import 'dart:io';

import 'package:fixedfundsflows/data/models/backup_data_dto.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_json_data_source.g.dart';

@riverpod
LocalJsonDataSource localJsonDataSource(Ref ref) {
  return LocalJsonDataSource();
}

class LocalJsonDataSource {
  static const _fileName = 'fffbackup.json';

  Future<File> _getBackupFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<void> saveToFile(BackupDataDto data) async {
    final file = await _getBackupFile();
    final jsonString = jsonEncode(data.toJson());
    await file.writeAsString(jsonString);

    print('✅ Backup gespeichert unter: ${file.path}');
    print('📦 Existiert Datei? ${await file.exists()}');
  }

  Future<BackupDataDto> loadFromFile() async {
    final file = await _getBackupFile();
    final jsonString = await file.readAsString();
    final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
    return BackupDataDto.fromJson(jsonMap);
  }
}
