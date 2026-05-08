import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class GoalOptionCard extends StatelessWidget {
  const GoalOptionCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  static const _radius = 16.0;
  static const _duration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    final animatedContainerBorderColor = isSelected
        ? AppColors.primaryColor
        : AppColors.dividerLight;
    final roundedContainerBorderColor = isSelected
        ? AppColors.primaryColor
        : AppColors.borderColor;

    return AnimatedContainer(
      duration: _duration,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(_radius),
        border: Border.all(
          color: animatedContainerBorderColor,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(_radius),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Icon(icon, color: AppColors.primaryColor),
                  ),
                ),
                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: AppTextStyles.bold16.copyWith(color: AppColors.blackColor)),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: AppTextStyles.regular12.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                AnimatedScale(
                  duration: _duration,
                  scale: isSelected ? 1 : .9,
                  child: Icon(
                    isSelected
                        ? Icons.radio_button_checked_rounded
                        : Icons.radio_button_off_rounded,
                    color: roundedContainerBorderColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
