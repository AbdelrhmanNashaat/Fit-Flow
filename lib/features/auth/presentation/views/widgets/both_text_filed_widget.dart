import 'package:fit_flow/core/utils/app_validators.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/text_filed_with_label.dart';
import 'package:flutter/material.dart';

class BothTextFiledWidget extends StatefulWidget {
  const BothTextFiledWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  State<BothTextFiledWidget> createState() => _BothTextFiledWidgetState();
}

class _BothTextFiledWidgetState extends State<BothTextFiledWidget> {
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFiledWithLabel(
            label: 'Email Address',
            hintText: 'name@example.com',
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
            focusNode: _emailFocusNode,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_passwordFocusNode),
            validator: AppValidators.validateEmail,
          ),
          const SizedBox(height: 16),
          TextFiledWithLabel(
            label: 'Password',
            obscureText: true,
            hintText: '••••••••',
            keyboardType: TextInputType.visiblePassword,
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            validator: AppValidators.validatePassword,
          ),
        ],
      ),
    );
  }
}
