import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/repository/Preferences.dart';

class AuthRepository {
  final Preferences _preferences;

  AuthRepository(this._preferences);

  Future<bool> isAuthorized() async {
    await Future.delayed(Duration(seconds: 1));
    return (await _preferences.getAuthToken()).isNotEmpty;
  }

  Future<void> login(String login, String password) async {
    if (login != "qwe" || password != "qwe") {
      throw ApiException("", "Wrong login or password");
    }
    await _preferences.setAuthToken("token");
  }
}
