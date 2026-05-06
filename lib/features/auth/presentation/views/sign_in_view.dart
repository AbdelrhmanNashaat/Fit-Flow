import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_cubit.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/sign_in_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignInCubit(getIt<AuthRepo>()),
      child: const Scaffold(body: SafeArea(child: SignInViewBody())),
    );
  }
}
