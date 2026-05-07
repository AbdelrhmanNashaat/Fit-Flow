import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/core/service/database_service.dart';

class FirestoreService implements DatabaseService {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<void> createUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection('users').doc(uid).set(data);
  }

  @override
  Future<Map<String, dynamic>?> getUser({required String uid}) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  @override
  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    await _firestore.collection('users').doc(uid).update(data);
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}
