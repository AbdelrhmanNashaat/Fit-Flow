enum OnboardingGoal { buildMuscle, getStrong, generalFitness }

enum OnboardingStatus { initial, loading, success, failure }

class OnboardingState {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.selectedGoal = OnboardingGoal.getStrong,
    this.selectedAvailabilityDays = 3,
    this.errorMessage,
  });

  final OnboardingStatus status;
  final OnboardingGoal selectedGoal;
  final int selectedAvailabilityDays;
  final String? errorMessage;

  OnboardingState copyWith({
    OnboardingStatus? status,
    OnboardingGoal? selectedGoal,
    int? selectedAvailabilityDays,
    String? errorMessage,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      selectedGoal: selectedGoal ?? this.selectedGoal,
      selectedAvailabilityDays:
          selectedAvailabilityDays ?? this.selectedAvailabilityDays,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
