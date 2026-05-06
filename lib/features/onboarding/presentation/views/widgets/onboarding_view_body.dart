import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_availability_section.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_footer_section.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_goal_section.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingViewBody extends StatelessWidget {
  const OnboardingViewBody({super.key});

  void _onContinue(BuildContext context) {
    final authState = context.read<AuthSessionCubit>().state;
    if (authState is AuthSessionNeedsOnboarding) {
      context.read<OnboardingCubit>().completeOnboarding(authState.user.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (prev, curr) => curr.status != prev.status,
      listener: (context, state) {
        if (state.status == OnboardingStatus.success) {
          final authState = context.read<AuthSessionCubit>().state;
          if (authState is AuthSessionNeedsOnboarding) {
            context.read<AuthSessionCubit>().setOnboardingCompleted(
              authState.user,
            );
          }
        }
      },
      builder: (context, state) {
        final cubit = context.read<OnboardingCubit>();
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const OnboardingHeaderSection(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        OnboardingGoalSection(
                          selectedGoal: state.selectedGoal,
                          onGoalSelected: cubit.selectGoal,
                        ),
                        const SizedBox(height: 28),
                        OnboardingAvailabilitySection(
                          selectedDays: state.selectedAvailabilityDays,
                          onSelected: cubit.selectAvailabilityDays,
                        ),
                        const SizedBox(height: 24),
                        OnboardingFooterSection(
                          isLoading: state.status == OnboardingStatus.loading,
                          onContinue: () => _onContinue(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
