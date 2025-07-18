import 'package:base_flutter_app/data/repository/auth_repository.dart';
import 'package:base_flutter_app/ui/model/view_action_state.dart';
import 'package:base_flutter_app/ui/splash/splash_state.dart';
import 'package:base_flutter_app/ui/utils/error_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<ViewActionState> {
  final AuthRepository _authRepository;
  final ErrorMapper _errorMapper;

  AuthCubit({
    required AuthRepository authRepository,
    required ErrorMapper errorMapper,
  }) : _authRepository = authRepository,
       _errorMapper = errorMapper,
       super(ViewActionState.none());

  void login(String login, String password) {
    emit(ViewActionState.loading());
    _authRepository
        .login(login, password)
        .then((_) {
          emit(ViewActionState.success());
        })
        .catchError((e) {
          emit(ViewActionState.error(_errorMapper.map(e)));
        });
  }

  void clearState() {
    emit(ViewActionState.none());
  }
}
