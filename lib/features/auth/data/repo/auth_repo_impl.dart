import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/auth_exception.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._authService);

  final AuthService _authService;

  @override
  Stream<AuthUser?> authStateChanges() {
    return _authService.authStateChanges();
  }

  @override
  Future<Either<Failure, AuthUser>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await _authService.signIn(email: email, password: password);
      return Right(user);
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final user = await _authService.signUp(
        email: email,
        password: password,
        displayName: name.trim(),
      );
      return Right(user);
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      return Right(user);
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser?>> restoreSession() async {
    try {
      final firebaseUser = await _authService.getCurrentUser();
      if (firebaseUser != null) {
        return Right(firebaseUser);
      }

      return const Right(null);
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authService.signOut();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount({String? password}) async {
    try {
      await _authService.deleteAccount(password: password);
      return const Right(null);
    } on ReauthRequiredException catch (e) {
      return Left(ReauthRequiredFailure(e.provider));
    } on AuthException catch (e) {
      return Left(e.failure);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  String _extractMessage(Object e) {
    log(e.toString(), name: 'AuthRepoImpl');
    return e.toString().replaceFirst('Exception: ', '');
  }
}
