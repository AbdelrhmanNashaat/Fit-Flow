import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class OnboardingHeaderSection extends StatelessWidget {
  const OnboardingHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppBarWidget(title: l10n.appName, imagePath: Assets.questionIcon),
        const SizedBox(height: 28),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.onboardingTitle,
                style: AppTextStyles.extraBold30.copyWith(
                  color: AppColors.blackColor,
                ),
              ),
              Text(
                l10n.onboardingSubtitle,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
