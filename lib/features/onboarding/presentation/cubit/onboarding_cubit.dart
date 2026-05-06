import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._userProfileRepo) : super(const OnboardingState());

  final UserProfileRepo _userProfileRepo;

  void selectGoal(OnboardingGoal goal) {
    emit(state.copyWith(selectedGoal: goal));
  }

  void selectAvailabilityDays(int days) {
    emit(state.copyWith(selectedAvailabilityDays: days));
  }

  Future<void> completeOnboarding(String uid) async {
    emit(state.copyWith(status: OnboardingStatus.loading));

    final result = await _userProfileRepo.updateProfile(uid, {
      'myGoal': state.selectedGoal.name,
      'weeklyAvailability': state.selectedAvailabilityDays,
      'isOnboardingCompleted': true,
    });

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: OnboardingStatus.failure,
          errorMessage: failure.message,
        ),
      ),
      (_) => emit(state.copyWith(status: OnboardingStatus.success)),
    );
  }
}
