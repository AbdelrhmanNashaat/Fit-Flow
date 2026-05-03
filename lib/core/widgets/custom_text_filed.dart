import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomTextFiled extends StatelessWidget {
  const CustomTextFiled({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: AppColors.secondaryColor,
      style: AppTextStyles.medium14,
      decoration: InputDecoration(
        border: borderMethod(),
        enabledBorder: borderMethod(),
        focusedBorder: borderMethod(),
        errorBorder: borderMethod(),
      ),
    );
  }

  OutlineInputBorder borderMethod() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.secondaryColor, width: 1),
    );
  }
}
