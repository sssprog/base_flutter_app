import 'package:base_flutter_app/data/model/api_error_code.dart';

class ApiException implements Exception {
  final ApiErrorCode code;
  final String description;

  ApiException(this.code, this.description);

  @override
  String toString() {
    return 'ApiException{code: $code, description: $description}';
  }
}