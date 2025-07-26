abstract interface class TokenRefresher {
  Future<void> refreshToken(String failedAuthToken);
}