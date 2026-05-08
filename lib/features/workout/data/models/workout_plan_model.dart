import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';

class WorkoutPlanModel {
  const WorkoutPlanModel({
    required this.id,
    required this.name,
    required this.days,
  });

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) {
    return WorkoutPlanModel(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      days: (json['days'] as List<dynamic>? ?? const [])
          .map(
            (day) => WorkoutDayModel.fromJson(
              Map<String, dynamic>.from(day as Map<dynamic, dynamic>),
            ),
          )
          .toList(),
    );
  }

  final String id;
  final String name;

  /// Ordered list of workout days that make up the repeating weekly cycle.
  final List<WorkoutDayModel> days;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'days': days.map((day) => day.toJson()).toList(),
    };
  }
}
