import 'package:base_flutter_app/di/app_component.dart';
import 'package:flutter/material.dart';

import 'app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppComponent(
      child: MaterialApp.router(
        routerConfig: appRouter,
      ),
    );
  }
}