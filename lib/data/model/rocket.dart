import 'package:freezed_annotation/freezed_annotation.dart';
part 'rocket.freezed.dart';
part 'rocket.g.dart';

@freezed
abstract class Rocket with _$Rocket {
  const factory Rocket({
    @Default("") @JsonKey(name: "name") String name,
    @Default("") @JsonKey(name: "country") String country,
    @Default("") @JsonKey(name: "company") String company,
    @Default("") @JsonKey(name: "description") String description,
    @Default(10) @JsonKey(name: "cost_per_launch") int costPerLaunch,
    @Default([]) @JsonKey(name: "flickr_images") List<String> images,
  }) = _Rocket;

  factory Rocket.fromJson(Map<String, Object?> json) => _$RocketFromJson(json);
}