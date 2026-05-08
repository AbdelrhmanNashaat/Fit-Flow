import 'package:fit_flow/core/service/service_locator.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/complete_onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_draft_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_view_body.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:fit_flow/features/workout/domain/repo/current_workout_plan_repo.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => OnboardingDraftCubit()),
        BlocProvider(
          create: (_) => CompleteOnboardingCubit(
            getIt<UserProfileRepo>(),
            getIt<WorkoutRepo>(),
            getIt<CurrentWorkoutPlanRepo>(),
          ),
        ),
      ],
      child: const Scaffold(body: SafeArea(child: OnboardingViewBody())),
    );
  }
}
