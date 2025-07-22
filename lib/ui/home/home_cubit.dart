import 'package:base_flutter_app/data/model/rocket.dart';
import 'package:base_flutter_app/data/repository/rocket_repository.dart';
import 'package:base_flutter_app/ui/model/view_state.dart';
import 'package:base_flutter_app/ui/utils/error_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<ViewState<List<Rocket>>> {
  final RocketRepository _rocketRepository;
  final ErrorMapper _errorMapper;

  HomeCubit({
    required RocketRepository rocketRepository,
    required ErrorMapper errorMapper,
  }) : _rocketRepository = rocketRepository,
       _errorMapper = errorMapper,
       super(Loading()) {
    loadRockets();
  }

  void loadRockets() {
    debugPrint("loadRockets");
    emit(Loading());
    _rocketRepository
        .rockets()
        .then((result) {
          emit(Success(result));
        })
        .catchError((e) {
          debugPrint("loadRockets error $e");
          emit(Error(_errorMapper.map(e)));
        });
  }

  @override
  Future<void> close() {
    debugPrint("HomeCubit closed");
    return super.close();
  }
}
