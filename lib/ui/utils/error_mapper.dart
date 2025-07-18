import 'package:base_flutter_app/data/model/api_exception.dart';
import 'package:base_flutter_app/l10n/app_localizations.dart';

import '../model/ui_error.dart';

class ErrorMapper {
  final AppLocalizations _appLocalizations;

  ErrorMapper(this._appLocalizations);

  UiError map(Object e) {
    if (e is! ApiException) return UiError(_appLocalizations.defaultErrorMessage);
    return UiError(e.description);
  }
}
