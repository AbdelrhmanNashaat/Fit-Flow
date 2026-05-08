import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_flow/core/service/database_service.dart';

class FirestoreService implements DatabaseService {
  FirestoreService(this._firestore);

  final FirebaseFirestore _firestore;

  DocumentReference<Map<String, dynamic>> _documentReference(
    List<String> pathSegments,
  ) {
    assert(pathSegments.length.isEven, 'Document path must have even segments');

    CollectionReference<Map<String, dynamic>>? collectionReference;
    DocumentReference<Map<String, dynamic>>? documentReference;

    for (var index = 0; index < pathSegments.length; index += 2) {
      collectionReference = index == 0
          ? _firestore.collection(pathSegments[index])
          : documentReference!.collection(pathSegments[index]);
      documentReference = collectionReference.doc(pathSegments[index + 1]);
    }

    return documentReference!;
  }

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

  @override
  Future<void> setDocument({
    required List<String> pathSegments,
    required Map<String, dynamic> data,
  }) async {
    await _documentReference(pathSegments).set(data);
  }

  @override
  Future<Map<String, dynamic>?> getDocument({
    required List<String> pathSegments,
  }) async {
    final document = await _documentReference(pathSegments).get();
    return document.data();
  }

  @override
  Future<void> deleteDocument({required List<String> pathSegments}) async {
    await _documentReference(pathSegments).delete();
  }
}
