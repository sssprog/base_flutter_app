import 'dart:io';

import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/network/api_error_mapper.dart';
import 'package:base_flutter_app/data/network/authorized_api_client.dart';
import 'package:base_flutter_app/data/network/token_refresher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authorized_api_client_test.mocks.dart';

const _authToken = "token";

@GenerateMocks([http.Client, ApiErrorMapper, TokenRefresher])
void main() {
  group("AuthorizedApiClient tests", () {
    late MockClient client;
    late MockApiErrorMapper errorMapper;
    late MockTokenRefresher tokenRefresher;
    late AuthorizedApiClient apiClient;

    setUp(() {
      client = MockClient();
      errorMapper = MockApiErrorMapper();
      tokenRefresher = MockTokenRefresher();
      apiClient = AuthorizedApiClient(client, errorMapper, tokenRefresher);
    });

    test("successful get, no token refresh request", () async {
      when(
        client.get(any, headers: anyNamed('headers')),
      ).thenAnswer(
        (_) async => http.Response('{}', 200),
      );
      when(tokenRefresher.authToken).thenAnswer((_) async => _authToken);

      await apiClient.get(Uri.parse(""), Rocket.fromJson);
      verifyNever(tokenRefresher.refreshToken(any));
    });

    test("1 token refresh on auth error", () async {
      var currentToken = _authToken;
      when(
        client.get(any, headers: anyNamed('headers')),
      ).thenAnswer(
        (invocation) {
          final authHeader =
              invocation.namedArguments[Symbol('headers')][HttpHeaders.authorizationHeader];
          debugPrint("authHeader $authHeader");
          return authHeader == _authToken
              ? Future.error(Exception())
              : Future.value(http.Response('{}', 200));
        },
      );
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.unauthorized, ""));
      when(tokenRefresher.authToken).thenAnswer((_) async => currentToken);
      when(tokenRefresher.refreshToken(_authToken)).thenAnswer((_) async {
        currentToken = "${_authToken}qwe";
      });

      expect(await apiClient.get(Uri.parse(""), Rocket.fromJson), isA<Rocket>());
      verify(client.get(any, headers: anyNamed('headers'))).called(2);
      verify(tokenRefresher.refreshToken(_authToken)).called(1);
      verifyNever(tokenRefresher.refreshToken(any));
    });

    test("3 token requests on auth error", () async {
      when(
        client.get(any, headers: anyNamed('headers')),
      ).thenThrow(Exception());
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.unauthorized, ""));
      when(tokenRefresher.authToken).thenAnswer((_) async => _authToken);
      when(tokenRefresher.refreshToken(_authToken)).thenAnswer((_) async {});

      await expectLater(apiClient.get(Uri.parse(""), Rocket.fromJson), throwsException);
      verify(client.get(any, headers: anyNamed('headers'))).called(4);
      verify(tokenRefresher.refreshToken(_authToken)).called(3);
    });
  });
}
