import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(Assets.authIcon),
        const SizedBox(height: 12),
        Text('FitFlow Pure', style: AppTextStyles.extraBold26.copyWith(color: AppColors.blackColor)),
        Text(
          'Welcome back. Let\'s keep moving.',
          style: AppTextStyles.regular17.copyWith(color: AppColors.blackColor),
        ),
      ],
    );
  }
}
