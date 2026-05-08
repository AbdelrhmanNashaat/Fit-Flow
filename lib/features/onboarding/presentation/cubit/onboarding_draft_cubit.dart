import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_draft_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingDraftCubit extends Cubit<OnboardingDraftState> {
  OnboardingDraftCubit() : super(const OnboardingDraftReady());

  void selectGoal(OnboardingGoal goal) {
    final current = state;
    emit(
      OnboardingDraftReady(
        selectedGoal: goal,
        selectedDays: current.selectedDays,
      ),
    );
  }

  void selectAvailabilityDays(int days) {
    final current = state;
    emit(
      OnboardingDraftReady(
        selectedGoal: current.selectedGoal,
        selectedDays: days,
      ),
    );
  }
}
