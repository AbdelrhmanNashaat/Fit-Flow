import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/service/database_service.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:fit_flow/features/workout/domain/repo/current_workout_plan_repo.dart';

class FirestoreCurrentWorkoutPlanRepo implements CurrentWorkoutPlanRepo {
  const FirestoreCurrentWorkoutPlanRepo(this._databaseService);

  final DatabaseService _databaseService;

  @override
  Future<Either<Failure, WorkoutPlanModel?>> getCurrentPlan(String uid) async {
    try {
      final data = await _databaseService.getDocument(
        pathSegments: ['users', uid, 'plans', 'current'],
      );
      if (data == null) {
        return const Right(null);
      }
      return Right(WorkoutPlanModel.fromJson(data));
    } catch (e) {
      log(e.toString(), name: 'FirestoreCurrentWorkoutPlanRepo');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, void>> saveCurrentPlan(
    String uid,
    WorkoutPlanModel plan,
  ) async {
    try {
      await _databaseService.setDocument(
        pathSegments: ['users', uid, 'plans', 'current'],
        data: plan.toJson(),
      );
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'FirestoreCurrentWorkoutPlanRepo');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, void>> clearCurrentPlan(String uid) async {
    try {
      await _databaseService.deleteDocument(
        pathSegments: ['users', uid, 'plans', 'current'],
      );
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'FirestoreCurrentWorkoutPlanRepo');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
