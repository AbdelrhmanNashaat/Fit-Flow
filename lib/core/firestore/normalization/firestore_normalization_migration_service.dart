import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/core/firestore/normalization/firestore_normalization_rules.dart';
import 'package:fit_flow/core/firestore/normalization/normalized_firestore_catalog.dart';

class FirestoreCollectionMigrationStats {
  const FirestoreCollectionMigrationStats({
    required this.scanned,
    required this.created,
    required this.updated,
    required this.deleted,
    required this.unresolved,
  });

  final int scanned;
  final int created;
  final int updated;
  final int deleted;
  final int unresolved;
}

class FirestoreNormalizationMigrationResult {
  const FirestoreNormalizationMigrationResult({
    required this.exercises,
    required this.workoutTemplates,
    required this.learn,
  });

  final FirestoreCollectionMigrationStats exercises;
  final FirestoreCollectionMigrationStats workoutTemplates;
  final FirestoreCollectionMigrationStats learn;
}

class FirestoreNormalizationMigrationService {
  FirestoreNormalizationMigrationService(this._firestore);

  final FirebaseFirestore _firestore;

  Future<FirestoreNormalizationMigrationResult> normalizeCollections({
    bool deleteDuplicateExercises = false,
    bool deleteLegacyWorkoutTemplates = false,
    bool deleteLegacyLearnDocuments = false,
  }) async {
    final writer = _FirestoreBatchWriter(_firestore);

    final exercises = await _normalizeExercises(
      writer,
      deleteDuplicateExercises: deleteDuplicateExercises,
    );
    final workoutTemplates = await _normalizeWorkoutTemplates(
      writer,
      deleteLegacyWorkoutTemplates: deleteLegacyWorkoutTemplates,
    );
    final learn = await _normalizeLearn(
      writer,
      deleteLegacyLearnDocuments: deleteLegacyLearnDocuments,
    );

    await writer.flush();

    return FirestoreNormalizationMigrationResult(
      exercises: exercises,
      workoutTemplates: workoutTemplates,
      learn: learn,
    );
  }

  Future<FirestoreCollectionMigrationStats> _normalizeExercises(
    _FirestoreBatchWriter writer, {
    required bool deleteDuplicateExercises,
  }) async {
    final collection = _firestore.collection('exercises');
    final snapshot = await collection.get();
    final existingDocs = {
      for (final doc in snapshot.docs) doc.id: doc,
    };

    var created = 0;
    var updated = 0;
    var deleted = 0;
    var unresolved = 0;

    for (final exercise in canonicalExercises) {
      final doc = existingDocs[exercise.id];
      final target = exercise.toJson();
      if (doc == null) {
        await writer.set(collection.doc(exercise.id), target);
        created++;
        continue;
      }

      final patch = _buildPatch(
        current: doc.data(),
        target: target,
      );
      if (patch.isNotEmpty) {
        await writer.update(doc.reference, patch);
        updated++;
      }
    }

    final canonicalIds = buildExercisesSeedJson().keys.toSet();
    for (final doc in snapshot.docs) {
      final isKnownCanonical = canonicalIds.contains(doc.id);

      if (!isKnownCanonical) {
        if (deleteDuplicateExercises) {
          await writer.delete(doc.reference);
          deleted++;
        } else {
          unresolved++;
        }
      }
    }

    return FirestoreCollectionMigrationStats(
      scanned: snapshot.docs.length,
      created: created,
      updated: updated,
      deleted: deleted,
      unresolved: unresolved,
    );
  }

  Future<FirestoreCollectionMigrationStats> _normalizeWorkoutTemplates(
    _FirestoreBatchWriter writer, {
    required bool deleteLegacyWorkoutTemplates,
  }) async {
    final collection = _firestore.collection('workout_templates');
    final snapshot = await collection.get();
    final existingDocs = {
      for (final doc in snapshot.docs) doc.id: doc,
    };
    final canonicalMap = buildWorkoutTemplatesSeedJson();

    var created = 0;
    var updated = 0;
    var deleted = 0;
    var unresolved = 0;

    for (final template in canonicalWorkoutTemplates) {
      final doc = existingDocs[template.id];
      final target = template.toJson();
      if (doc == null) {
        await writer.set(collection.doc(template.id), target);
        created++;
        continue;
      }

      final patch = _buildPatch(current: doc.data(), target: target);
      if (patch.isNotEmpty) {
        await writer.update(doc.reference, patch);
        updated++;
      }
    }

    for (final doc in snapshot.docs) {
      if (canonicalMap.containsKey(doc.id)) {
        continue;
      }
      if (deleteLegacyWorkoutTemplates) {
        await writer.delete(doc.reference);
        deleted++;
      } else {
        unresolved++;
      }
    }

    return FirestoreCollectionMigrationStats(
      scanned: snapshot.docs.length,
      created: created,
      updated: updated,
      deleted: deleted,
      unresolved: unresolved,
    );
  }

