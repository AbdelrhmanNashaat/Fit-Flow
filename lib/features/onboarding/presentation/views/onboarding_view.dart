import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/complete_onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CompleteOnboardingCubit(getIt<UserProfileRepo>()),
      child: const Scaffold(body: SafeArea(child: OnboardingViewBody())),
    );
  }
}
