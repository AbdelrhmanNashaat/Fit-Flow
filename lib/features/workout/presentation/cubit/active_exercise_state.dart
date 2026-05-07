import 'package:fit_flow/features/workout/data/models/workout_set_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';

sealed class ActiveExerciseState {
  const ActiveExerciseState();
}

class ActiveExerciseReady extends ActiveExerciseState {
  const ActiveExerciseReady({
    required this.day,
    required this.currentIndex,
    required this.sets,
    required this.elapsedSeconds,
    this.showWeightDialog = true,
    this.validationError,
    this.restTimerSeconds,
  });

  final WorkoutDayModel day;
  final int currentIndex;
  final List<WorkoutSetModel> sets;
  final int elapsedSeconds;

  /// Show the starting-weight dialog on first load of each exercise.
  final bool showWeightDialog;

  /// Non-null while a validation error should be shown in the UI.
  final String? validationError;

  /// Non-null while the rest countdown is running (seconds remaining).
  final int? restTimerSeconds;

  WorkoutDayExercise get currentDayExercise => day.exercises[currentIndex];
  bool get isFirst => currentIndex == 0;
  bool get isLast => currentIndex == day.exercises.length - 1;
  bool get allSetsCompleted => sets.every((s) => s.isCompleted);
  bool get allSetsHaveWeight =>
      sets.every((s) => s.weightKg != null && s.weightKg! >= 1.0);

  ActiveExerciseReady copyWith({
    WorkoutDayModel? day,
    int? currentIndex,
    List<WorkoutSetModel>? sets,
    int? elapsedSeconds,
    bool? showWeightDialog,
    Object? validationError = _sentinel,
    Object? restTimerSeconds = _sentinel,
  }) {
    return ActiveExerciseReady(
      day: day ?? this.day,
      currentIndex: currentIndex ?? this.currentIndex,
      sets: sets ?? this.sets,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      showWeightDialog: showWeightDialog ?? this.showWeightDialog,
      validationError:
          validationError == _sentinel ? this.validationError : validationError as String?,
      restTimerSeconds:
          restTimerSeconds == _sentinel ? this.restTimerSeconds : restTimerSeconds as int?,
    );
  }
}

// Sentinel used for nullable copyWith fields.
const Object _sentinel = Object();

class ActiveExerciseFinished extends ActiveExerciseState {
  const ActiveExerciseFinished();
}
