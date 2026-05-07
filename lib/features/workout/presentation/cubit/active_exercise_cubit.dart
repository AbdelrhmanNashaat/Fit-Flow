import 'dart:async';

import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_set_model.dart';
import 'package:fit_flow/features/workout/presentation/cubit/active_exercise_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveExerciseCubit extends Cubit<ActiveExerciseState> {
  ActiveExerciseCubit() : super(const ActiveExerciseFinished());

  Timer? _exerciseTimer;
  Timer? _restTimer;

  static const int _defaultRestSeconds = 90;

  void start(WorkoutDayModel day, int startIndex) {
    _cancelAllTimers();
    final sets = _defaultSets(day.exercises[startIndex]);
    emit(
      ActiveExerciseReady(
        day: day,
        currentIndex: startIndex,
        sets: sets,
        elapsedSeconds: 0,
        showWeightDialog: true,
      ),
    );
    _startExerciseTimer();
  }

  void dismissWeightDialog(double? weightKg) {
    final s = state;
    if (s is! ActiveExerciseReady) return;

    List<WorkoutSetModel> sets = s.sets;
    if (weightKg != null && weightKg >= 1.0) {
      sets = sets.map((set) => set.copyWith(weightKg: weightKg)).toList();
    }
    emit(s.copyWith(showWeightDialog: false, sets: sets));
  }

  void goToExercise(int index) {
    final s = state;
    if (s is! ActiveExerciseReady) return;
    _cancelAllTimers();
    emit(
      s.copyWith(
        currentIndex: index,
        sets: _defaultSets(s.day.exercises[index]),
        elapsedSeconds: 0,
        showWeightDialog: true,
        validationError: null,
        restTimerSeconds: null,
      ),
    );
    _startExerciseTimer();
  }

  bool tryNextExercise() {
    final s = state;
    if (s is! ActiveExerciseReady || s.isLast) return false;
    if (!_validateSets(s)) return false;
    goToExercise(s.currentIndex + 1);
    return true;
  }

  void previousExercise() {
    final s = state;
    if (s is! ActiveExerciseReady || s.isFirst) return;
    goToExercise(s.currentIndex - 1);
  }

  bool tryFinish() {
    final s = state;
    if (s is! ActiveExerciseReady) return false;
    if (!_validateSets(s)) return false;
    _cancelAllTimers();
    emit(const ActiveExerciseFinished());
    return true;
  }

  void clearValidationError() {
    final s = state;
    if (s is! ActiveExerciseReady || s.validationError == null) return;
    emit(s.copyWith(validationError: null));
  }

  void toggleSet(int setIndex) {
    final s = state;
    if (s is! ActiveExerciseReady) return;
    final updated = List<WorkoutSetModel>.from(s.sets);
    updated[setIndex] = updated[setIndex].copyWith(
      isCompleted: !updated[setIndex].isCompleted,
    );
    emit(s.copyWith(sets: updated, validationError: null));
  }

  void updateSetWeight(int setIndex, double weightKg) {
    final s = state;
    if (s is! ActiveExerciseReady) return;
    final updated = List<WorkoutSetModel>.from(s.sets);
    updated[setIndex] = updated[setIndex].copyWith(weightKg: weightKg);
    emit(s.copyWith(sets: updated, validationError: null));
  }

  void addSet() {
    final s = state;
    if (s is! ActiveExerciseReady) return;
    final next = s.sets.length + 1;
    final lastReps = s.sets.isNotEmpty ? s.sets.last.reps : 10;
    final lastWeight = s.sets.isNotEmpty ? s.sets.last.weightKg : null;
    emit(
      s.copyWith(
        sets: [
          ...s.sets,
          WorkoutSetModel(
            setNumber: next,
            reps: lastReps,
            weightKg: lastWeight,
          ),
        ],
      ),
    );
  }

  void startRestTimer() {
    final s = state;
    if (s is! ActiveExerciseReady) return;
    _restTimer?.cancel();
    emit(s.copyWith(restTimerSeconds: _defaultRestSeconds));
    _restTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final current = state;
      if (current is! ActiveExerciseReady) {
        _restTimer?.cancel();
        return;
      }
      final remaining = (current.restTimerSeconds ?? 0) - 1;
      if (remaining <= 0) {
        _restTimer?.cancel();
        emit(current.copyWith(restTimerSeconds: null));
      } else {
        emit(current.copyWith(restTimerSeconds: remaining));
      }
    });
  }

  bool _validateSets(ActiveExerciseReady s) {
    if (!s.allSetsCompleted) {
      emit(s.copyWith(validationError: 'completeAllSets'));
      return false;
    }
    if (!s.allSetsHaveWeight) {
      emit(s.copyWith(validationError: 'addWeight'));
      return false;
    }
    return true;
  }

  List<WorkoutSetModel> _defaultSets(WorkoutDayExercise dayEx) {
    return List.generate(
      dayEx.defaultSets,
      (i) => WorkoutSetModel(setNumber: i + 1, reps: dayEx.defaultReps),
    );
  }

  void _startExerciseTimer() {
    _exerciseTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      final s = state;
      if (s is ActiveExerciseReady) {
        emit(s.copyWith(elapsedSeconds: s.elapsedSeconds + 1));
      }
    });
  }

  void _cancelAllTimers() {
    _exerciseTimer?.cancel();
    _exerciseTimer = null;
    _restTimer?.cancel();
    _restTimer = null;
  }

  @override
  Future<void> close() {
    _exerciseTimer?.cancel();
    _restTimer?.cancel();
    return super.close();
  }
}
