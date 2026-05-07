import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

abstract class WorkoutRepo {
  WorkoutPlanModel getPlan();

  /// Returns the day matching today's weekday, or null on a rest day.
  WorkoutDayModel? getTodayDay();
}
