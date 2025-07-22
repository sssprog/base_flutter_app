import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/network/rockets_api.dart';

class RocketRepository {
  final RocketsApi _api;

  RocketRepository(this._api);

  Future<List<Rocket>> rockets() async {
    return await _api.rockets();
  }
}
