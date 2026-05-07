import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';

class WorkoutPlanModel {
  const WorkoutPlanModel({
    required this.id,
    required this.name,
    required this.days,
  });

  final String id;
  final String name;

  /// Ordered list of workout days that make up the repeating weekly cycle.
  final List<WorkoutDayModel> days;
}
