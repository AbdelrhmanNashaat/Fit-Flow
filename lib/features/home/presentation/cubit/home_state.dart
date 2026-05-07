import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

enum DayKind { workout, rest }

class DayStatus {
  const DayStatus({
    required this.weekday,
    required this.kind,
    this.dayName,
  });

  /// ISO weekday: 1=Mon … 7=Sun
  final int weekday;
  final DayKind kind;

  /// Name of the workout day (e.g. "Push"), null for rest days.
  final String? dayName;
}

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  const HomeLoaded({
    required this.greeting,
    required this.userName,
    required this.plan,
    required this.weekSchedule,
    this.todayDay,
  });

  final String greeting;
  final String userName;
  final WorkoutPlanModel plan;

  /// One entry per ISO weekday 1–7.
  final List<DayStatus> weekSchedule;

  /// Today's workout day, or null if today is a rest day.
  final WorkoutDayModel? todayDay;

  bool get isRestDay => todayDay == null;
}

class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
}
