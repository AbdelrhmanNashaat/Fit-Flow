import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

abstract class CurrentWorkoutPlanRepo {
  Future<Either<Failure, WorkoutPlanModel?>> getCurrentPlan(String uid);

  Future<Either<Failure, void>> saveCurrentPlan(
    String uid,
    WorkoutPlanModel plan,
  );

  Future<Either<Failure, void>> clearCurrentPlan(String uid);
}
