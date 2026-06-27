import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/onboarding/presentation/cubit/complete_onboarding_cubit.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockUserProfileRepo extends Mock implements UserProfileRepo {}

void main() {
  late UserProfileRepo userProfileRepo;

  setUp(() {
    userProfileRepo = _MockUserProfileRepo();
  });

  group('CompleteOnboardingCubit', () {
    blocTest<CompleteOnboardingCubit, CompleteOnboardingState>(
      'updates profile on success',
      build: () {
        when(
          () => userProfileRepo.updateProfile('user-1', {
            'myGoal': OnboardingGoal.getStrong.name,
            'weeklyAvailability': 3,
            'isOnboardingCompleted': true,
          }),
        ).thenAnswer((_) async => const Right(null));

        return CompleteOnboardingCubit(
          userProfileRepo,
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
          () => userProfileRepo.updateProfile('user-1', {
            'myGoal': OnboardingGoal.getStrong.name,
            'weeklyAvailability': 3,
            'isOnboardingCompleted': true,
          }),
        ).called(1);
      },
    );

    blocTest<CompleteOnboardingCubit, CompleteOnboardingState>(
      'emits failure when profile update fails',
      build: () {
        when(
          () => userProfileRepo.updateProfile('user-1', {
            'myGoal': OnboardingGoal.generalFitness.name,
            'weeklyAvailability': 4,
            'isOnboardingCompleted': true,
          }),
        ).thenAnswer(
          (_) async => const Left(Failure('Update failed')),
        );

        return CompleteOnboardingCubit(
          userProfileRepo,
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
          'Update failed',
        ),
      ],
    );
  });
}
