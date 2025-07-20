import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/network/api_client.dart';
import 'package:base_flutter_app/data/network/api_error_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_client_test.mocks.dart';

@GenerateMocks([http.Client, ApiErrorMapper])
void main() {
  group("ApiClient tests", () {
    late MockClient client;
    late MockApiErrorMapper errorMapper;
    late ApiClient apiClient;

    setUp(() {
      client = MockClient();
      errorMapper = MockApiErrorMapper();
      apiClient = ApiClient(client, errorMapper);
    });

    test("successful get", () async {
      when(
        client.get(any, headers: anyNamed('headers')),
      ).thenAnswer(
        (realInvocation) async => http.Response('{}', 200),
      );

      expect(await apiClient.get(Uri.parse(""), Rocket.fromJson), isA<Rocket>());
      verify(client.get(any, headers: anyNamed('headers'))).called(1);
    });

    test("3 requests on server error", () async {
      when(client.get(any, headers: anyNamed('headers'))).thenThrow(Exception());
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.serverProblem, ""));

      await expectLater(apiClient.get(Uri.parse(""), Rocket.fromJson), throwsException);
      verify(client.get(any, headers: anyNamed('headers'))).called(3);
    });

    test("1 request on unknown error", () async {
      when(client.get(any, headers: anyNamed('headers'))).thenThrow(Exception());
      when(errorMapper.fromException(any)).thenReturn(ApiException(ApiErrorCode.unknown, ""));

      await expectLater(apiClient.get(Uri.parse(""), Rocket.fromJson), throwsException);
      verify(client.get(any, headers: anyNamed('headers'))).called(1);
    });
  });
}
