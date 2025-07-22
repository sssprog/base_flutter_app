class ApiUrlProvider {
  final String baseUrl;

  ApiUrlProvider(this.baseUrl);

  Uri urlForPath(String path) {
    return Uri.parse(baseUrl + path);
  }
}