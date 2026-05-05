import 'package:fit_flow/core/widgets/custom_button.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_state.dart';
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
            _emailController.text.trim(),
            _passwordController.text,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state is SignUpFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return AuthContainerParentWidget(
          child: Column(
            children: [
              CreateAccountFieldsWidget(
                formKey: _formKey,
                nameController: _nameController,
                emailController: _emailController,
                passwordController: _passwordController,
                confirmPasswordController: _confirmPasswordController,
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Create Account',
                onPressed: _onSubmit,
                isLoading: state is SignUpLoading,
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
