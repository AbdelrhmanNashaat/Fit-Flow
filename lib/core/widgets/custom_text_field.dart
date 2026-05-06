import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
    this.validator,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      focusNode: widget.focusNode,
      obscureText: _isObscure,
      keyboardType: widget.keyboardType,
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      cursorColor: AppColors.hintTextColor,
      style: AppTextStyles.medium14,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: AppTextStyles.medium14.copyWith(
          color: AppColors.hintTextColor,
        ),
        suffixIcon: widget.obscureText
            ? GestureDetector(
                onTap: () => setState(() => _isObscure = !_isObscure),
                child: Icon(
                  _isObscure ? Icons.visibility : Icons.visibility_off,
                  color: AppColors.hintTextColor,
                  size: 20,
                ),
              )
            : null,
        fillColor: AppColors.fillColor,
        filled: true,
        border: _border(),
        enabledBorder: _border(),
        focusedBorder: _border(),
        errorBorder: _errorBorder(),
        focusedErrorBorder: _errorBorder(),
        errorStyle: AppTextStyles.medium12.copyWith(color: Colors.red),
      ),
    );
  }

  OutlineInputBorder _border() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.secondaryColor, width: 1),
    );
  }

  OutlineInputBorder _errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.red, width: 1),
    );
  }
}
