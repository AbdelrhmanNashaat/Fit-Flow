<<<<<<< HEAD
﻿import 'package:fit_flow/core/utils/app_colors.dart';
=======
import 'package:fit_flow/core/utils/app_colors.dart';
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileSettingsGroup extends StatelessWidget {
  const ProfileSettingsGroup({
    super.key,
    required this.label,
    required this.children,
  });

  final String label;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label.toUpperCase(),
            style: AppTextStyles.bold14.copyWith(color: AppColors.orTextColor),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(12),
<<<<<<< HEAD
            border: Border.all(color: AppColors.borderLight),
=======
            border: Border.all(color: AppColors.lightGrayColor),
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < children.length; i++) ...[
                children[i],
                if (i < children.length - 1)
                  const Divider(
                    height: 1,
                    thickness: 1,
<<<<<<< HEAD
                    color: AppColors.dividerLight,
=======
                    color: AppColors.divider2Color,
>>>>>>> 6e1e05bb329e007ed72045362810255f370f1d26
                    indent: 16,
                    endIndent: 16,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
