import 'package:base_flutter_app/ui/model/view_action_state.dart';
import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final ViewActionState state;
  final Widget child;

  const LoadingOverlay({super.key, required this.state, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (state is Loading)
          Container(
            color: const Color(0x88FFFFFF),
            child: const CircularProgressIndicator(),
          ),
      ],
    );
  }
}
