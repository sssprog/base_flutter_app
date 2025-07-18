import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const _authTokenKey = "authTokenKey";

  final prefs = SharedPreferencesAsync();

  Future<String> getAuthToken() async => await prefs.getString(_authTokenKey) ?? "";

  Future<void> setAuthToken(String value) async {
    await prefs.setString(_authTokenKey, value);
  }
}