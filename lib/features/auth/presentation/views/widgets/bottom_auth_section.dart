import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_navigation.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/nav_to_auth_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomAuthSection extends StatelessWidget {
  const BottomAuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      children: [
        NavToAuthWidget(
          text: l10n.newToFitFlow,
          navText: l10n.createAccountNav,
          onTap: () => context.go(AppNavigation.signUp),
        ),
        const SizedBox(height: 16),
        Text(
          l10n.termsAndPrivacyLabel,
          style: AppTextStyles.medium12.copyWith(
            color: AppColors.hintTextColor,
          ),
        ),
      ],
    );
  }
}
