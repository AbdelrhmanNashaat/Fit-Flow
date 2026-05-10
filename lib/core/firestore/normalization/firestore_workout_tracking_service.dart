import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/core/firestore/normalization/normalized_firestore_models.dart';

class FirestoreWorkoutTrackingService {
  FirestoreWorkoutTrackingService(this._firestore);

  final FirebaseFirestore _firestore;

  static const validWorkoutStatuses = <String>{
    'completed',
    'missed',
    'skipped',
    'partial',
  };

  Future<void> saveCurrentPlan({
    required String uid,
    required CurrentPlanDocument plan,
  }) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('current_plan')
        .doc('active')
        .set(plan.toJson());
  }

  Future<void> saveWorkoutSession({
    required String uid,
    required WorkoutSessionDocument session,
  }) {
    _assertValidStatus(session.status);
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('workout_sessions')
        .doc(session.id)
        .set(session.toJson());
  }

  Future<void> upsertExerciseProgress({
    required String uid,
    required ExerciseProgressDocument progress,
  }) {
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('exercise_progress')
        .doc(progress.exerciseId)
        .set(progress.toJson(), SetOptions(merge: true));
  }

  Future<void> saveWorkoutCalendarEntry({
    required String uid,
    required WorkoutCalendarEntryDocument entry,
  }) {
    _assertValidStatus(entry.status);
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('workout_calendar')
        .doc(entry.date)
        .set(entry.toJson(), SetOptions(merge: true));
  }

  Future<void> markWorkoutSessionStatus({
    required String uid,
    required String sessionId,
    required String status,
  }) {
    _assertValidStatus(status);
    return _firestore
        .collection('users')
        .doc(uid)
        .collection('workout_sessions')
        .doc(sessionId)
        .update({'status': status});
  }

  void _assertValidStatus(String status) {
    if (!validWorkoutStatuses.contains(status)) {
      throw ArgumentError.value(status, 'status', 'Invalid workout status');
    }
  }
}