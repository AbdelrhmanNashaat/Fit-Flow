import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';
import 'package:fit_flow/features/workout/data/repo/firestore_workout_plan_mapper.dart';
import 'package:fit_flow/features/workout/domain/repo/current_workout_plan_repo.dart';

class FirestoreCurrentWorkoutPlanRepo implements CurrentWorkoutPlanRepo {
  const FirestoreCurrentWorkoutPlanRepo(this._firestore, this._planMapper);

  final FirebaseFirestore _firestore;
  final FirestoreWorkoutPlanMapper _planMapper;

  @override
  Future<Either<Failure, WorkoutPlanModel?>> getCurrentPlan(String uid) async {
    try {
      final activeSnapshot = await _currentPlanDocument(uid).get();
      if (activeSnapshot.exists) {
        final activeData = activeSnapshot.data() ?? const <String, dynamic>{};
        final templateId = _resolveTemplateId(activeData);
        if (templateId.isEmpty) {
          return const Right(null);
        }
        final plan = await _planMapper.buildPlan(
          templateId: templateId,
          daysPerWeek: _resolveDaysPerWeek(activeData, templateId),
        );
        return Right(plan);
      }

      final legacySnapshot = await _legacyPlanDocument(uid).get();
      if (!legacySnapshot.exists) {
        return const Right(null);
      }

      final legacyPlan = WorkoutPlanModel.fromJson(legacySnapshot.data()!);
      final templateId = _normalizeLegacyTemplateId(legacyPlan.id);
      if (templateId.isNotEmpty) {
        await _currentPlanDocument(uid).set({
          'templateId': templateId,
          'daysPerWeek': legacyPlan.days.length,
          'updatedAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        await _legacyPlanDocument(uid).delete();
        final migratedPlan = await _planMapper.buildPlan(
          templateId: templateId,
          daysPerWeek: legacyPlan.days.length,
        );
        return Right(migratedPlan);
      }

      return Right(legacyPlan);
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
      await _currentPlanDocument(uid).set({
        'templateId': _normalizeLegacyTemplateId(plan.id),
        'daysPerWeek': plan.days.length,
        'updatedAt': FieldValue.serverTimestamp(),
        'startedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      final legacySnapshot = await _legacyPlanDocument(uid).get();
      if (legacySnapshot.exists) {
        await _legacyPlanDocument(uid).delete();
      }
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'FirestoreCurrentWorkoutPlanRepo');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, void>> clearCurrentPlan(String uid) async {
    try {
      final activeSnapshot = await _currentPlanDocument(uid).get();
      if (activeSnapshot.exists) {
        await _currentPlanDocument(uid).delete();
      }
      final legacySnapshot = await _legacyPlanDocument(uid).get();
      if (legacySnapshot.exists) {
        await _legacyPlanDocument(uid).delete();
      }
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'FirestoreCurrentWorkoutPlanRepo');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  DocumentReference<Map<String, dynamic>> _currentPlanDocument(String uid) {
    return _firestore.collection('users').doc(uid).collection('current_plan').doc('active');
  }

  DocumentReference<Map<String, dynamic>> _legacyPlanDocument(String uid) {
    return _firestore.collection('users').doc(uid).collection('plans').doc('current');
  }

  String _resolveTemplateId(Map<String, dynamic> data) {
    final rawTemplateId = (data['templateId'] ?? data['planId'] ?? '').toString();
    return _normalizeLegacyTemplateId(rawTemplateId);
  }

  int _resolveDaysPerWeek(Map<String, dynamic> data, String templateId) {
    final daysPerWeek = data['daysPerWeek'];
    if (daysPerWeek is int) {
      return daysPerWeek;
    }
    if (daysPerWeek is num) {
      return daysPerWeek.toInt();
    }
    final match = RegExp(r'(\d+)').firstMatch(templateId);
    return int.tryParse(match?.group(1) ?? '') ?? 3;
  }

  String _normalizeLegacyTemplateId(String templateId) {
    if (templateId.contains('_days')) {
      return templateId;
    }

    final match = RegExp(
      r'^(buildMuscle|getStrong|generalFitness)_(\d+)_day_plan$',
    ).firstMatch(templateId);
    if (match == null) {
      return templateId;
    }

    final goalPrefix = switch (match.group(1)) {
      'buildMuscle' => 'build_muscle',
      'getStrong' => 'get_strong',
      'generalFitness' => 'general_fitness',
      _ => '',
    };
    return '${goalPrefix}_${match.group(2)}_days';
  }
}
