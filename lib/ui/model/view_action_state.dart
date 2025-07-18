import 'package:base_flutter_app/ui/model/ui_error.dart';

sealed class ViewActionState {
  ViewActionState();

  factory ViewActionState.none() => None();

  factory ViewActionState.loading() => Loading();

  factory ViewActionState.success() => Success();

  factory ViewActionState.error(UiError error) => Error(error);
}

class None extends ViewActionState {}

class Loading extends ViewActionState {}

class Success extends ViewActionState {}

class Error extends ViewActionState {
  final UiError error;

  Error(this.error);
}
