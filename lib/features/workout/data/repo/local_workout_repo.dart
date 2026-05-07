import 'package:fit_flow/features/workout/data/models/sample_workout_data.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';

class LocalWorkoutRepo implements WorkoutRepo {
  const LocalWorkoutRepo();

  @override
  WorkoutPlanModel getPlan() => beginnerPPL;

  @override
  WorkoutDayModel? getTodayDay() {
    final today = DateTime.now().weekday; // 1=Mon … 7=Sun
    for (final day in beginnerPPL.days) {
      if (day.workoutDays.contains(today)) return day;
    }
    return null; // rest day
  }
}
