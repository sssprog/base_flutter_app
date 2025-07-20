abstract interface class TokenRefresher {
  Future<String> get authToken;
  Future<void> refreshToken(String failedAuthToken);
}