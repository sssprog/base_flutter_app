import 'package:freezed_annotation/freezed_annotation.dart';
part 'login_request.freezed.dart';
part 'login_request.g.dart';

@freezed
abstract class LoginRequest with _$LoginRequest {
  const factory LoginRequest({
    @JsonKey(name: "login") required String login,
    @JsonKey(name: "password") required String password,
  }) = _LoginRequest;

  factory LoginRequest.fromJson(Map<String, Object?> json) => _$LoginRequestFromJson(json);
}