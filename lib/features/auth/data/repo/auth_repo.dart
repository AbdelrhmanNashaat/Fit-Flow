import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthUser>> signIn(String email, String password);
  Future<Either<Failure, AuthUser>> signUp(String email, String password);
  Future<Either<Failure, AuthUser>> signInWithGoogle();
  Future<Either<Failure, void>> resetPassword(String email);
}
