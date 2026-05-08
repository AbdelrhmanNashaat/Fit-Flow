part of 'complete_onboarding_cubit.dart';

sealed class CompleteOnboardingState {
  const CompleteOnboardingState();
}

final class CompleteOnboardingIdle extends CompleteOnboardingState {
  const CompleteOnboardingIdle();
}

final class CompleteOnboardingLoading extends CompleteOnboardingState {
  const CompleteOnboardingLoading();
}

final class CompleteOnboardingSuccess extends CompleteOnboardingState {
  const CompleteOnboardingSuccess();
}

final class CompleteOnboardingFailure extends CompleteOnboardingState {
  const CompleteOnboardingFailure(this.message);

  final String message;
}
