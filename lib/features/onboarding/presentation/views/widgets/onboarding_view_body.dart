import 'package:fit_flow/features/auth/presentation/cubit/auth_session_cubit.dart';
import 'package:fit_flow/features/auth/presentation/cubit/auth_session_state.dart';
import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/complete_onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_availability_section.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_footer_section.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_goal_section.dart';
import 'package:fit_flow/features/onboarding/presentation/views/widgets/onboarding_header_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingViewBody extends StatefulWidget {
  const OnboardingViewBody({super.key});

  @override
  State<OnboardingViewBody> createState() => _OnboardingViewBodyState();
}

class _OnboardingViewBodyState extends State<OnboardingViewBody> {
  late final ValueNotifier<OnboardingGoal> _selectedGoalNotifier;

  late final ValueNotifier<int> _selectedDaysNotifier;
  void _onContinue() {
    final authState = context.read<AuthSessionCubit>().state;
    if (authState is AuthSessionNeedsOnboarding) {
      context.read<CompleteOnboardingCubit>().completeOnboarding(
        uid: authState.user.id,
        goal: _selectedGoalNotifier.value,
        selectedDays: _selectedDaysNotifier.value,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedGoalNotifier = ValueNotifier(OnboardingGoal.getStrong);
    _selectedDaysNotifier = ValueNotifier(3);
  }

  @override
  void dispose() {
    _selectedGoalNotifier.dispose();
    _selectedDaysNotifier.dispose();
    super.dispose();
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
                      ValueListenableBuilder<OnboardingGoal>(
                        valueListenable: _selectedGoalNotifier,
                        builder: (_, selectedGoal, _) {
                          return OnboardingGoalSection(
                            selectedGoal: selectedGoal,
                            onGoalSelected: (goal) {
                              _selectedGoalNotifier.value = goal;
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 28),
                      ValueListenableBuilder<int>(
                        valueListenable: _selectedDaysNotifier,
                        builder: (_, selectedDays, _) {
                          return OnboardingAvailabilitySection(
                            selectedDays: selectedDays,
                            onSelected: (days) {
                              _selectedDaysNotifier.value = days;
                            },
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
                            onContinue: _onContinue,
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
