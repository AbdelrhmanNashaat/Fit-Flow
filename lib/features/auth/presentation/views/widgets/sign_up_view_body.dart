import 'package:fit_flow/core/widgets/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.1),
          const AuthContainerWithImage(),
          SizedBox(height: size.height * 0.05),
          const Text(
            'Create an account to get started',
            style: AppTextStyles.medium14,
          ),
          SizedBox(height: size.height * 0.01),
          CustomTextFiled(),
          SizedBox(height: size.height * 0.02),
          CustomTextFiled(),
          SizedBox(height: size.height * 0.02),
          CustomTextFiled(),
          SizedBox(height: size.height * 0.02),
        ],
      ),
    );
  }
}

class AuthContainerWithImage extends StatelessWidget {
  const AuthContainerWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: AppColors.secondaryColor),
      child: SvgPicture.asset(Assets.assetsImagesClaps),
    );
  }
}
