import 'package:fit_flow/core/l10n/app_localizations.dart';
import 'package:fit_flow/core/widgets/animated_error_banner.dart';
import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_state.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/both_text_filed_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/forget_pass_button.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/or_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/row_of_sign_in_options_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAuthSection extends StatefulWidget {
  const MainAuthSection({super.key});

  @override
  State<MainAuthSection> createState() => _MainAuthSectionState();
}

class _MainAuthSectionState extends State<MainAuthSection> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SignInCubit>().signIn(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (_, current) => current is SignInSuccess,
      listener: (context, state) {
        context.read<AuthSessionCubit>().setAuthenticated(
          (state as SignInSuccess).user,
        );
      },
      child: AuthContainerParentWidget(
        child: Column(
          children: [
            BlocSelector<SignInCubit, SignInState, String?>(
              selector: (state) =>
                  state is SignInFailure ? state.message : null,
              builder: (context, errorMessage) => AnimatedErrorBanner(
                message: errorMessage,
                onDismiss: () => context.read<SignInCubit>().clearError(),
              ),
            ),
            BlocSelector<SignInCubit, SignInState, (String?, String?)>(
              selector: (state) => state is SignInFieldFailure
                  ? (state.emailError, state.passwordError)
                  : (null, null),
              builder: (context, fieldErrors) {
                final (emailError, passwordError) = fieldErrors;

                return BothTextFiledWidget(
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  emailErrorText: emailError,
                  passwordErrorText: passwordError,
                  onEmailChanged: (_) =>
                      context.read<SignInCubit>().clearError(),
                  onPasswordChanged: (_) =>
                      context.read<SignInCubit>().clearError(),
                );
              },
            ),
            const SizedBox(height: 6),
            const ForgetPassButton(),
            const SizedBox(height: 12),
            BlocSelector<SignInCubit, SignInState, bool>(
              selector: (state) => state is SignInLoading && !state.isGoogle,
              builder: (context, isLoading) {
                return CustomButton(
                  text: l10n.signIn,
                  onPressed: _onSubmit,
                  isLoading: isLoading,
                );
              },
            ),
            const SizedBox(height: 12),
            const OrWidget(),
            const SizedBox(height: 12),
            const RowOFSignInOptionsButtons(),
          ],
        ),
      ),
    );
  }
}
