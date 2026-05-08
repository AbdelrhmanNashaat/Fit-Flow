import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_validators.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/text_field_with_label.dart';
import 'package:flutter/material.dart';

class BothTextFiledWidget extends StatefulWidget {
  const BothTextFiledWidget({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    this.emailErrorText,
    this.passwordErrorText,
    this.onEmailChanged,
    this.onPasswordChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final String? emailErrorText;
  final String? passwordErrorText;
  final ValueChanged<String>? onEmailChanged;
  final ValueChanged<String>? onPasswordChanged;

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
    final l10n = context.l10n;

    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldWithLabel(
            label: l10n.emailAddressLabel,
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
            label: l10n.passwordLabel,
            obscureText: true,
            hintText: '••••••••',
            errorText: widget.passwordErrorText,
            keyboardType: TextInputType.visiblePassword,
            controller: widget.passwordController,
            focusNode: _passwordFocusNode,
            onChanged: widget.onPasswordChanged,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => FocusScope.of(context).unfocus(),
            validator: (value) => AppValidators.validatePassword(value, l10n),
          ),
        ],
      ),
    );
  }
}
