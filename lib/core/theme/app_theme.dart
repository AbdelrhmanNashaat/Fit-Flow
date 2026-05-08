import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      scaffoldBackgroundColor: AppColors.backgroundScaffold,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryColor,
        onPrimary: AppColors.whiteColor,
        secondary: AppColors.primaryNavSelected,
        onSecondary: AppColors.whiteColor,
        error: AppColors.error,
        onError: AppColors.whiteColor,
        surface: AppColors.backgroundScaffold,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.bold48,
        displayMedium: AppTextStyles.extraBold30,
        displaySmall: AppTextStyles.extraBold26,
        headlineLarge: AppTextStyles.bold26,
        headlineMedium: AppTextStyles.bold20,
        headlineSmall: AppTextStyles.bold18,
        titleLarge: AppTextStyles.bold16,
        titleMedium: AppTextStyles.medium14,
        titleSmall: AppTextStyles.semiBold12,
        bodyLarge: AppTextStyles.regular17,
        bodyMedium: AppTextStyles.regular16,
        bodySmall: AppTextStyles.regular14,
        labelLarge: AppTextStyles.bold14,
        labelMedium: AppTextStyles.medium12,
        labelSmall: AppTextStyles.regular12,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.buttonColor,
          foregroundColor: AppColors.whiteColor,
          textStyle: AppTextStyles.bold14,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.backgroundButton,
        hintStyle: AppTextStyles.regular14.copyWith(
          color: AppColors.hintTextColor,
        ),
        labelStyle: AppTextStyles.medium14.copyWith(
          color: AppColors.textPrimary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
      ),
    );
  }
}
