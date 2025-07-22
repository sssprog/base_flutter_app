import 'package:base_flutter_app/ui/model/ui_error.dart';

sealed class ViewState<T> {}

class Empty<T> implements ViewState<T> {}

class Loading<T> implements ViewState<T> {}

class Success<T> implements ViewState<T> {
  final T data;

  Success(this.data);
}

class Error<T> implements ViewState<T> {
  final UiError error;

  Error(this.error);
}
