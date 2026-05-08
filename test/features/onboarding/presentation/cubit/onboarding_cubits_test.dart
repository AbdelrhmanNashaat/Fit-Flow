import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/complete_onboarding_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_draft_cubit.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/onboarding_draft_state.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:fit_flow/features/workout/domain/repo/current_workout_plan_repo.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUserProfileRepo extends Mock implements UserProfileRepo {}

class _MockWorkoutRepo extends Mock implements WorkoutRepo {}

class _MockCurrentWorkoutPlanRepo extends Mock
    implements CurrentWorkoutPlanRepo {}

void main() {
  late UserProfileRepo userProfileRepo;
  late WorkoutRepo workoutRepo;
  late CurrentWorkoutPlanRepo currentWorkoutPlanRepo;

  const generatedPlan = WorkoutPlanModel(
    id: 'getStrong_3_day_plan',
    name: 'Strength Focus Split',
    days: [
      WorkoutDayModel(name: 'Push', workoutDays: [1], exercises: []),
      WorkoutDayModel(name: 'Pull', workoutDays: [3], exercises: []),
      WorkoutDayModel(name: 'Legs', workoutDays: [5], exercises: []),
    ],
  );

  setUp(() {
    userProfileRepo = _MockUserProfileRepo();
    workoutRepo = _MockWorkoutRepo();
    currentWorkoutPlanRepo = _MockCurrentWorkoutPlanRepo();
  });

  group('OnboardingDraftCubit', () {
    blocTest<OnboardingDraftCubit, OnboardingDraftState>(
      'emits updated goal and keeps selected day count',
      build: OnboardingDraftCubit.new,
      act: (cubit) => cubit.selectGoal(OnboardingGoal.buildMuscle),
      expect: () => [
        isA<OnboardingDraftReady>()
            .having(
              (state) => state.selectedGoal,
              'selectedGoal',
              OnboardingGoal.buildMuscle,
            )
            .having((state) => state.selectedDays, 'selectedDays', 3),
      ],
    );

    blocTest<OnboardingDraftCubit, OnboardingDraftState>(
      'emits updated availability and keeps selected goal',
      build: OnboardingDraftCubit.new,
      act: (cubit) => cubit.selectAvailabilityDays(5),
      expect: () => [
        isA<OnboardingDraftReady>()
            .having(
              (state) => state.selectedGoal,
              'selectedGoal',
              OnboardingGoal.getStrong,
            )
            .having((state) => state.selectedDays, 'selectedDays', 5),
      ],
    );
  });

  group('CompleteOnboardingCubit', () {
    blocTest<CompleteOnboardingCubit, CompleteOnboardingState>(
      'saves generated current plan and updates profile on success',
      build: () {
        when(
          () => workoutRepo.generatePlan(
            goal: OnboardingGoal.getStrong,
            selectedDays: 3,
          ),
        ).thenReturn(generatedPlan);
        when(
          () => currentWorkoutPlanRepo.saveCurrentPlan('user-1', generatedPlan),
        ).thenAnswer((_) async => const Right(null));
        when(
          () => userProfileRepo.updateProfile('user-1', {
            'myGoal': OnboardingGoal.getStrong.name,
            'weeklyAvailability': 3,
            'isOnboardingCompleted': true,
          }),
        ).thenAnswer((_) async => const Right(null));

        return CompleteOnboardingCubit(
          userProfileRepo,
          workoutRepo,
          currentWorkoutPlanRepo,
        );
      },
      act: (cubit) => cubit.completeOnboarding(
        uid: 'user-1',
        goal: OnboardingGoal.getStrong,
        selectedDays: 3,
      ),
      expect: () => [
        isA<CompleteOnboardingLoading>(),
        isA<CompleteOnboardingSuccess>(),
      ],
      verify: (_) {
        verify(
          () => currentWorkoutPlanRepo.saveCurrentPlan('user-1', generatedPlan),
        ).called(1);
        verify(
          () => userProfileRepo.updateProfile('user-1', {
            'myGoal': OnboardingGoal.getStrong.name,
            'weeklyAvailability': 3,
            'isOnboardingCompleted': true,
          }),
        ).called(1);
      },
    );

    blocTest<CompleteOnboardingCubit, CompleteOnboardingState>(
      'fails fast when current plan cannot be saved',
      build: () {
        when(
          () => workoutRepo.generatePlan(
            goal: OnboardingGoal.generalFitness,
            selectedDays: 4,
          ),
        ).thenReturn(generatedPlan);
        when(
          () => currentWorkoutPlanRepo.saveCurrentPlan('user-1', generatedPlan),
        ).thenAnswer(
          (_) async => const Left(Failure('Plan persistence failed')),
        );

        return CompleteOnboardingCubit(
          userProfileRepo,
          workoutRepo,
          currentWorkoutPlanRepo,
        );
      },
      act: (cubit) => cubit.completeOnboarding(
        uid: 'user-1',
        goal: OnboardingGoal.generalFitness,
        selectedDays: 4,
      ),
      expect: () => [
        isA<CompleteOnboardingLoading>(),
        isA<CompleteOnboardingFailure>().having(
          (state) => state.message,
          'message',
          'Plan persistence failed',
        ),
      ],
      verify: (_) {
        verifyNever(() => userProfileRepo.updateProfile(any(), any()));
      },
    );
  });
}
