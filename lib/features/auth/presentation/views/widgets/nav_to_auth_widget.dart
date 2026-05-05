import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class NavToAuthWidget extends StatelessWidget {
  const NavToAuthWidget({
    super.key,
    required this.text,
    required this.navText,
    required this.onTap,
  });
  final String text;
  final String navText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppTextStyles.medium14.copyWith(
            color: AppColors.buttonTextColor2,
          ),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: onTap,
          child: Text(
            navText,
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.navTextColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
