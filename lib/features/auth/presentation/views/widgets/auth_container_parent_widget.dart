import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AuthContainerParentWidget extends StatelessWidget {
  const AuthContainerParentWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderColor, width: 0.8),
      ),
      child: child,
    );
  }
}
