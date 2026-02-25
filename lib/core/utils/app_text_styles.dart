import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const String fontFamily = 'Lexend';
  static const TextStyle bold48 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 48,
    letterSpacing: -1.2,
    color: AppColors.whiteColor,
    fontFamily: fontFamily,
  );
  static const TextStyle light14 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 2.8,
    color: AppColors.whiteColor,
    fontFamily: fontFamily,
  );
}
