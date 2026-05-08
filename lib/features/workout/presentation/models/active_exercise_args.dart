import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';

class ActiveExerciseArgs {
  const ActiveExerciseArgs({required this.day, required this.startIndex});

  final WorkoutDayModel day;
  final int startIndex;
}
