import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/network/api_error_mapper.dart';
import 'package:base_flutter_app/data/network/api_executor.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_executor_test.mocks.dart';
import 'network_requests.dart';

@GenerateMocks([ApiErrorMapper, RocketsRequest])
void main() {
  group("ApiExecutor tests", () {
    late MockApiErrorMapper errorMapper;
    late MockRocketsRequest request;
    late ApiExecutor apiExecutor;

    setUp(() {
      errorMapper = MockApiErrorMapper();
      request = MockRocketsRequest();
      apiExecutor = ApiExecutor(errorMapper);
    });

    test("3 requests on server error", () async {
      when(request()).thenThrow(Exception());
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.serverProblem, ""));

      await expectLater(apiExecutor.execute(request.call), throwsException);
      verify(request()).called(3);
    });

    test("1 request on unknown error", () async {
      when(request()).thenThrow(Exception());
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.unknown, ""));

      await expectLater(apiExecutor.execute(request.call), throwsException);
      verify(request()).called(1);
    });
  });
}
