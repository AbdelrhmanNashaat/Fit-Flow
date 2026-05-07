import 'package:fit_flow/features/home/presentation/cubit/home_state.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/domain/repo/workout_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._workoutRepo) : super(const HomeInitial());

  final WorkoutRepo _workoutRepo;

  void load(String userName) {
    emit(const HomeLoading());

    try {
      final plan = _workoutRepo.getPlan();
      final todayDay = _workoutRepo.getTodayDay();
      final weekSchedule = _buildWeekSchedule(plan.days);
      final greeting = _greeting();

      emit(
        HomeLoaded(
          greeting: greeting,
          userName: userName,
          plan: plan,
          weekSchedule: weekSchedule,
          todayDay: todayDay,
        ),
      );
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  List<DayStatus> _buildWeekSchedule(List<WorkoutDayModel> days) {
    return List.generate(7, (i) {
      final weekday = i + 1; // 1=Mon … 7=Sun
      String? dayName;
      for (final d in days) {
        if (d.workoutDays.contains(weekday)) {
          dayName = d.name;
          break;
        }
      }
      return DayStatus(
        weekday: weekday,
        kind: dayName != null ? DayKind.workout : DayKind.rest,
        dayName: dayName,
      );
    });
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'morning';
    if (hour < 17) return 'afternoon';
    return 'evening';
  }
}
