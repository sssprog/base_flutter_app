import 'package:freezed_annotation/freezed_annotation.dart';
part 'token_response.freezed.dart';
part 'token_response.g.dart';

@freezed
abstract class TokenResponse with _$TokenResponse {
  const factory TokenResponse({
    @Default("") @JsonKey(name: "authToken") String authToken,
    @Default("") @JsonKey(name: "refreshToken") String refreshToken,
  }) = _TokenResponse;

  factory TokenResponse.fromJson(Map<String, Object?> json) => _$TokenResponseFromJson(json);
}