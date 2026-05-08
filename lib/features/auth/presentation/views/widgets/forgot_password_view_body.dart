import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/utils/app_colors.dart';
import 'package:fit_flow/core/utils/app_text_styles.dart';
import 'package:fit_flow/core/utils/app_validators.dart';
import 'package:fit_flow/core/widgets/animated_error_banner.dart';
import 'package:fit_flow/core/widgets/custom_button.dart';
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
      context.read<ResetPasswordCubit>().resetPassword(
        _emailController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
          Text(
            l10n.forgotPassword,
            style: AppTextStyles.extraBold26.copyWith(
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.forgotPasswordDescription,
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
                    BlocSelector<
                      ResetPasswordCubit,
                      ResetPasswordState,
                      String?
                    >(
                      selector: (s) =>
                          s is ResetPasswordFailure ? s.message : null,
                      builder: (context, errorMessage) => AnimatedErrorBanner(
                        message: errorMessage,
                        onDismiss: () =>
                            context.read<ResetPasswordCubit>().clearError(),
                      ),
                    ),
                    BlocSelector<
                      ResetPasswordCubit,
                      ResetPasswordState,
                      String?
                    >(
                      selector: (state) => state is ResetPasswordFieldFailure
                          ? state.emailError
                          : null,
                      builder: (context, emailError) {
                        return Form(
                          key: _formKey,
                          child: TextFieldWithLabel(
                            label: l10n.emailAddressLabel,
                            hintText: 'name@example.com',
                            errorText: emailError,
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                            textInputAction: TextInputAction.done,
                            onChanged: (_) =>
                                context.read<ResetPasswordCubit>().clearError(),
                            onFieldSubmitted: (_) => _onSubmit(),
                            validator: (value) =>
                                AppValidators.validateEmail(value, l10n),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    BlocSelector<ResetPasswordCubit, ResetPasswordState, bool>(
                      selector: (s) => s is ResetPasswordLoading,
                      builder: (context, isLoading) {
                        return CustomButton(
                          text: l10n.sendResetLink,
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
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.successBorder, width: 0.8),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.mark_email_read_outlined,
            size: 48,
            color: AppColors.successText,
          ),
          const SizedBox(height: 12),
          Text(
            context.l10n.checkYourInbox,
            style: AppTextStyles.bold18.copyWith(color: AppColors.successText),
          ),
          const SizedBox(height: 8),
          Text(
            context.l10n.resetLinkSentBody,
            textAlign: TextAlign.center,
            style: AppTextStyles.medium14.copyWith(
              color: AppColors.successTextDark,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Text(
              context.l10n.backToSignIn,
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
