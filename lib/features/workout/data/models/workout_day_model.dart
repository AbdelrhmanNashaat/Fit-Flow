import 'package:fit_flow/features/workout/data/models/exercise_model.dart';

/// A pairing of an exercise with its prescribed default sets/reps for a day.
class WorkoutDayExercise {
  const WorkoutDayExercise({
    required this.exercise,
    required this.defaultSets,
    required this.defaultReps,
  });

  factory WorkoutDayExercise.fromJson(Map<String, dynamic> json) {
    return WorkoutDayExercise(
      exercise: ExerciseModel.fromJson(
        Map<String, dynamic>.from(
          json['exercise'] as Map<dynamic, dynamic>? ?? const {},
        ),
      ),
      defaultSets: json['defaultSets'] as int? ?? 0,
      defaultReps: json['defaultReps'] as int? ?? 0,
    );
  }

  final ExerciseModel exercise;
  final int defaultSets;
  final int defaultReps;

  Map<String, dynamic> toJson() {
    return {
      'exercise': exercise.toJson(),
      'defaultSets': defaultSets,
      'defaultReps': defaultReps,
    };
  }
}

class WorkoutDayModel {
  const WorkoutDayModel({
    required this.name,
    required this.workoutDays,
    required this.exercises,
  });

  factory WorkoutDayModel.fromJson(Map<String, dynamic> json) {
    return WorkoutDayModel(
      name: json['name'] as String? ?? '',
      workoutDays: List<int>.from(
        json['workoutDays'] as List<dynamic>? ?? const [],
      ),
      exercises: (json['exercises'] as List<dynamic>? ?? const [])
          .map(
            (exercise) => WorkoutDayExercise.fromJson(
              Map<String, dynamic>.from(exercise as Map<dynamic, dynamic>),
            ),
          )
          .toList(),
    );
  }

  final String name;

  /// ISO weekday integers: 1 = Monday … 7 = Sunday
  final List<int> workoutDays;

  final List<WorkoutDayExercise> exercises;

  bool get isRestDay => exercises.isEmpty;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'workoutDays': workoutDays,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList(),
    };
  }
}
