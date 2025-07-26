import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/token_response.dart';

import '../model/api_exception.dart';

class AuthService {
  Future<TokenResponse> login(String login, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (login != "qwe" || password != "qwe") {
      throw ApiException(ApiErrorCode.unknown, "Wrong login or password");
    }
    return TokenResponse(authToken: "token", refreshToken: "token");
  }

  Future<TokenResponse> refreshToken(String refreshToken) async {
    return TokenResponse(authToken: "token", refreshToken: "token");
  }
}