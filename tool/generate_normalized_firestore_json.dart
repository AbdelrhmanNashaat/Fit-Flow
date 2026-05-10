import 'dart:convert';
import 'dart:io';

import 'package:fit_flow/core/firestore/normalization/normalized_firestore_catalog.dart';

Future<void> main() async {
  final outputDirectory = Directory('assets/data/firestore');
  if (!outputDirectory.existsSync()) {
    outputDirectory.createSync(recursive: true);
  }

  const encoder = JsonEncoder.withIndent('  ');

  final exercisesFile = File('${outputDirectory.path}/exercises.json');
  final workoutTemplatesFile =
      File('${outputDirectory.path}/workout_templates.json');
  final learnFile = File('${outputDirectory.path}/learn.json');

  await exercisesFile.writeAsString(
    encoder.convert(buildExercisesSeedJson()),
  );
  await workoutTemplatesFile.writeAsString(
    encoder.convert(buildWorkoutTemplatesSeedJson()),
  );
  await learnFile.writeAsString(
    encoder.convert(buildLearnSeedJson()),
  );

  stdout.writeln(
    'Generated ${canonicalExercises.length} exercises, '
    '${canonicalWorkoutTemplates.length} workout templates, '
    'and ${canonicalLearnDocuments.length} learn documents.',
  );
}