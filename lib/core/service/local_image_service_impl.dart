import 'dart:io';
import 'dart:typed_data';

import 'package:fit_flow/core/service/local_image_service.dart';
import 'package:path_provider/path_provider.dart';

class LocalImageServiceImpl implements LocalImageService {
  const LocalImageServiceImpl();

  @override
  Future<String> saveProfileImage({
    required String uid,
    required Uint8List imageBytes,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final profileDir = Directory('${dir.path}/profile_images');
    await profileDir.create(recursive: true);
    final file = File('${profileDir.path}/$uid.jpg');
    await file.writeAsBytes(imageBytes, flush: true);
    return file.path;
  }
}
