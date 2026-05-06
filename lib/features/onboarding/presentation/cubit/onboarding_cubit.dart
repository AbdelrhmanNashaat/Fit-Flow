import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void selectGoal(OnboardingGoal goal) {
    emit(state.copyWith(selectedGoal: goal));
  }

  void selectAvailabilityDays(int days) {
    emit(state.copyWith(selectedAvailabilityDays: days));
  }
}
