import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/workout/data/models/sample_workout_data.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';

class LocalWorkoutRepo implements WorkoutRepo {
  const LocalWorkoutRepo();

  @override
  WorkoutPlanModel generatePlan({
    required OnboardingGoal goal,
    required int selectedDays,
  }) {
    final sanitizedDays = selectedDays.clamp(2, 5);
    final workoutWeekdays = switch (sanitizedDays) {
      2 => const [1, 4],
      3 => const [1, 3, 5],
      4 => const [1, 2, 4, 6],
      _ => const [1, 2, 4, 5, 6],
    };

    final templates = beginnerPPL.days;
    final planName = switch (goal) {
      OnboardingGoal.buildMuscle => 'Muscle Builder Split',
      OnboardingGoal.getStrong => 'Strength Focus Split',
      OnboardingGoal.generalFitness => 'Performance Balance Split',
    };

    final days = List<WorkoutDayModel>.generate(workoutWeekdays.length, (
      index,
    ) {
      final template = templates[index % templates.length];
      return WorkoutDayModel(
        name: template.name,
        workoutDays: [workoutWeekdays[index]],
        exercises: template.exercises
            .map(
              (exercise) => WorkoutDayExercise(
                exercise: exercise.exercise,
                defaultSets: _adjustSets(goal, exercise.defaultSets),
                defaultReps: _adjustReps(goal, exercise.defaultReps),
              ),
            )
            .toList(),
      );
    });

    return WorkoutPlanModel(
      id: '${goal.name}_${sanitizedDays}_day_plan',
      name: planName,
      days: days,
    );
  }

  @override
  WorkoutDayModel? getTodayDay(WorkoutPlanModel plan) {
    final today = DateTime.now().weekday; // 1=Mon … 7=Sun
    for (final day in plan.days) {
      if (day.workoutDays.contains(today)) return day;
    }
    return null; // rest day
  }

  int _adjustSets(OnboardingGoal goal, int baseSets) {
    return switch (goal) {
      OnboardingGoal.buildMuscle => baseSets + 1,
      OnboardingGoal.getStrong => baseSets,
      OnboardingGoal.generalFitness => baseSets,
    };
  }

  int _adjustReps(OnboardingGoal goal, int baseReps) {
    return switch (goal) {
      OnboardingGoal.buildMuscle => baseReps + 2,
      OnboardingGoal.getStrong => (baseReps - 2).clamp(4, 12),
      OnboardingGoal.generalFitness => baseReps,
    };
  }
}
