import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/workout/data/repo/local_workout_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LocalWorkoutRepo.generatePlan', () {
    const repo = LocalWorkoutRepo();

    test(
      'creates a plan with one scheduled day per requested availability',
      () {
        final plan = repo.generatePlan(
          goal: OnboardingGoal.buildMuscle,
          selectedDays: 4,
        );

        expect(plan.id, 'buildMuscle_4_day_plan');
        expect(plan.days, hasLength(4));
        expect(
          plan.days.expand((day) => day.workoutDays),
          orderedEquals([1, 2, 4, 6]),
        );
      },
    );

    test('adjusts reps down for strength-focused plans', () {
      final plan = repo.generatePlan(
        goal: OnboardingGoal.getStrong,
        selectedDays: 3,
      );

      expect(plan.name, 'Strength Focus Split');
      expect(plan.days.first.exercises.first.defaultReps, '6');
    });
  });
}
