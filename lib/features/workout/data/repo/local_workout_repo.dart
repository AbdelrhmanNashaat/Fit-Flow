import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/workout/data/models/exercise_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

class LocalWorkoutRepo {
  const LocalWorkoutRepo();

  static const _weekdaySchedules = {
    2: [1, 4],
    3: [1, 3, 5],
    4: [1, 2, 4, 6],
    5: [1, 2, 3, 5, 6],
    6: [1, 2, 3, 4, 5, 6],
  };

  static const _planNames = {
    OnboardingGoal.buildMuscle: 'Hypertrophy Split',
    OnboardingGoal.getStrong: 'Strength Focus Split',
    OnboardingGoal.generalFitness: 'Full Body Plan',
  };

  static const _defaultReps = {
    OnboardingGoal.buildMuscle: '8-12',
    OnboardingGoal.getStrong: '6',
    OnboardingGoal.generalFitness: '12-15',
  };

  static const _splitDayNames = [
    'Push',
    'Pull',
    'Legs',
    'Upper',
    'Lower',
    'Full Body',
  ];

  static const _sampleExercise = ExerciseModel(
    id: 'bench_press',
    name: 'Bench Press',
    muscleGroup: 'Chest',
    equipment: 'Barbell',
    formCues: [],
  );

  WorkoutPlanModel generatePlan({
    required OnboardingGoal goal,
    required int selectedDays,
  }) {
    final clampedDays = selectedDays.clamp(2, 6);
    final weekdays = _weekdaySchedules[clampedDays]!;
    final reps = _defaultReps[goal]!;
    return WorkoutPlanModel(
      id: '${goal.name}_${clampedDays}_day_plan',
      name: _planNames[goal]!,
      days: List.generate(
        clampedDays,
        (i) => WorkoutDayModel(
          name: _splitDayNames[i % _splitDayNames.length],
          workoutDays: [weekdays[i]],
          exercises: [
            WorkoutDayExercise(
              exercise: _sampleExercise,
              defaultSets: 3,
              defaultReps: reps,
            ),
          ],
        ),
      ),
    );
  }

  WorkoutDayModel? getTodayDay(WorkoutPlanModel plan) {
    final today = DateTime.now().weekday;
    for (final day in plan.days) {
      if (day.workoutDays.contains(today)) {
        return day;
      }
    }
    return null;
  }
}
