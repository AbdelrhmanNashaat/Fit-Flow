import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:fit_flow/features/workout/domain/repo/current_workout_plan_repo.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'complete_onboarding_state.dart';

class CompleteOnboardingCubit extends Cubit<CompleteOnboardingState> {
  CompleteOnboardingCubit(
    this._userProfileRepo,
    this._workoutRepo,
    this._currentWorkoutPlanRepo,
  ) : super(const CompleteOnboardingIdle());

  final UserProfileRepo _userProfileRepo;
  final WorkoutRepo _workoutRepo;
  final CurrentWorkoutPlanRepo _currentWorkoutPlanRepo;

  Future<void> completeOnboarding({
    required String uid,
    required OnboardingGoal goal,
    required int selectedDays,
  }) async {
    emit(const CompleteOnboardingLoading());

    final plan = _workoutRepo.generatePlan(
      goal: goal,
      selectedDays: selectedDays,
    );

    final planResult = await _currentWorkoutPlanRepo.saveCurrentPlan(uid, plan);
    await planResult.fold(
      (failure) async => emit(CompleteOnboardingFailure(failure.message)),
      (_) async {},
    );
    if (state is CompleteOnboardingFailure) {
      return;
    }

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
