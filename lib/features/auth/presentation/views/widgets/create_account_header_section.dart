import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CreateAccountHeaderSection extends StatelessWidget {
  const CreateAccountHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(Assets.authIcon),
        const SizedBox(height: 12),
        Text('FitFlow Pure', style: AppTextStyles.extraBold26.copyWith(color: AppColors.blackColor)),
        Text(
          'Create your account to get started.',
          style: AppTextStyles.regular17.copyWith(color: AppColors.blackColor),
        ),
      ],
    );
  }
}
