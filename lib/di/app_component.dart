import 'package:base_flutter_app/data/repository/Preferences.dart';
import 'package:base_flutter_app/data/repository/auth_repository.dart';
import 'package:base_flutter_app/ui/utils/ErrorMapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'FactoryProvider.dart';

class AppComponent extends StatelessWidget {
  final Widget _child;

  const AppComponent({super.key, required child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => Preferences()),
        Provider(create: (context) => AuthRepository(context.read())),
        FactoryProvider(create: (context) => ErrorMapper()),
      ],
      child: _child,
    );
  }
}