import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/network/api_executor.dart';
import 'package:base_flutter_app/data/network/token_refresher.dart';

import 'auth_token_provider.dart';

class AuthorizedApiExecutor extends ApiExecutor {
  final AuthTokenProvider _tokenProvider;
  final TokenRefresher _tokenRefresher;

  AuthorizedApiExecutor(super.errorMapper, this._tokenProvider, this._tokenRefresher);

  /// This is for some real api. Current rockets api doesn't work when sending this header
  // @override
  // Future<Map<String, String>> get baseHeaders async => {
  //   HttpHeaders.authorizationHeader: await _tokenRefresher.authToken,
  // };

  @override
  Future<T> execute<T>(Future<T> Function() request) async {
    var authToken = await _tokenProvider.authToken;
    var attempt = 1;
    while (true) {
      try {
        return await super.execute(request);
      } on ApiException catch (e) {
        if (e.code == ApiErrorCode.unauthorized && attempt <= 3) {
          await _tokenRefresher.refreshToken(authToken);
          authToken = await _tokenProvider.authToken;
          attempt++;
        } else {
          rethrow;
        }
      }
    }
  }
}
