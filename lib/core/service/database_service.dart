abstract class DatabaseService {
  Future<void> createUser({
    required String uid,
    required Map<String, dynamic> data,
  });

  Future<Map<String, dynamic>?> getUser({required String uid});

  Future<void> updateUser({
    required String uid,
    required Map<String, dynamic> data,
  });

  Future<void> deleteUser({required String uid});

  Future<void> setDocument({
    required List<String> pathSegments,
    required Map<String, dynamic> data,
  });

  Future<Map<String, dynamic>?> getDocument({
    required List<String> pathSegments,
  });

  Future<void> deleteDocument({required List<String> pathSegments});
}
