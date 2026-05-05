import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/core/widgets/error_banner.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_state.dart';
import 'package:fit_flow/features/splash/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/auth_container_parent_widget.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_fields_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountMainSection extends StatefulWidget {
  const CreateAccountMainSection({super.key});

  @override
  State<CreateAccountMainSection> createState() =>
      _CreateAccountMainSectionState();
}

class _CreateAccountMainSectionState extends State<CreateAccountMainSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<SignUpCubit>().signUp(
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (_, current) => current is SignUpSuccess,
      listener: (context, state) {
        context.read<AuthSessionCubit>().setAuthenticated(
          (state as SignUpSuccess).user,
        );
      },
      child: AuthContainerParentWidget(
        child: Column(
          children: [
            BlocSelector<SignUpCubit, SignUpState, String?>(
              selector: (state) =>
                  state is SignUpFailure ? state.message : null,
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
                                context.read<SignUpCubit>().clearError(),
                          ),
                        )
                      : const SizedBox.shrink(key: ValueKey('no-error')),
                );
              },
            ),
            CreateAccountFieldsWidget(
              formKey: _formKey,
              nameController: _nameController,
              emailController: _emailController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
            ),
            const SizedBox(height: 16),
            BlocSelector<SignUpCubit, SignUpState, bool>(
              selector: (state) => state is SignUpLoading,
              builder: (context, isLoading) {
                return CustomButton(
                  text: 'Create Account',
                  onPressed: _onSubmit,
                  isLoading: isLoading,
                );
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
