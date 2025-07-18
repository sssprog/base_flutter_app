import 'package:base_flutter_app/data/repository/auth_repository.dart';
import 'package:base_flutter_app/ui/splash/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository _authRepository;

  SplashCubit(this._authRepository) : super(SplashState.loading) {
    checkAuthState();
  }

  void checkAuthState() {
    _authRepository.isAuthorized().then((authorized) {
      if (authorized) {
        emit(SplashState.openHome);
      } else {
        emit(SplashState.openAuth);
      }
    });
  }
}
