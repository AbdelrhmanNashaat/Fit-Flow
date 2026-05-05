import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import 'package:fit_flow/core/utils/app_colors.dart';

class CustomTextFiled extends StatefulWidget {
  const CustomTextFiled({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomTextFiled> createState() => _CustomTextFiledState();
}

class _CustomTextFiledState extends State<CustomTextFiled> {
  bool isObscure = false;
  @override
  void initState() {
    super.initState();
    isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      obscureText: isObscure,
      controller: widget.controller,
      cursorColor: AppColors.hintTextColor,
      style: AppTextStyles.medium14,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.medium14.copyWith(
          color: AppColors.hintTextColor,
        ),
        suffixIcon: widget.obscureText == true
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.hintTextColor,
                  size: 20,
                ),
              )
            : null,
        fillColor: AppColors.fillColor,
        filled: true,
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
