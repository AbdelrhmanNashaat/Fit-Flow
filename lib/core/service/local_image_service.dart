import 'dart:typed_data';

abstract class LocalImageService {
  Future<String> saveProfileImage({
    required String uid,
    required Uint8List imageBytes,
  });
}
