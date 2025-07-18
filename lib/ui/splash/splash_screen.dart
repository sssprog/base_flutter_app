import 'package:base_flutter_app/ui/splash/splash_cubit.dart';
import 'package:base_flutter_app/ui/splash/splash_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onOpenHome;
  final VoidCallback onOpenAuth;

  const SplashScreen({
    super.key,
    required this.onOpenHome,
    required this.onOpenAuth,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashCubit, SplashState>(
        listener: (_, state) {
          if (state == SplashState.openAuth) {
            onOpenAuth();
          } else if (state == SplashState.openHome) {
            onOpenHome();
          }
        },
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Splash screen"),
              SizedBox(height: 16),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
