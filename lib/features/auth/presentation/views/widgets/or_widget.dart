import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('or continue with', style: AppTextStyles.medium12),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}
