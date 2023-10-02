import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DBService {
  static const _dbName = 'localDB';
  static const _themeMode = 'theme_mode';

  static Box? _box;

  DBService._();

  static Future<DBService> get create async {
    _box ??= await Hive.openBox(_dbName);
    return DBService._();
  }

  /// Name
  Future<void> setThemeMode(String? mode) async {
    await _box?.put(_themeMode, mode);
  }

  String? get getThemeMode {
    String? getName = _box?.get(_themeMode);
    return getName;
  }

  Future<void> signOut() async => await _box?.clear();
}
