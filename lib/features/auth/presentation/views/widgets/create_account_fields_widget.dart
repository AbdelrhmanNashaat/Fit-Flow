import 'package:fit_flow/features/auth/presentation/views/widgets/text_filed_with_label.dart';
import 'package:flutter/material.dart';

class CreateAccountFieldsWidget extends StatefulWidget {
  const CreateAccountFieldsWidget({super.key});

  @override
  State<CreateAccountFieldsWidget> createState() =>
      _CreateAccountFieldsWidgetState();
}

class _CreateAccountFieldsWidgetState extends State<CreateAccountFieldsWidget> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFiledWithLabel(
          label: 'FULL NAME',
          hintText: 'John Doe',
          controller: _nameController,
          focusNode: _nameFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_emailFocusNode),
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'EMAIL ADDRESS',
          hintText: 'name@example.com',
          controller: _emailController,
          focusNode: _emailFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_passwordFocusNode),
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'PASSWORD',
          obscureText: true,
          hintText: '••••••••',
          controller: _passwordController,
          focusNode: _passwordFocusNode,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
        ),
        const SizedBox(height: 16),
        TextFiledWithLabel(
          label: 'CONFIRM PASSWORD',
          obscureText: true,
          hintText: '••••••••',
          controller: _confirmPasswordController,
          focusNode: _confirmPasswordFocusNode,
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
        ),
      ],
    );
  }
}
