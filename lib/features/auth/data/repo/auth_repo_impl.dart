import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/auth_exception.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._authService, this._cacheHelper);

  final AuthService _authService;
  final CacheHelper _cacheHelper;

  @override
  Future<Either<Failure, AuthUser>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await _authService.signIn(email: email, password: password);
      await _cacheHelper.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signUp(
    String email,
    String password,
  ) async {
    try {
      final user = await _authService.signUp(email: email, password: password);
      await _cacheHelper.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
      await _cacheHelper.cacheUser(user);
      return Right(user);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    try {
      await _authService.sendPasswordResetEmail(email: email);
      return const Right(null);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser?>> restoreSession() async {
    try {
      final firebaseUser = await _authService.getCurrentUser();
      if (firebaseUser != null) {
        await _cacheHelper.cacheUser(firebaseUser);
        return Right(firebaseUser);
      }

      if (_cacheHelper.isLoggedIn || _cacheHelper.getCachedUser() != null) {
        await _cacheHelper.clearAuthData();
      }

      return const Right(null);
    } catch (e) {
      await _cacheHelper.clearAuthData();
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _authService.signOut();
      await _cacheHelper.clearAuthData();
      return const Right(null);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount({String? password}) async {
    try {
      await _authService.deleteAccount(password: password);
      await _cacheHelper.clearAuthData();
      return const Right(null);
    } on ReauthRequiredException catch (e) {
      return Left(ReauthRequiredFailure(e.provider));
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  String _extractMessage(Object e) {
    log(e.toString(), name: 'AuthRepoImpl');
    return e.toString().replaceFirst('Exception: ', '');
  }
}
