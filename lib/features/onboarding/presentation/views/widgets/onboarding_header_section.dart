import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OnboardingHeaderSection extends StatelessWidget {
  const OnboardingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBarWidget(title: 'FitFlow', imagePath: Assets.questionIcon),
        SizedBox(height: 28),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Your Goal', style: AppTextStyles.extraBold30),
              Text(
                'Customize your journey for precision performance.',
                style: AppTextStyles.regular14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
