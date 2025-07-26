abstract interface class AuthTokenProvider {
  Future<String> get authToken;
}