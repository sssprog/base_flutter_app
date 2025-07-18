import 'package:base_flutter_app/ui/splash/splash_cubit.dart';
import 'package:base_flutter_app/ui/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  final Function() onOpenHome;
  final Function() onOpenAuth;

  SplashScreen(
      {super.key, required this.onOpenHome, required this.onOpenAuth});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (_, state) {
        if (state == SplashState.openAuth) {
          onOpenAuth();
        } else if (state == SplashState.openHome) {
          onOpenHome();
        }
      },
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
