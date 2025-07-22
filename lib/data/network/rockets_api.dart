import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/network/authorized_api_client.dart';
import 'package:base_flutter_app/data/utils/json_utils.dart';

import 'api_url_provider.dart';

class RocketsApi {
  final AuthorizedApiClient _client;
  final ApiUrlProvider _apiUrlProvider;

  RocketsApi(this._client, this._apiUrlProvider);

  Future<List<Rocket>> rockets() async {
    return await _client.get(
      _apiUrlProvider.urlForPath("rockets"),
      (json) => listFromJson(json, Rocket.fromJson),
    );
  }
}
