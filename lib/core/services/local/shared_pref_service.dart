import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final SharedPreferences _prefs;

  SharedPrefService(this._prefs);

  // Save
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _prefs.setDouble(key, value);
  }

  // Read
  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  // Remove
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // Clear all (optional)
  Future<void> clear() async {
    await _prefs.clear();
  }
}
