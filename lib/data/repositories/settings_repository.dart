import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_repository.g.dart';

@riverpod
SettingsRepository settingsRepository(Ref ref) {
  return SettingsRepository();
}

class SettingsRepository {
  static const _initializedKey = 'initialized';

  Future<bool> isAppInitialized() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_initializedKey) ?? false;
  }

  Future<void> setAppInitialized(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_initializedKey, value);
  }
}
