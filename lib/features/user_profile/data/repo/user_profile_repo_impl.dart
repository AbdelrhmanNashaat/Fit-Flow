import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/core/service/database_service.dart';
import 'package:fit_flow/core/service/local_image_service.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  const UserProfileRepoImpl(
    this._databaseService,
    this._localImageService,
    this._cacheHelper,
  );

  final DatabaseService _databaseService;
  final LocalImageService _localImageService;
  final CacheHelper _cacheHelper;

  @override
  Future<Either<Failure, UserProfile?>> getProfile(String uid) async {
    final cachedJson = _cacheHelper.getCachedProfileJson(uid);
    try {
      final data = await _databaseService.getUser(uid: uid);
      if (data == null) {
        if (cachedJson != null) return Right(_profileFromCacheJson(cachedJson));
        return const Right(null);
      }
      await _cacheHelper.cacheProfileJson(uid, _toCacheableJson(data));
      return Right(UserProfile.fromJson(data));
    } catch (e) {
      log(e.toString(), name: 'UserProfileRepoImpl');
      if (cachedJson != null) return Right(_profileFromCacheJson(cachedJson));
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Map<String, dynamic> _toCacheableJson(Map<String, dynamic> data) {
    final json = Map<String, dynamic>.from(data);
    final ts = data['createdAt'];
    if (ts is Timestamp) json['createdAt'] = ts.millisecondsSinceEpoch;
    return json;
  }

  UserProfile _profileFromCacheJson(Map<String, dynamic> json) {
    final millis = json['createdAt'] as int?;
    return UserProfile(
      uid: json['uid'] as String? ?? '',
      email: json['email'] as String? ?? '',
      name: json['name'] as String?,
      myGoal: json['myGoal'] as String?,
      weeklyAvailability: json['weeklyAvailability'] as int?,
      isOnboardingCompleted: json['isOnboardingCompleted'] as bool? ?? false,
      createdAt: millis != null
          ? DateTime.fromMillisecondsSinceEpoch(millis)
          : DateTime.now(),
    );
  }

  @override
  Future<Either<Failure, void>> createProfile(UserProfile profile) async {
    try {
      await _databaseService.createUser(
        uid: profile.uid,
        data: profile.toJson(),
      );
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'UserProfileRepoImpl');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, void>> updateProfile(
    String uid,
    Map<String, dynamic> data,
  ) async {
    try {
      await _databaseService.updateUser(uid: uid, data: data);
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'UserProfileRepoImpl');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProfile(String uid) async {
    try {
      await _databaseService.deleteUser(uid: uid);
      return const Right(null);
    } catch (e) {
      log(e.toString(), name: 'UserProfileRepoImpl');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  Future<Either<Failure, String>> saveProfileImageLocally(
    String uid,
    Uint8List imageBytes,
  ) async {
    try {
      final path = await _localImageService.saveProfileImage(
        uid: uid,
        imageBytes: imageBytes,
      );
      await _cacheHelper.saveLocalImagePath(uid, path);
      return Right(path);
    } catch (e) {
      log(e.toString(), name: 'UserProfileRepoImpl');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  @override
  String? getCachedImagePath(String uid) => _cacheHelper.getLocalImagePath(uid);
}
