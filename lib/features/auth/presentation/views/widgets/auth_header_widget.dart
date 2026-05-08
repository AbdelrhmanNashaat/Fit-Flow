import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AuthHeaderSection extends StatelessWidget {
  const AuthHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        const SizedBox(height: 60),
        SvgPicture.asset(Assets.authIcon),
        const SizedBox(height: 12),
        Text(
          l10n.authBrandName,
          style: AppTextStyles.extraBold26.copyWith(
            color: AppColors.blackColor,
          ),
        ),
        Text(
          l10n.welcomeBackSubtitle,
          style: AppTextStyles.regular17.copyWith(color: AppColors.blackColor),
        ),
      ],
    );
  }
}
