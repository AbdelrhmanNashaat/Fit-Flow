import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({
    super.key,
    required this.title,
    this.imagePath,
    this.trailing,
  });
  final String title;
  final String? imagePath;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text(
                  title,
                  style: AppTextStyles.bold18.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                const Spacer(),
                if (trailing != null)
                  trailing!
                else if (imagePath != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: SvgPicture.asset(imagePath!),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          const Divider(color: AppColors.dividerLight, thickness: 1.5),
        ],
      ),
    );
  }
}
