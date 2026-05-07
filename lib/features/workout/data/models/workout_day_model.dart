import 'package:fit_flow/features/workout/data/models/exercise_model.dart';

/// A pairing of an exercise with its prescribed default sets/reps for a day.
class WorkoutDayExercise {
  const WorkoutDayExercise({
    required this.exercise,
    required this.defaultSets,
    required this.defaultReps,
  });

  final ExerciseModel exercise;
  final int defaultSets;
  final int defaultReps;
}

class WorkoutDayModel {
  const WorkoutDayModel({
    required this.name,
    required this.workoutDays,
    required this.exercises,
  });

  final String name;

  /// ISO weekday integers: 1 = Monday … 7 = Sunday
  final List<int> workoutDays;

  final List<WorkoutDayExercise> exercises;

  bool get isRestDay => exercises.isEmpty;
}
