import 'package:base_flutter_app/data/model/token_response.dart';
import 'package:base_flutter_app/data/network/auth_service.dart';
import 'package:base_flutter_app/data/repository/auth_repository.dart';
import 'package:base_flutter_app/data/repository/preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

const _authToken = "auth_token";
const _authToken2 = "auth_token2";
const _refreshToken = "refresh_token";
const _refreshToken2 = "refresh_token2";

@GenerateMocks([AuthService, Preferences])
void main() {
  group("AuthRepository tests", () {
    late MockAuthService authService;
    late MockPreferences preferences;
    late AuthRepository authRepository;

    setUp(() {
      authService = MockAuthService();
      preferences = MockPreferences();
      authRepository = AuthRepository(authService, preferences);

      when(preferences.getAuthToken()).thenAnswer((_) async => _authToken);
      when(preferences.getRefreshToken()).thenAnswer((_) async => _refreshToken);
    });

    test("set new tokens", () async {
      when(
        authService.refreshToken(_refreshToken),
      ).thenAnswer(
        (_) async => TokenResponse(authToken: _authToken2, refreshToken: _refreshToken2),
      );

      await authRepository.refreshToken(_authToken);
      verify(authService.refreshToken(any)).called(1);
      verify(preferences.setAuthToken(_authToken2)).called(1);
      verify(preferences.setRefreshToken(_refreshToken2)).called(1);
    });

    test("new request to refresh when failed token is not current token", () async {
      when(
        authService.refreshToken(_refreshToken),
      ).thenAnswer(
        (_) async => TokenResponse(authToken: _authToken2, refreshToken: _refreshToken2),
      );

      await authRepository.refreshToken(_authToken2);
      verifyNever(authService.refreshToken(any));
    });

    test("single refresh request for multiple requests from clients", () async {
      when(
        authService.refreshToken(_refreshToken),
      ).thenAnswer(
        (_) async {
          await Future.delayed(Duration(milliseconds: 200));
          return TokenResponse(authToken: _authToken2, refreshToken: _refreshToken2);
        },
      );

      await Future.wait([
        authRepository.refreshToken(_authToken),
        authRepository.refreshToken(_authToken),
      ]);

      verify(authService.refreshToken(any)).called(1);
      verify(preferences.setAuthToken(_authToken2)).called(1);
      verify(preferences.setRefreshToken(_refreshToken2)).called(1);
    });
  });
}
