import 'package:fit_flow/features/onboarding/domain/models/onboarding_goal.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

abstract class WorkoutRepo {
  Future<WorkoutPlanModel> generatePlan({
    required OnboardingGoal goal,
    required int selectedDays,
  });

  WorkoutDayModel? getTodayDay(WorkoutPlanModel plan);
}
