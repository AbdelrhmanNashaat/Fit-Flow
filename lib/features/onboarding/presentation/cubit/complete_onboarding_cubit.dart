import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'complete_onboarding_state.dart';

class CompleteOnboardingCubit extends Cubit<CompleteOnboardingState> {
  CompleteOnboardingCubit(
    this._userProfileRepo,
  ) : super(const CompleteOnboardingIdle());

  final UserProfileRepo _userProfileRepo;

  Future<void> completeOnboarding({
    required String uid,
    required OnboardingGoal goal,
    required int selectedDays,
  }) async {
    emit(const CompleteOnboardingLoading());

    final result = await _userProfileRepo.updateProfile(uid, {
      'myGoal': goal.name,
      'weeklyAvailability': selectedDays,
      'isOnboardingCompleted': true,
    });

    result.fold(
      (failure) => emit(CompleteOnboardingFailure(failure.message)),
      (_) => emit(const CompleteOnboardingSuccess()),
    );
  }

  void reset() {
    if (state is CompleteOnboardingIdle) {
      return;
    }

    emit(const CompleteOnboardingIdle());
  }
}
