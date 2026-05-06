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
}
