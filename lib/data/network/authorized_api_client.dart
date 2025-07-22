import 'dart:io';

import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/network/api_client.dart';
import 'package:base_flutter_app/data/network/token_refresher.dart';
import 'package:http/http.dart';

class AuthorizedApiClient extends ApiClient {
  final TokenRefresher _tokenRefresher;

  AuthorizedApiClient(super.client, super.errorMapper, this._tokenRefresher);

  /// This is for some real api. Current rockets api doesn't work when sending this header
  // @override
  // Future<Map<String, String>> get baseHeaders async => {
  //   HttpHeaders.authorizationHeader: await _tokenRefresher.authToken,
  // };

  @override
  Future<T> makeRequest<T>(
    Future<Response> Function() request,
    T Function(String) fromJson,
  ) async {
    var authToken = await _tokenRefresher.authToken;
    var attempt = 1;
    while (true) {
      try {
        return await super.makeRequest(request, fromJson);
      } on ApiException catch (e) {
        if (e.code == ApiErrorCode.unauthorized && attempt <= 3) {
          await _tokenRefresher.refreshToken(authToken);
          authToken = await _tokenRefresher.authToken;
          attempt++;
        } else {
          rethrow;
        }
      }
    }
  }
}
