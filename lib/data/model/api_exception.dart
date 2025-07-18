class ApiException implements Exception {
  final String code;
  final String description;

  ApiException(this.code, this.description);

  @override
  String toString() {
    return 'ApiException{code: $code, description: $description}';
  }
}