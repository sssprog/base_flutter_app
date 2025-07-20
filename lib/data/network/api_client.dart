import 'dart:convert';
import 'dart:io';

import 'package:base_flutter_app/data/model/api_error_code.dart';
import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/data/network/api_error_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

const int maxRetryCount = 3;

class ApiClient {
  final Client _client;
  final ApiErrorMapper _errorMapper;

  ApiClient(this._client, this._errorMapper);

  Future<T> get<T>(
    Uri uri,
    T Function(Map<String, Object?> json) fromJson, {
    Map<String, String> headers = const {},
  }) async {
    return await makeRequest(
      () async => _client.get(uri, headers: _combineHeaders(await baseHeaders, headers)),
      fromJson,
    );
  }

  @protected
  Future<Map<String, String>> get baseHeaders => Future.value({});

  Map<String, String>? _combineHeaders(Map<String, String> headers1, Map<String, String> headers2) {
    return {
      ...headers1,
      ...headers2,
    };
  }

  @protected
  Future<T> makeRequest<T>(
    Future<Response> Function() request,
    T Function(Map<String, Object?> json) fromJson,
  ) async {
    var attempt = 1;
    while (true) {
      try {
        return await _makeRequest(request, fromJson);
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

  Future<T> _makeRequest<T>(
    Future<Response> Function() request,
    T Function(Map<String, Object?> json) fromJson,
  ) async {
    try {
      final response = await request();
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return fromJson(jsonDecode(response.body));
      }
      throw _errorMapper.fromResponse(response);
    } catch (e) {
      throw _errorMapper.fromException(e);
    }
  }
}
