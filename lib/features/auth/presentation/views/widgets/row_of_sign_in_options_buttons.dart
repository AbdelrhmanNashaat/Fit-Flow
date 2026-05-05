import 'package:fit_flow/core/utils/app_assets.dart';
import 'package:fit_flow/core/widgets/custom_button_with_image.dart';
import 'package:flutter/material.dart';

class RowOFSignInOptionsButtons extends StatelessWidget {
  const RowOFSignInOptionsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: CustomButtonWithImage(
            imagePath: Assets.googleLogo,
            text: 'Google',
            onPressed: () {},
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: CustomButtonWithImage(
            imagePath: Assets.appleLogo,
            text: 'Apple',
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
