import 'package:base_flutter_app/ui/model/view_state.dart';
import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';

class ViewStateWidget<T> extends StatelessWidget {
  final ViewState<T> state;
  final VoidCallback onRetry;
  final Widget Function(BuildContext context, T data) builder;

  const ViewStateWidget({super.key, required this.state, required this.onRetry, required this.builder});

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      Loading() => Center(child: const CircularProgressIndicator()),
      Empty<T>() => Center(
        child: Text(
          AppLocalizations.of(context).emptyListMessage,
          style: TextTheme.of(context).headlineSmall,
        ),
      ),
      (Success<T> success) => builder(context, success.data),
      (Error<T> error) => SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              error.error.description,
              style: TextTheme.of(context).headlineSmall,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: onRetry,
              child: Text(AppLocalizations.of(context).retry),
            ),
          ],
        ),
      ),
    };
  }
}
