import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgetPassButton extends StatelessWidget {
  const ForgetPassButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () => context.push(AppNavigation.forgotPassword),
        child: Text(
          context.l10n.forgotPassword,
          style: AppTextStyles.medium12.copyWith(color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
