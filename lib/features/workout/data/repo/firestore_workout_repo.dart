import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:fit_flow/features/workout/data/repo/firestore_workout_plan_mapper.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';

class FirestoreWorkoutRepo implements WorkoutRepo {
  const FirestoreWorkoutRepo(this._planMapper);

  final FirestoreWorkoutPlanMapper _planMapper;

  @override
  Future<WorkoutPlanModel> generatePlan({
    required OnboardingGoal goal,
    required int selectedDays,
  }) {
    final sanitizedDays = selectedDays.clamp(2, 6);
    return _planMapper.buildPlan(
      templateId: _templateId(goal, sanitizedDays),
      daysPerWeek: sanitizedDays,
    );
  }

  @override
  WorkoutDayModel? getTodayDay(WorkoutPlanModel plan) {
    final today = DateTime.now().weekday;
    for (final day in plan.days) {
      if (day.workoutDays.contains(today)) {
        return day;
      }
    }
    return null;
  }

  String _templateId(OnboardingGoal goal, int selectedDays) {
    final goalPrefix = switch (goal) {
      OnboardingGoal.buildMuscle => 'build_muscle',
      OnboardingGoal.getStrong => 'get_strong',
      OnboardingGoal.generalFitness => 'general_fitness',
    };
    return '${goalPrefix}_${selectedDays}_days';
  }
}