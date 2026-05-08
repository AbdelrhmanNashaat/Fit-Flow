enum OnboardingGoal { buildMuscle, getStrong, generalFitness }

sealed class OnboardingState {
  const OnboardingState();
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({
    this.selectedGoal = OnboardingGoal.getStrong,
    this.selectedDays = 3,
  });
  final OnboardingGoal selectedGoal;
  final int selectedDays;

  OnboardingInitial copyWith({
    OnboardingGoal? selectedGoal,
    int? selectedDays,
  }) => OnboardingInitial(
    selectedGoal: selectedGoal ?? this.selectedGoal,
    selectedDays: selectedDays ?? this.selectedDays,
  );
}

final class OnboardingLoading extends OnboardingState {
  const OnboardingLoading();
}

final class OnboardingSuccess extends OnboardingState {
  const OnboardingSuccess();
}

final class OnboardingFailure extends OnboardingState {
  const OnboardingFailure(this.message);
  final String message;
}
