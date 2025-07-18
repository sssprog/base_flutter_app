import 'package:base_flutter_app/data/model/api_exception.dart';

import '../model/UiError.dart';

class ErrorMapper {
  UiError map(Object e) {
    if (e is! ApiException) return UiError("default error");
    return UiError(e.description);
  }
}
