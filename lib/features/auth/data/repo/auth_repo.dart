import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/errors/firebase_errors.dart';

abstract class FireBaseAuthRepo {
  Future<Either<FirebaseErrors, void>> signUp(String email, String password);
  Future<Either<FirebaseErrors, User>> signIn(String email, String password);
  Future<Either<FirebaseErrors, void>> resetPassword(String email);
}
