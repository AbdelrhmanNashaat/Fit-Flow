import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/errors/firebase_errors.dart';
import '../../../../core/service/firebase_service.dart';
import 'auth_repo.dart';

class FirebaseAuthRepoImpl implements FireBaseAuthRepo {
  final FirebaseService firebaseService;

  FirebaseAuthRepoImpl({required this.firebaseService});

  @override
  Future<Either<FirebaseErrors, User>> signUp(
    String email,
    String password,
  ) async {
    try {
      final user = await firebaseService.signUp(
        email: email,
        password: password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseErrors.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseErrors(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseErrors, User>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await firebaseService.signIn(
        email: email,
        password: password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseErrors.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseErrors(message: e.toString()));
    }
  }

  @override
  Future<Either<FirebaseErrors, void>> resetPassword(String email) async {
    try {
      await firebaseService.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(FirebaseErrors.fromCode(e.code));
    } catch (e) {
      return Left(FirebaseErrors(message: e.toString()));
    }
  }
}
