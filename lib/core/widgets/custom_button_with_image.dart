import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomButtonWithImage extends StatelessWidget {
  const CustomButtonWithImage({
    super.key,
    required this.text,
    required this.imagePath,
    required this.onPressed,
  });
  final String text;
  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.buttonBorderColor, width: 0.6),
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(imagePath, height: 24),
            const SizedBox(width: 8),
            Text(
              text,
              style: AppTextStyles.regular17.copyWith(
                color: AppColors.buttonTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
