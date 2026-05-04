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
  static const TextStyle medium14 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: AppColors.blackColor,
    fontFamily: fontFamily,
  );
  static const TextStyle regular17 = TextStyle(
    fontWeight: FontWeight.w400,
    fontSize: 17,
    color: AppColors.blackColor,
    fontFamily: fontFamily,
  );
  static const TextStyle bold26 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 26,
    letterSpacing: 2.8,
    color: AppColors.primaryColor,
    fontFamily: fontFamily,
  );
  static const TextStyle extraBold26 = TextStyle(
    fontWeight: FontWeight.w800,
    fontSize: 26,
    color: AppColors.blackColor,
    fontFamily: fontFamily,
  );
}
