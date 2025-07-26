import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/network/api_error_mapper.dart';
import 'package:base_flutter_app/data/network/auth_token_provider.dart';
import 'package:base_flutter_app/data/network/authorized_api_executor.dart';
import 'package:base_flutter_app/data/network/token_refresher.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authorized_api_executor_test.mocks.dart';
import 'network_requests.dart';

const _authToken = "token";

@GenerateMocks([ApiErrorMapper, TokenRefresher, AuthTokenProvider, RocketsRequest])
void main() {
  group("AuthorizedApiExecutor tests", () {
    late MockRocketsRequest request;
    late MockApiErrorMapper errorMapper;
    late MockTokenRefresher tokenRefresher;
    late MockAuthTokenProvider tokenProvider;
    late AuthorizedApiExecutor apiExecutor;

    setUp(() {
      request = MockRocketsRequest();
      errorMapper = MockApiErrorMapper();
      tokenRefresher = MockTokenRefresher();
      tokenProvider = MockAuthTokenProvider();
      apiExecutor = AuthorizedApiExecutor(errorMapper, tokenProvider, tokenRefresher);
    });

    test("successful get, no token refresh request", () async {
      when(request()).thenAnswer((_) async => []);
      when(tokenProvider.authToken).thenAnswer((_) async => _authToken);

      await apiExecutor.execute(request.call);
      verifyNever(tokenRefresher.refreshToken(any));
    });

    test("1 token refresh on auth error", () async {
      var attempt = 0;
      var currentToken = _authToken;
      when(request()).thenAnswer(
        (invocation) {
          attempt++;
          return attempt == 1 ? Future.error(Exception()) : Future.value([]);
        },
      );
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.unauthorized, ""));
      when(tokenProvider.authToken).thenAnswer((_) async => currentToken);
      when(tokenRefresher.refreshToken(_authToken)).thenAnswer((_) async {
        currentToken = "${_authToken}qwe";
      });

      await apiExecutor.execute(request.call);
      verify(request()).called(2);
      verify(tokenRefresher.refreshToken(_authToken)).called(1);
      verifyNever(tokenRefresher.refreshToken(any));
    });

    test("3 token requests on auth error", () async {
      when(request()).thenThrow(Exception());
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.unauthorized, ""));
      when(tokenProvider.authToken).thenAnswer((_) async => _authToken);
      when(tokenRefresher.refreshToken(_authToken)).thenAnswer((_) async {});

      await expectLater(apiExecutor.execute(request.call), throwsException);
      verify(request()).called(4);
      verify(tokenRefresher.refreshToken(_authToken)).called(3);
    });
  });
}
