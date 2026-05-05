import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_cubit.dart';
import 'package:fit_flow/features/auth/presentation/views/widgets/create_account_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateAccountView extends StatelessWidget {
  const CreateAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(getIt<AuthRepo>()),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(child: CreateAccountViewBody()),
      ),
    );
  }
}
