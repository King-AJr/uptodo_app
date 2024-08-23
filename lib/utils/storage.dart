import 'package:shared_preferences/shared_preferences.dart';
import 'package:uptodo/utils/app_info.dart';

class LocalStorageService {
  final SharedPreferences prefs;

  LocalStorageService(this.prefs);

  Future<void> setString(String name, value) async {
    prefs.setString("$appName$name", value);
  }

  String? getString(String name) {
    return prefs.getString("$appName$name");
  }

  Future<void> setDouble(String name, value) async {
    prefs.setDouble("$appName$name", value);
  }

  Future<void> setInt(String name, value) async {
    prefs.setInt("$appName$name", value);
  }

  int? getInt(String name) {
    return prefs.getInt("$appName$name");
  }

  double? getDouble(String name) {
    return prefs.getDouble("$appName$name");
  }
}
