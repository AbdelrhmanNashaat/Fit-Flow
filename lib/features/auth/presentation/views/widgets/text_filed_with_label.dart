import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';

class TextFiledWithLabel extends StatelessWidget {
  const TextFiledWithLabel({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
  });
  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.semiBold12),
        const SizedBox(height: 6),
        CustomTextFiled(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
        ),
      ],
    );
  }
}
