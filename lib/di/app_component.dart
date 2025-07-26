import 'package:base_flutter_app/data/network/api_error_mapper.dart';
import 'package:base_flutter_app/data/network/api_executor.dart';
import 'package:base_flutter_app/data/network/api_url_provider.dart';
import 'package:base_flutter_app/data/network/auth_service.dart';
import 'package:base_flutter_app/data/network/auth_token_provider.dart';
import 'package:base_flutter_app/data/network/authorized_api_executor.dart';
import 'package:base_flutter_app/data/network/rockets_api.dart';
import 'package:base_flutter_app/data/network/token_refresher.dart';
import 'package:base_flutter_app/data/repository/auth_repository.dart';
import 'package:base_flutter_app/data/repository/preferences.dart';
import 'package:base_flutter_app/data/repository/rocket_repository.dart';
import 'package:base_flutter_app/l10n/app_localizations.dart';
import 'package:base_flutter_app/ui/utils/error_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppComponent extends StatelessWidget {
  final Widget _child;

  const AppComponent({super.key, required child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Preferences()),
        Provider(create: (context) => ApiExecutor(ApiErrorMapper())),
        Provider(create: (context) => ApiUrlProvider("https://api.spacexdata.com/v4/")),
        Provider(create: (context) => AuthService()),
        Provider(create: (context) => AuthRepository(context.read(), context.read())),
        Provider<TokenRefresher>(create: (context) => context.read<AuthRepository>()),
        Provider<AuthTokenProvider>(create: (context) => context.read<AuthRepository>()),
        Provider(
          create: (context) => AuthorizedApiExecutor(
            ApiErrorMapper(),
            context.read(),
            context.read(),
          ),
        ),
        Provider(
          create: (context) => RocketsApi(Dio(), baseUrl: "https://api.spacexdata.com/v4/"),
        ),
        Provider(create: (context) => RocketRepository(context.read(), context.read())),
        Provider(
          create: (context) {
            return ErrorMapper(
              lookupAppLocalizations(PlatformDispatcher.instance.locale),
            );
          },
        ),
      ],
      child: _child,
    );
  }
}
