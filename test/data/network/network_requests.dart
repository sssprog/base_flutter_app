import 'package:base_flutter_app/data/model/rocket.dart';

abstract interface class RocketsRequest {
  Future<List<Rocket>> call();
}