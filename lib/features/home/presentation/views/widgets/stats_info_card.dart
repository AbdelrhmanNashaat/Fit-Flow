import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class StatsInfoCard extends StatelessWidget {
  const StatsInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.subtitle,
    this.color = AppColors.buttonColor,
  });

  final IconData icon;
  final String label;
  final String value;
  final String subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dividerLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: AppTextStyles.extraBold26.copyWith(fontSize: 22),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: AppTextStyles.bold14.copyWith(
              color: AppColors.textSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.orTextColor,
              fontSize: 11,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
