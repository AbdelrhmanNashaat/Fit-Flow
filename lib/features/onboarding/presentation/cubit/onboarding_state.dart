enum OnboardingGoal { buildMuscle, getStrong, generalFitness }

class OnboardingState {
  const OnboardingState({
    this.selectedGoal = OnboardingGoal.getStrong,
    this.selectedAvailabilityDays = 3,
  });

  final OnboardingGoal selectedGoal;
  final int selectedAvailabilityDays;

  OnboardingState copyWith({
    OnboardingGoal? selectedGoal,
    int? selectedAvailabilityDays,
  }) {
    return OnboardingState(
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedAvailabilityDays:
          selectedAvailabilityDays ?? this.selectedAvailabilityDays,
    );
  }
}
