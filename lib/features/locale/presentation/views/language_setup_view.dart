import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/features/locale/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageSetupView extends StatelessWidget {
  const LanguageSetupView({super.key, required this.onLanguageSelected});

  final VoidCallback onLanguageSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundScaffold,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Spacer(flex: 3),
                      _Header(),
                      const Spacer(flex: 2),
                      _LanguageCard(
                        languageName: 'English',
                        languageCode: 'en',
                        nativeLabel: 'Continue in English',
                        isRtl: false,
                        onTap: () => _select(context, 'en'),
                      ),
                      const SizedBox(height: 16),
                      _LanguageCard(
                        languageName: 'العربية',
                        languageCode: 'ar',
                        nativeLabel: 'المتابعة بالعربية',
                        isRtl: true,
                        onTap: () => _select(context, 'ar'),
                      ),
                      const Spacer(flex: 3),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _select(BuildContext context, String languageCode) async {
    final cubit = context.read<LocaleCubit>();
    await cubit.setLocale(languageCode);
    await cubit.markLanguageSetupDone();
    onLanguageSelected();
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Icon(
            Icons.bolt_rounded,
            color: AppColors.whiteColor,
            size: 36,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'FitFlow',
          style: AppTextStyles.extraBold30.copyWith(
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'Choose your language',
          style: AppTextStyles.regular14.copyWith(color: AppColors.orTextColor),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          'اختر لغتك',
          style: AppTextStyles.regular14.copyWith(color: AppColors.orTextColor),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _LanguageCard extends StatelessWidget {
  const _LanguageCard({
    required this.languageName,
    required this.languageCode,
    required this.nativeLabel,
    required this.isRtl,
    required this.onTap,
  });

  final String languageName;
  final String languageCode;
  final String nativeLabel;
  final bool isRtl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.dividerLight, width: 1.5),
          ),
          child: Directionality(
            textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
            child: Row(
              children: [
                Text(
                  isRtl ? '🇸🇦' : '🇬🇧',
                  style: const TextStyle(fontSize: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        languageName,
                        style: AppTextStyles.bold18.copyWith(
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        nativeLabel,
                        style: AppTextStyles.regular14.copyWith(
                          color: AppColors.orTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: AppColors.orTextColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
