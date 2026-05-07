import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AvailabilityOptionCard extends StatelessWidget {
  const AvailabilityOptionCard({
    super.key,
    required this.days,
    required this.isSelected,
    required this.onTap,
  });

  final int days;
  final bool isSelected;
  final VoidCallback onTap;

  String get _label => days == 5 ? '+5 Days' : '$days Days';

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: AppColors.shadow,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              _label,
              style: AppTextStyles.semiBold12.copyWith(
                color: isSelected
                    ? AppColors.whiteColor
                    : AppColors.textTertiary,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
