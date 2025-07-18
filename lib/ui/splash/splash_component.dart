import 'package:base_flutter_app/ui/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashComponent extends StatelessWidget {
  final Widget _child;

  const SplashComponent({super.key, required child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context.read()),
      child: _child,
    );
  }
}
