import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._userProfileRepo) : super(const OnboardingInitial());

  final UserProfileRepo _userProfileRepo;

  void selectGoal(OnboardingGoal goal) {
    final current = state;
    if (current is! OnboardingInitial) return;
    emit(current.copyWith(selectedGoal: goal));
  }

  void selectAvailabilityDays(int days) {
    final current = state;
    if (current is! OnboardingInitial) return;
    emit(current.copyWith(selectedDays: days));
  }

  Future<void> completeOnboarding(String uid) async {
    final current = state;
    if (current is! OnboardingInitial) return;

    emit(const OnboardingLoading());

    final result = await _userProfileRepo.updateProfile(uid, {
      'myGoal': current.selectedGoal.name,
      'weeklyAvailability': current.selectedDays,
      'isOnboardingCompleted': true,
    });

    result.fold(
      (failure) => emit(OnboardingFailure(failure.message)),
      (_) => emit(const OnboardingSuccess()),
    );
  }
}
