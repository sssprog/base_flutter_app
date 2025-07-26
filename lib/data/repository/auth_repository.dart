import 'package:base_flutter_app/data/network/auth_service.dart';
import 'package:base_flutter_app/data/network/auth_token_provider.dart';
import 'package:base_flutter_app/data/network/token_refresher.dart';
import 'package:base_flutter_app/data/repository/preferences.dart';

class AuthRepository implements TokenRefresher, AuthTokenProvider {
  final AuthService _api;
  final Preferences _preferences;
  Future<void>? _refreshTokenRequest;

  AuthRepository(this._api, this._preferences);

  Future<bool> isAuthorized() async {
    return (await _preferences.getAuthToken()).isNotEmpty;
  }

  Future<void> login(String login, String password) async {
    final response = await _api.login(login, password);
    await _preferences.setAuthToken(response.authToken);
    await _preferences.setRefreshToken(response.refreshToken);
  }

  @override
  Future<void> refreshToken(String failedAuthToken) async {
    if (failedAuthToken != await _preferences.getAuthToken()) {
      return;
    }
    if (_refreshTokenRequest case final request?) {
      return request;
    }
    final request = _refreshToken();
    _refreshTokenRequest = request;
    return request;
  }

  Future<void> _refreshToken() async {
    final response = await _api.refreshToken(await _preferences.getRefreshToken());
    await _preferences.setAuthToken(response.authToken);
    await _preferences.setRefreshToken(response.refreshToken);
  }

  @override
  Future<String> get authToken => _preferences.getAuthToken();

}
