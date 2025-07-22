import 'package:base_flutter_app/ui/model/ui_error.dart';

sealed class ViewActionState {}

class None implements ViewActionState {}

class Loading implements ViewActionState {}

class Success implements ViewActionState {}

class Error implements ViewActionState {
  final UiError error;

  Error(this.error);
}
