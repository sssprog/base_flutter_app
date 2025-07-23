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
        AnimatedLoadingOverlay(visible: state is Loading),
      ],
    );
  }
}

class AnimatedLoadingOverlay extends StatefulWidget {
  final bool visible;

  const AnimatedLoadingOverlay({super.key, required this.visible});

  @override
  State<AnimatedLoadingOverlay> createState() => _AnimatedLoadingOverlayState();
}

class _AnimatedLoadingOverlayState extends State<AnimatedLoadingOverlay>
    with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedLoadingOverlay oldWidget) {
    if (oldWidget.visible != widget.visible) {
      if (widget.visible) {
        _animationController.forward(from: 0);
      } else {
        _animationController.stop();
        _animationController.reverse(from: 1);
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        color: const Color(0x88FFFFFF),
        child: const CircularProgressIndicator(),
      ),
      builder: (BuildContext context, Widget? child) {
        if (_animationController.status == AnimationStatus.dismissed) {
          return const SizedBox();
        }
        return Opacity(
          opacity: _animationController.value,
          child: child,
        );
      },
    );
  }
}
