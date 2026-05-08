import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OnboardingHeaderSection extends StatelessWidget {
  const OnboardingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomAppBarWidget(title: 'FitFlow', imagePath: Assets.questionIcon),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Your Goal', style: AppTextStyles.extraBold30.copyWith(color: AppColors.blackColor)),
              Text(
                'Customize your journey for precision performance.',
                style: AppTextStyles.regular14.copyWith(color: AppColors.textSecondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
