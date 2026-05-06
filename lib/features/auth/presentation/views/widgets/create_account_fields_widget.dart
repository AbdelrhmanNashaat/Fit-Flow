import 'package:fit_flow/core/utils/app_validators.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/text_field_with_label.dart';
import 'package:flutter/material.dart';

class CreateAccountFieldsWidget extends StatefulWidget {
  const CreateAccountFieldsWidget({
    super.key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  State<CreateAccountFieldsWidget> createState() =>
      _CreateAccountFieldsWidgetState();
}

class _CreateAccountFieldsWidgetState extends State<CreateAccountFieldsWidget> {
  late final FocusNode _nameFocusNode;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;
  late final FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithLabel(
            label: 'FULL NAME',
            hintText: 'John Doe',
            keyboardType: TextInputType.name,
            controller: widget.nameController,
            focusNode: _nameFocusNode,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_emailFocusNode),
            validator: AppValidators.validateName,
          ),
          const SizedBox(height: 16),
          TextFieldWithLabel(
            label: 'EMAIL ADDRESS',
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
          TextFieldWithLabel(
            label: 'PASSWORD',
            obscureText: true,
            hintText: '••••••••',
            keyboardType: TextInputType.visiblePassword,
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
            validator: AppValidators.validatePassword,
          ),
          const SizedBox(height: 16),
          TextFieldWithLabel(
            label: 'CONFIRM PASSWORD',
            obscureText: true,
            hintText: '••••••••',
            keyboardType: TextInputType.visiblePassword,
            controller: widget.confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            validator: (value) => AppValidators.confirmPasswordValidator(
              widget.passwordController.text,
            )(value),
          ),
        ],
      ),
    );
  }
}
