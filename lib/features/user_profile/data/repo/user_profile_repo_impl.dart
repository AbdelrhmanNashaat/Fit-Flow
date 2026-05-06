import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/service/database_service.dart';
import 'package:fit_flow/features/user_profile/data/model/user_profile.dart';
import 'package:fit_flow/features/user_profile/domain/repo/user_profile_repo.dart';

class UserProfileRepoImpl implements UserProfileRepo {
  const UserProfileRepoImpl(this._databaseService);

  final DatabaseService _databaseService;

  @override
  Future<Either<Failure, UserProfile?>> getProfile(String uid) async {
    try {
      final data = await _databaseService.getUser(uid: uid);
      if (data == null) return const Right(null);
      return Right(UserProfile.fromJson(data));
    } catch (e) {
      log(e.toString(), name: 'UserProfileRepoImpl');
      return Left(Failure(e.toString().replaceFirst('Exception: ', '')));
    }
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
}
