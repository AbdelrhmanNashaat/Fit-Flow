import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';

sealed class OnboardingDraftState {
  const OnboardingDraftState({
    required this.selectedGoal,
    required this.selectedDays,
  });

  final OnboardingGoal selectedGoal;
  final int selectedDays;
}

final class OnboardingDraftReady extends OnboardingDraftState {
  const OnboardingDraftReady({
    super.selectedGoal = OnboardingGoal.getStrong,
    super.selectedDays = 3,
  });
}
