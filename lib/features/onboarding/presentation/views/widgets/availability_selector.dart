import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AvailabilitySelector extends StatelessWidget {
  const AvailabilitySelector({
    super.key,
    required this.selectedDays,
    required this.onSelected,
  });

  final int selectedDays;
  final ValueChanged<int> onSelected;

  static const _options = <int>[2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider2Color),
      ),
      child: Row(
        children: _options.map((days) {
          final isSelected = selectedDays == days;
          final label = days == 5 ? '5+ Days' : '$days Days';
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(days),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    label,
                    style: AppTextStyles.medium12.copyWith(
                      color: isSelected
                          ? AppColors.whiteColor
                          : AppColors.borderColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
