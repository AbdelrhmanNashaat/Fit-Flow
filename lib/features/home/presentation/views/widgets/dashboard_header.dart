import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    required this.greeting,
    required this.userName,
  });

  final String greeting;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final greetingText = switch (greeting) {
      'morning' => l10n.goodMorning,
      'afternoon' => l10n.goodAfternoon,
      _ => l10n.goodEvening,
    };
    final firstName = userName.split(' ').first;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greetingText, $firstName',
                style: AppTextStyles.extraBold26.copyWith(
                  color: AppColors.primaryColor,
                  fontSize: 24,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                l10n.letsGetToWork,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.orTextColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        const Icon(
          Icons.settings_outlined,
          color: AppColors.orTextColor,
          size: 22,
        ),
      ],
    );
  }
}
