import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/nav_to_auth_widget.dart';
import 'package:flutter/material.dart';

class CreateAccountBottomSection extends StatelessWidget {
  const CreateAccountBottomSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NavToAuthWidget(
          text: 'Already have an account?',
          navText: 'Sign in',
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
