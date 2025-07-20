import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:http/http.dart';

class ApiErrorMapper {
  ApiException fromResponse(Response response) {
    final description = response.body;
    if (response.statusCode == 401) {
      return ApiException(ApiErrorCode.unauthorized, description);
    }
    return ApiException(ApiErrorCode.unknown, description);
  }

  ApiException fromException(Object e) {
    return ApiException(ApiErrorCode.unknown, "");
  }
}