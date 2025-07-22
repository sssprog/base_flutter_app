import 'package:base_flutter_app/ui/auth/auth_cubit.dart';
import 'package:base_flutter_app/ui/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeComponent extends StatelessWidget {
  final Widget child;

  const HomeComponent({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        rocketRepository: context.read(),
        errorMapper: context.read(),
      ),
      child: child,
    );
  }
}
