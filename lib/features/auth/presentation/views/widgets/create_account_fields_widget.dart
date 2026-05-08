import 'package:fit_flow/core/l10n/app_localizations.dart';
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
    this.nameErrorText,
    this.emailErrorText,
    this.passwordErrorText,
    this.confirmPasswordErrorText,
    this.onNameChanged,
    this.onEmailChanged,
    this.onPasswordChanged,
    this.onConfirmPasswordChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? nameErrorText;
  final String? emailErrorText;
  final String? passwordErrorText;
  final String? confirmPasswordErrorText;
  final ValueChanged<String>? onNameChanged;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onPasswordChanged;
  final ValueChanged<String>? onConfirmPasswordChanged;

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
    final l10n = context.l10n;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithLabel(
            label: l10n.fullNameLabel.toUpperCase(),
            hintText: 'John Doe',
            errorText: widget.nameErrorText,
            keyboardType: TextInputType.name,
            controller: widget.nameController,
            focusNode: _nameFocusNode,
            onChanged: widget.onNameChanged,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_emailFocusNode),
            validator: (value) => AppValidators.validateName(value, l10n),
          ),
          const SizedBox(height: 16),
          TextFieldWithLabel(
            label: l10n.emailAddressLabel.toUpperCase(),
            hintText: 'name@example.com',
            errorText: widget.emailErrorText,
            keyboardType: TextInputType.emailAddress,
            controller: widget.emailController,
            focusNode: _emailFocusNode,
            onChanged: widget.onEmailChanged,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_passwordFocusNode),
            validator: (value) => AppValidators.validateEmail(value, l10n),
          ),
          const SizedBox(height: 16),
          TextFieldWithLabel(
            label: l10n.passwordLabel.toUpperCase(),
            obscureText: true,
            hintText: '••••••••',
            errorText: widget.passwordErrorText,
            keyboardType: TextInputType.visiblePassword,
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            onChanged: widget.onPasswordChanged,
            textInputAction: TextInputAction.next,
            onFieldSubmitted: (_) =>
                FocusScope.of(context).requestFocus(_confirmPasswordFocusNode),
            validator: (value) => AppValidators.validatePassword(value, l10n),
          ),
          const SizedBox(height: 16),
          TextFieldWithLabel(
            label: l10n.confirmPasswordLabel.toUpperCase(),
            obscureText: true,
            hintText: '••••••••',
            errorText: widget.confirmPasswordErrorText,
            keyboardType: TextInputType.visiblePassword,
            controller: widget.confirmPasswordController,
            focusNode: _confirmPasswordFocusNode,
            onChanged: widget.onConfirmPasswordChanged,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            validator: (value) => AppValidators.confirmPasswordValidator(
              widget.passwordController.text,
              l10n,
            )(value),
          ),
        ],
      ),
    );
  }
}
