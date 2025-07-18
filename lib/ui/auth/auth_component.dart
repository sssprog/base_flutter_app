import 'package:base_flutter_app/ui/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthComponent extends StatelessWidget {
  final Widget _child;

  const AuthComponent({super.key, required child}) : _child = child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(
        authRepository: context.read(),
        errorMapper: context.read(),
      ),
      child: _child,
    );
  }
}
