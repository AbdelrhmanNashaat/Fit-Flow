import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/core/widgets/error_banner.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_state.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/both_text_filed_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/forget_pass_button.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/or_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/row_oF_sign_in_options_buttons.dart';
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
    return BlocListener<SignInCubit, SignInState>(
      listenWhen: (_, current) => current is SignInSuccess,
      listener: (context, state) {
        // TODO: navigate to home screen
      },
      child: AuthContainerParentWidget(
        child: Column(
          children: [
            BlocSelector<SignInCubit, SignInState, String?>(
              selector: (state) =>
                  state is SignInFailure ? state.message : null,
              builder: (context, errorMessage) {
                return AnimatedSwitcher(
                  duration: const Duration(milliseconds: 280),
                  transitionBuilder: (child, animation) => FadeTransition(
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
                            onDismiss: () =>
                                context.read<SignInCubit>().clearError(),
                          ),
                        )
                      : const SizedBox.shrink(key: ValueKey('no-error')),
                );
              },
            ),
            BothTextFiledWidget(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
            ),
            const SizedBox(height: 6),
            const ForgetPassButton(),
            const SizedBox(height: 12),
            BlocSelector<SignInCubit, SignInState, bool>(
              selector: (state) => state is SignInLoading,
              builder: (context, isLoading) {
                return CustomButton(
                  text: 'Sign In',
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
