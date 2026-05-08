import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';

abstract class AuthRepo {
  Future<Either<Failure, AuthUser>> signIn(String email, String password);
  Future<Either<Failure, AuthUser>> signUp(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, AuthUser>> signInWithGoogle();
  Future<Either<Failure, void>> resetPassword(String email);
  Future<Either<Failure, AuthUser?>> restoreSession();
  Future<Either<Failure, void>> signOut();

  /// Deletes the Firebase Auth account and clears local session.
  /// Returns [ReauthRequiredFailure] when the user must re-enter their password.
  Future<Either<Failure, void>> deleteAccount({String? password});
}
