import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static final Prefs _instance = Prefs._internal();
  SharedPreferences? _prefs;

  factory Prefs() {
    return _instance;
  }

  Prefs._internal();

  Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  // SharedPreferences get prefs {
  //   if (_prefs == null) {
  //     throw Exception('SharedPreferences not initialized. Call init() first.');
  //   }
  //   return _prefs!;
  // }

  // Example helper methods

  static void setBool(String key, bool value) {
    _instance._prefs!.setBool(key, value);
  }

  static getBool(String key) {
    return _instance._prefs!.getBool(key) ?? false;
  }

  static setString(String key, String value) async {
    await _instance._prefs!.setString(key, value);
  }

  static String getString(String key) {
    return _instance._prefs!.getString(key) ?? "";
  }

  // Future<bool> remove(String key) async {
  //   return await prefs.remove(key);
  // }
}
