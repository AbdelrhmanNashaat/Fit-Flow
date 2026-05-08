import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class TextFieldWithLabel extends StatelessWidget {
  const TextFieldWithLabel({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.semiBold12.copyWith(color: AppColors.hintTextColor)),
        const SizedBox(height: 6),
        CustomTextField(
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
        ),
      ],
    );
  }
}
