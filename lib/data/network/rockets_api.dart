import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'rockets_api.g.dart';

@RestApi()
abstract class RocketsApi {
  factory RocketsApi(Dio dio, {String? baseUrl}) = _RocketsApi;

  @GET('rockets')
  Future<List<Rocket>> rockets();
}
