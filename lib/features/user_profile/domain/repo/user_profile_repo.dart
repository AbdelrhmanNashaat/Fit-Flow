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
}
