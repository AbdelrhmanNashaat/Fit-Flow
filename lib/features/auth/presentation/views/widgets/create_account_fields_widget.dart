import 'package:fit_flow/features/auth/presentation/views/widgets/text_filed_with_label.dart';
import 'package:flutter/material.dart';

class CreateAccountFieldsWidget extends StatelessWidget {
  const CreateAccountFieldsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFiledWithLabel(
          label: 'FULL NAME',
          hintText: 'John Doe',
          controller: TextEditingController(),
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'EMAIL ADDRESS',
          hintText: 'name@example.com',
          controller: TextEditingController(),
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'PASSWORD',
          obscureText: true,
          hintText: '••••••••',
          controller: TextEditingController(),
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'CONFIRM PASSWORD',
          obscureText: true,
          hintText: '••••••••',
          controller: TextEditingController(),
        ),
      ],
    );
  }
}
