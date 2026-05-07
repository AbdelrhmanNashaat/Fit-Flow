import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';

abstract class UserProfileRepo {
  Future<Either<Failure, UserProfile?>> getProfile(String uid);
  Future<Either<Failure, void>> createProfile(UserProfile profile);
  Future<Either<Failure, void>> updateProfile(
    String uid,
    Map<String, dynamic> data,
  );
  Future<Either<Failure, void>> deleteProfile(String uid);

  /// Saves [imageBytes] to the app documents directory and persists the path
  /// in local storage. Returns the absolute file path on success.
  Future<Either<Failure, String>> saveProfileImageLocally(
    String uid,
    Uint8List imageBytes,
  );

  /// Returns the locally persisted image path for [uid], or null if none.
  String? getCachedImagePath(String uid);
}
