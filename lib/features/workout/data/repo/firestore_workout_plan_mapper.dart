import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/features/workout/data/models/exercise_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_day_model.dart';
import 'package:fit_flow/features/workout/data/models/workout_plan_model.dart';

class FirestoreWorkoutPlanMapper {
  const FirestoreWorkoutPlanMapper(this._firestore, this._cacheHelper);

  final FirebaseFirestore _firestore;
  final CacheHelper _cacheHelper;

  Future<WorkoutPlanModel> buildPlan({
    required String templateId,
    int? daysPerWeek,
  }) async {
    final templateSnapshot = await _firestore
        .collection('workout_templates')
        .doc(templateId)
        .get();

    if (!templateSnapshot.exists) {
      throw Exception('Workout template $templateId was not found.');
    }

    return buildPlanFromTemplateData(
      templateId: templateId,
      templateData: templateSnapshot.data()!,
      daysPerWeek: daysPerWeek,
    );
  }

  Future<WorkoutPlanModel> buildPlanFromTemplateData({
    required String templateId,
    required Map<String, dynamic> templateData,
    int? daysPerWeek,
  }) async {
    final resolvedDaysPerWeek = (daysPerWeek ?? _readInt(templateData['daysPerWeek']))
        .clamp(2, 6);
    final assignedWeekdays = _assignedWeekdays(resolvedDaysPerWeek);
    final templateDays = (templateData['days'] as List<dynamic>? ?? const [])
        .map((value) => Map<String, dynamic>.from(value as Map<dynamic, dynamic>))
        .toList(growable: false);
    final exerciseIds = templateDays
        .expand((day) => day['exercises'] as List<dynamic>? ?? const [])
        .map(
          (slot) => (Map<String, dynamic>.from(slot as Map<dynamic, dynamic>)['exerciseId'] ?? '')
              .toString(),
        )
        .where((id) => id.isNotEmpty)
        .toSet()
        .toList(growable: false);
    final exerciseDocuments = await _loadExercises(exerciseIds);

    final days = <WorkoutDayModel>[];
    for (var index = 0; index < templateDays.length; index++) {
      final day = templateDays[index];
      final slots = (day['exercises'] as List<dynamic>? ?? const [])
          .map((value) => Map<String, dynamic>.from(value as Map<dynamic, dynamic>))
          .toList(growable: false);
      final exercises = <WorkoutDayExercise>[];
      for (final slot in slots) {
        final exerciseId = (slot['exerciseId'] ?? '').toString();
        final exerciseData = exerciseDocuments[exerciseId];
        if (exerciseData == null) {
          throw Exception('Exercise $exerciseId referenced by $templateId was not found.');
        }
        exercises.add(
          WorkoutDayExercise(
            exercise: _toExerciseModel(exerciseId, exerciseData),
            defaultSets: _readInt(slot['sets']),
            defaultReps: (slot['reps'] ?? '').toString(),
          ),
        );
      }

      days.add(
        WorkoutDayModel(
          name: _localizedText(day['name']),
          workoutDays: [assignedWeekdays[index]],
          exercises: exercises,
        ),
      );
    }

    return WorkoutPlanModel(
      id: templateId,
      name: _localizedText(templateData['name']),
      days: days,
    );
  }

  Future<Map<String, Map<String, dynamic>>> _loadExercises(
    List<String> exerciseIds,
  ) async {
    final documents = <String, Map<String, dynamic>>{};
    for (var index = 0; index < exerciseIds.length; index += 10) {
      final chunk = exerciseIds.skip(index).take(10).toList(growable: false);
      final snapshot = await _firestore
          .collection('exercises')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      for (final doc in snapshot.docs) {
        documents[doc.id] = doc.data();
      }
    }
    return documents;
  }

  ExerciseModel _toExerciseModel(String id, Map<String, dynamic> data) {
    return ExerciseModel(
      id: id,
      name: _localizedText(data['name']),
      muscleGroup: _displayValue(data['muscleGroup']),
      equipment: _displayValue(data['equipment']),
      formCues: _localizedList(data['instructions']),
    );
  }

  String _localizedText(dynamic value) {
    if (value is Map<String, dynamic>) {
      return (value[_localeCode] as String?) ??
          (value['en'] as String?) ??
          (value['ar'] as String?) ??
          '';
    }
    return value?.toString() ?? '';
  }

  List<String> _localizedList(dynamic value) {
    if (value is Map<String, dynamic>) {
      final localized = value[_localeCode];
      if (localized is List<dynamic>) {
        return localized.map((item) => item.toString()).toList(growable: false);
      }
      final english = value['en'];
      if (english is List<dynamic>) {
        return english.map((item) => item.toString()).toList(growable: false);
      }
    }
    if (value is List<dynamic>) {
      return value.map((item) => item.toString()).toList(growable: false);
    }
    return const [];
  }

  String _displayValue(dynamic value) {
    final rawValue = value?.toString() ?? '';
    if (rawValue.isEmpty) {
      return '';
    }

    if (_localeCode == 'ar') {
      return switch (rawValue) {
        'chest' => 'الصدر',
        'back' => 'الظهر',
        'legs' => 'الأرجل',
        'shoulders' => 'الكتف',
        'arms' => 'الذراعين',
        'core' => 'الوسط',
        'full_body' => 'الجسم كامل',
        'barbell' => 'بار',
        'dumbbell' => 'دمبل',
        'cable' => 'كيبل',
        'machine' => 'آلة',
        'bodyweight' => 'وزن الجسم',
        'bench' => 'بنش',
        'pull_up_bar' => 'عقلة',
        _ => rawValue,
      };
    }

    return rawValue
        .split('_')
        .where((segment) => segment.isNotEmpty)
        .map(
          (segment) => '${segment[0].toUpperCase()}${segment.substring(1)}',
        )
        .join(' ');
  }

  int _readInt(dynamic value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  String get _localeCode => _cacheHelper.savedLocale == 'ar' ? 'ar' : 'en';

  List<int> _assignedWeekdays(int daysPerWeek) {
    return switch (daysPerWeek) {
      2 => const [1, 4],
      3 => const [1, 3, 5],
      4 => const [1, 2, 4, 6],
      5 => const [1, 2, 4, 5, 6],
      _ => const [1, 2, 3, 4, 5, 6],
    };
  }
}