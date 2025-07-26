import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/network/authorized_api_executor.dart';
import 'package:base_flutter_app/data/network/rockets_api.dart';

class RocketRepository {
  final RocketsApi _api;
  final AuthorizedApiExecutor _apiExecutor;

  RocketRepository(this._api, this._apiExecutor);

  Future<List<Rocket>> rockets() async {
    return await _apiExecutor.execute(() => _api.rockets());
  }
}
