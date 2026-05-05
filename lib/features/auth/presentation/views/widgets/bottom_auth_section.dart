import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/nav_to_auth_widget.dart';
import 'package:flutter/material.dart';

class BottomAuthSection extends StatelessWidget {
  const BottomAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavToAuthWidget(
          text: 'New to FitFlow?',
          navText: 'Create an account',
          onTap: () {},
        ),
        const SizedBox(height: 16),
        Text(
          'Terms of Use  ·  Privacy Policy',
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.hintTextColor,
          ),
        ),
      ],
    );
  }
}
