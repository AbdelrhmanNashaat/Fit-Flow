<<<<<<< HEAD
﻿import 'package:fit_flow/core/utils/app_colors.dart';
=======
import 'package:fit_flow/core/utils/app_colors.dart';
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileStatItem extends StatelessWidget {
  const ProfileStatItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
          border: Border.all(color: AppColors.dividerLight),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
=======
          border: Border.all(color: AppColors.divider2Color),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(icon, size: 16, color: AppColors.primaryColor),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: AppTextStyles.semiBold12.copyWith(
                    color: AppColors.orTextColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: AppTextStyles.bold14,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
