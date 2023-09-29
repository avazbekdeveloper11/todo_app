import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const _localeLang = 'localeLang';

  static SharedPreferences? _preferences;

  static Future<PreferenceService> get create async {
    _preferences ??= await SharedPreferences.getInstance();
    return PreferenceService();
  }

  void setLocale(String? localeLang) async {
    await _preferences?.setString(_localeLang, localeLang ?? 'uz');
  }

  String get getLocale {
    final localeLang = _preferences?.getString(_localeLang);

    return localeLang ?? 'uz';
  }

  void signOut() async => await _preferences?.clear();
}
