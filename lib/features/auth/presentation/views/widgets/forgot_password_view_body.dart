import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/utils/app_validators.dart';
import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/core/widgets/error_banner.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_state.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/text_field_with_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context
          .read<ResetPasswordCubit>()
          .resetPassword(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 28),
          const Text('Forgot Password?', style: AppTextStyles.extraBold26),
          const SizedBox(height: 8),
          Text(
            'Enter the email linked to your account\nand we\'ll send you a reset link.',
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.orTextColor,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 28),
          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
            buildWhen: (previous, current) =>
                (previous is ResetPasswordSuccess) !=
                (current is ResetPasswordSuccess),
            builder: (context, state) {
              if (state is ResetPasswordSuccess) {
                return const _SuccessCard();
              }
              return AuthContainerParentWidget(
                child: Column(
                  children: [
                    BlocSelector<ResetPasswordCubit, ResetPasswordState,
                        String?>(
                      selector: (s) =>
                          s is ResetPasswordFailure ? s.message : null,
                      builder: (context, errorMessage) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 280),
                          transitionBuilder: (child, animation) =>
                              FadeTransition(
                            opacity: animation,
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, -0.25),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            ),
                          ),
                          child: errorMessage != null
                              ? Padding(
                                  key: ValueKey(errorMessage),
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: ErrorBanner(
                                    message: errorMessage,
                                    onDismiss: () => context
                                        .read<ResetPasswordCubit>()
                                        .clearError(),
                                  ),
                                )
                              : const SizedBox.shrink(
                                  key: ValueKey('no-error'),
                                ),
                        );
                      },
                    ),
                    Form(
                      key: _formKey,
                      child: TextFieldWithLabel(
                        label: 'Email Address',
                        hintText: 'name@example.com',
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) => _onSubmit(),
                        validator: AppValidators.validateEmail,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocSelector<ResetPasswordCubit, ResetPasswordState, bool>(
                      selector: (s) => s is ResetPasswordLoading,
                      builder: (context, isLoading) {
                        return CustomButton(
                          text: 'Send Reset Link',
                          onPressed: _onSubmit,
                          isLoading: isLoading,
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF86EFAC), width: 0.8),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.mark_email_read_outlined,
            size: 48,
            color: Color(0xFF16A34A),
          ),
          const SizedBox(height: 12),
          Text(
            'Check Your Inbox',
            style: AppTextStyles.bold18.copyWith(
              color: const Color(0xFF16A34A),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "If an account exists for this email, you'll receive a password reset link shortly.",
            textAlign: TextAlign.center,
            style: AppTextStyles.medium14.copyWith(
              color: const Color(0xFF15803D),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              'Back to Sign In',
              style: AppTextStyles.medium14.copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
