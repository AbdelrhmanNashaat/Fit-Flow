import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: const Scaffold(body: SafeArea(child: OnboardingViewBody())),
    );
  }
}
