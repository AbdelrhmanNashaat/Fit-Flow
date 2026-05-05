import 'package:fit_flow/features/auth/presentation/views/widgets/text_filed_with_label.dart';
import 'package:flutter/material.dart';

class BothTextFiledWidget extends StatelessWidget {
  const BothTextFiledWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFiledWithLabel(
          label: 'EMAIL ADDRESS',
          hintText: 'name@example.com',
          controller: TextEditingController(),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'PASSWORD',
          obscureText: true,
          hintText: '••••••••',
          controller: TextEditingController(),
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (value) {
            // Handle field submission if needed
          },
        ),
      ],
    );
  }
}
