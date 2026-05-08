import 'package:fit_flow/core/widgets/error_banner.dart';
import 'package:flutter/material.dart';

class AnimatedErrorBanner extends StatelessWidget {
  const AnimatedErrorBanner({
    super.key,
    required this.message,
    required this.onDismiss,
  });

  final String? message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 280),
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.25),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: message != null
          ? Padding(
              key: ValueKey(message),
              padding: const EdgeInsets.only(bottom: 12),
              child: ErrorBanner(message: message!, onDismiss: onDismiss),
            )
          : const SizedBox.shrink(key: ValueKey('no-error')),
    );
  }
}
