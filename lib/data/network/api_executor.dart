import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/network/api_error_mapper.dart';

const int maxRetryCount = 3;

class ApiExecutor {
  final ApiErrorMapper _errorMapper;

  ApiExecutor(this._errorMapper);

  Future<T> execute<T>(Future<T> Function() request) async {
    var attempt = 1;
    while (true) {
      try {
        return await _executeSingle(request);
      } on ApiException catch (e) {
        if (attempt < maxRetryCount &&
            (e.code == ApiErrorCode.networkProblem || e.code == ApiErrorCode.serverProblem)) {
          attempt++;
        } else {
          rethrow;
        }
      }
    }
  }

  Future<T> _executeSingle<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch(e) {
      throw _errorMapper.fromException(e);
    }
  }
}
