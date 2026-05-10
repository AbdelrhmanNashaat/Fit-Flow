import 'dart:io' as io;

import 'package:fit_flow/core/bootstrap/app_bootstrap.dart';
import 'package:fit_flow/core/config/app_flavor.dart';
import 'package:fit_flow/core/firestore/normalization/firestore_normalization_migration_service.dart';
import 'package:fit_flow/core/service/service_locator.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBootstrap.init(flavor: AppFlavor.production);

  final service = getIt<FirestoreNormalizationMigrationService>();
  final result = await service.normalizeCollections(
    deleteDuplicateExercises: true,
    deleteLegacyWorkoutTemplates: true,
    deleteLegacyLearnDocuments: true,
  );

  debugPrint(
    'NORMALIZATION_MIGRATION exercises='
    'scanned:${result.exercises.scanned} '
    'created:${result.exercises.created} '
    'updated:${result.exercises.updated} '
    'deleted:${result.exercises.deleted} '
    'unresolved:${result.exercises.unresolved}',
  );
  debugPrint(
    'NORMALIZATION_MIGRATION workout_templates='
    'scanned:${result.workoutTemplates.scanned} '
    'created:${result.workoutTemplates.created} '
    'updated:${result.workoutTemplates.updated} '
    'deleted:${result.workoutTemplates.deleted} '
    'unresolved:${result.workoutTemplates.unresolved}',
  );
  debugPrint(
    'NORMALIZATION_MIGRATION learn='
    'scanned:${result.learn.scanned} '
    'created:${result.learn.created} '
    'updated:${result.learn.updated} '
    'deleted:${result.learn.deleted} '
    'unresolved:${result.learn.unresolved}',
  );

  await Future<void>.delayed(const Duration(seconds: 2));
  io.exit(0);
}