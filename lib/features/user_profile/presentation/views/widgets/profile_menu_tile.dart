<<<<<<< HEAD
﻿import 'package:fit_flow/core/utils/app_colors.dart';
=======
import 'package:fit_flow/core/utils/app_colors.dart';
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileMenuTile extends StatelessWidget {
  const ProfileMenuTile({
    super.key,
    required this.icon,
    required this.label,
    this.trailingText,
    this.onTap,
    this.isDestructive = false,
    this.isLanguage = false,
  });

  final IconData icon;
  final String label;
  final String? trailingText;
  final VoidCallback? onTap;
  final bool isDestructive;
  final bool isLanguage;

  @override
  Widget build(BuildContext context) {
    Color color;
    Color iconBgColor;

    if (isDestructive) {
      color = Colors.red;
      iconBgColor = Colors.red.withValues(alpha: 0.08);
    } else if (isLanguage) {
      color = AppColors.buttonColor;
<<<<<<< HEAD
      iconBgColor = AppColors.primarySurface;
    } else {
      color = AppColors.textPrimary;
      iconBgColor = AppColors.backgroundCard;
=======
      iconBgColor = AppColors.lightBlueColor;
    } else {
      color = AppColors.buttonTextColor;
      iconBgColor = AppColors.backgroundColor;
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.regular16.copyWith(color: color),
                ),
              ),
              if (trailingText != null) ...[
                Text(
                  trailingText!,
                  style: AppTextStyles.regular14.copyWith(
                    color: AppColors.orTextColor,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: isDestructive ? Colors.red : AppColors.orTextColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
