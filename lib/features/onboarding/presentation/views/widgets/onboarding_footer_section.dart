import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class OnboardingFooterSection extends StatelessWidget {
  const OnboardingFooterSection({
    super.key,
    required this.isLoading,
    required this.onContinue,
  });

  final bool isLoading;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButton(
          text: 'Continue',
          isLoading: isLoading,
          onPressed: onContinue,
        ),
        const SizedBox(height: 14),
        Center(
          child: Text(
            'YOU CAN CHANGE THIS LATER IN PROFILE',
            style: AppTextStyles.semiBold12.copyWith(
              color: AppColors.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
