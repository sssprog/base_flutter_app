class ApiUrlProvider {
  final String baseUrl;

  ApiUrlProvider(this.baseUrl);

  String urlForPath(String path) {
    return baseUrl + path;
  }
}