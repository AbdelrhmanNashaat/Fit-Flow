import 'package:fit_flow/features/auth/presentation/views/widgets/text_filed_with_label.dart';
import 'package:flutter/material.dart';

class BothTextFiledWidget extends StatefulWidget {
  const BothTextFiledWidget({super.key});

  @override
  State<BothTextFiledWidget> createState() => _BothTextFiledWidgetState();
}

class _BothTextFiledWidgetState extends State<BothTextFiledWidget> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFiledWithLabel(
          label: 'EMAIL ADDRESS',
          hintText: 'name@example.com',
          controller: _emailController,
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'PASSWORD',
          obscureText: true,
          hintText: '••••••••',
          controller: _passwordController,
        ),
      ],
    );
  }
}
