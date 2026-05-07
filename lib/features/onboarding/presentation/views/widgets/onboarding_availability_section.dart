import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/availability_selector.dart';
import 'package:flutter/material.dart';

class OnboardingAvailabilitySection extends StatelessWidget {
  const OnboardingAvailabilitySection({
    super.key,
    required this.selectedDays,
    required this.onSelected,
  });

  final int selectedDays;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Availability',
          style: AppTextStyles.bold18.copyWith(
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        AvailabilitySelector(
          selectedDays: selectedDays,
          onSelected: onSelected,
        ),
      ],
    );
  }
}
