import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ForgetPassButton extends StatelessWidget {
  const ForgetPassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, AppNavigation.forgotPassword),
        child: Text(
          'Forgot Password?',
          style: AppTextStyles.medium12.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