  Future<FirestoreCollectionMigrationStats> _normalizeLearn(
    _FirestoreBatchWriter writer, {
    required bool deleteLegacyLearnDocuments,
  }) async {
    final collection = _firestore.collection('learn');
    final snapshot = await collection.get();
    final existingDocs = {
      for (final doc in snapshot.docs) doc.id: doc,
    };
    final canonicalMap = buildLearnSeedJson();

    var created = 0;
    var updated = 0;
    var deleted = 0;
    var unresolved = 0;

    for (final learn in canonicalLearnDocuments) {
      final doc = existingDocs[learn.id];
      final target = _preserveLearnMedia(
        existing: doc?.data(),
        target: learn.toJson(),
      );
      if (doc == null) {
        await writer.set(collection.doc(learn.id), target);
        created++;
        continue;
      }

      final patch = _buildPatch(current: doc.data(), target: target);
      if (patch.isNotEmpty) {
        await writer.update(doc.reference, patch);
        updated++;
      }
    }

    for (final doc in snapshot.docs) {
      if (canonicalMap.containsKey(doc.id)) {
        continue;
      }
      if (deleteLegacyLearnDocuments) {
        await writer.delete(doc.reference);
        deleted++;
      } else {
        unresolved++;
      }
    }

    return FirestoreCollectionMigrationStats(
      scanned: snapshot.docs.length,
      created: created,
      updated: updated,
      deleted: deleted,
      unresolved: unresolved,
    );
  }

  Map<String, dynamic> _preserveLearnMedia({
    required Map<String, dynamic>? existing,
    required Map<String, dynamic> target,
  }) {
    if (existing == null) {
      return target;
    }

    final preservedVideoUrl = existing['videoUrl'] as String?;
    final preservedThumbnailUrl = existing['thumbnailUrl'] as String?;

    return {
      ...target,
      'videoUrl':
          preservedVideoUrl != null && preservedVideoUrl.trim().isNotEmpty
          ? preservedVideoUrl
          : target['videoUrl'],
      'thumbnailUrl': preservedThumbnailUrl != null &&
              preservedThumbnailUrl.trim().isNotEmpty
          ? preservedThumbnailUrl
          : target['thumbnailUrl'],
    };
  }
}

class _FirestoreBatchWriter {
  _FirestoreBatchWriter(this._firestore);

  final FirebaseFirestore _firestore;
  WriteBatch? _batch;
  int _operations = 0;

  Future<void> set(
    DocumentReference<Map<String, dynamic>> reference,
    Map<String, dynamic> data,
  ) async {
    _ensureBatch();
    _batch!.set(reference, data);
    await _markOperation();
  }

  Future<void> update(
    DocumentReference<Map<String, dynamic>> reference,
    Map<String, dynamic> data,
  ) async {
    _ensureBatch();
    _batch!.update(reference, data);
    await _markOperation();
  }

  Future<void> delete(DocumentReference<Map<String, dynamic>> reference) async {
    _ensureBatch();
    _batch!.delete(reference);
    await _markOperation();
  }

  Future<void> flush() async {
    if (_batch == null || _operations == 0) {
      return;
    }
    await _batch!.commit();
    _batch = null;
    _operations = 0;
  }

  void _ensureBatch() {
    _batch ??= _firestore.batch();
  }

  Future<void> _markOperation() async {
    _operations++;
    if (_operations >= 450) {
      await flush();
    }
  }
}

Map<String, dynamic> _buildPatch({
  required Map<String, dynamic> current,
  required Map<String, dynamic> target,
}) {
  final patch = <String, dynamic>{};

  for (final entry in target.entries) {
    if (!_deepEquals(current[entry.key], entry.value)) {
      patch[entry.key] = entry.value;
    }
  }

  for (final key in current.keys) {
    if (!target.containsKey(key) || removableExerciseMediaFields.contains(key)) {
      patch[key] = FieldValue.delete();
    }
  }

  return patch;
}

bool _deepEquals(Object? left, Object? right) {
  return jsonEncode(left) == jsonEncode(right);
}