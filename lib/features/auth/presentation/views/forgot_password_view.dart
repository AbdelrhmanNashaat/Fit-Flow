import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/reset_password_cubit.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/forgot_password_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(getIt<AuthRepo>()),
      child: const Scaffold(body: SafeArea(child: ForgotPasswordViewBody())),
    );
  }
}
