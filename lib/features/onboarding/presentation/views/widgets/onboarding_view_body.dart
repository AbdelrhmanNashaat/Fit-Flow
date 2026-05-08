import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/complete_onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_draft_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_draft_state.dart';
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
    final draftState = context.read<OnboardingDraftCubit>().state;
    if (authState is AuthSessionNeedsOnboarding) {
      context.read<CompleteOnboardingCubit>().completeOnboarding(
        uid: authState.user.id,
        goal: draftState.selectedGoal,
        selectedDays: draftState.selectedDays,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompleteOnboardingCubit, CompleteOnboardingState>(
      listenWhen: (_, curr) =>
          curr is CompleteOnboardingSuccess ||
          curr is CompleteOnboardingFailure,
      listener: (context, state) {
        if (state is CompleteOnboardingSuccess) {
          final authState = context.read<AuthSessionCubit>().state;
          if (authState is AuthSessionNeedsOnboarding) {
            context.read<AuthSessionCubit>().setOnboardingCompleted(
              authState.user,
            );
          }
        }
        if (state is CompleteOnboardingFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message)));
          context.read<CompleteOnboardingCubit>().reset();
        }
      },
      child: CustomScrollView(
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
                      BlocSelector<
                        OnboardingDraftCubit,
                        OnboardingDraftState,
                        OnboardingGoal
                      >(
                        selector: (state) => state.selectedGoal,
                        builder: (context, selectedGoal) {
                          return OnboardingGoalSection(
                            selectedGoal: selectedGoal,
                            onGoalSelected: context
                                .read<OnboardingDraftCubit>()
                                .selectGoal,
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      BlocSelector<
                        OnboardingDraftCubit,
                        OnboardingDraftState,
                        int
                      >(
                        selector: (state) => state.selectedDays,
                        builder: (context, selectedDays) {
                          return OnboardingAvailabilitySection(
                            selectedDays: selectedDays,
                            onSelected: context
                                .read<OnboardingDraftCubit>()
                                .selectAvailabilityDays,
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocSelector<
                        CompleteOnboardingCubit,
                        CompleteOnboardingState,
                        bool
                      >(
                        selector: (state) => state is CompleteOnboardingLoading,
                        builder: (context, isLoading) {
                          return OnboardingFooterSection(
                            isLoading: isLoading,
                            onContinue: () => _onContinue(context),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
