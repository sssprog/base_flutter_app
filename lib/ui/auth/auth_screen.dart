import 'package:base_flutter_app/ui/auth/auth_cubit.dart';
import 'package:base_flutter_app/ui/model/view_action_state.dart';
import 'package:base_flutter_app/ui/widget/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../l10n/app_localizations.dart';

class AuthScreen extends StatelessWidget {
  final VoidCallback onOpenHome;

  const AuthScreen({super.key, required this.onOpenHome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, ViewActionState>(
        builder: (context, state) {
          return LoadingOverlay(
            state: state,
            child: _Content(onOpenHome: onOpenHome),
          );
        },
        buildWhen: (previous, current) =>
            previous is Loading && current is! Loading ||
            previous is! Loading && current is Loading,
        listener: (context, state) {
          switch (state) {
            case Success():
              onOpenHome();
            case Error():
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error.description)),
              );
              context.read<AuthCubit>().clearState();
            case None():
            case Loading():
            // no-op
          }
        },
      ),
    );
  }
}

class _Content extends StatefulWidget {
  final VoidCallback onOpenHome;

  const _Content({super.key, required this.onOpenHome});

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> with RestorationMixin {
  late RestorableTextEditingController _loginController;
  late RestorableTextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _loginController = RestorableTextEditingController();
    _passwordController = RestorableTextEditingController();
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context).authScreenTitle,
            style: TextTheme.of(context).headlineSmall,
          ),
          SizedBox(height: 24),
          TextField(
            controller: _loginController.value,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).login,
            ),
          ),
          SizedBox(height: 4),
          TextField(
            controller: _passwordController.value,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).password,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<AuthCubit>().login(
              _loginController.value.text,
              _passwordController.value.text,
            ),
            child: Text(AppLocalizations.of(context).login),
          ),
        ],
      ),
    );
  }

  @override
  String? get restorationId => "auth_screen";

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_loginController, "login");
    registerForRestoration(_passwordController, "password");
  }
}
