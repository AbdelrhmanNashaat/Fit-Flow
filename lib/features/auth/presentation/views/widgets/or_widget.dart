import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.dividerColor)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'or continue with',
            style: AppTextStyles.medium12.copyWith(
              color: AppColors.orTextColor,
            ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.dividerColor)),
      ],
    );
  }
}
