import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AuthContainerParentWidget extends StatelessWidget {
  const AuthContainerParentWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: child,
    );
  }
}
