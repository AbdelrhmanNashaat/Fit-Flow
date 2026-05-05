import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  const AuthRepoImpl(this._authService);

  final AuthService _authService;

  @override
  Future<Either<Failure, AuthUser>> signIn(
    String email,
    String password,
  ) async {
    try {
      final user = await _authService.signIn(email: email, password: password);
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
      return Right(user);
    } catch (e) {
      return Left(Failure(_extractMessage(e)));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithGoogle() async {
    try {
      final user = await _authService.signInWithGoogle();
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

  String _extractMessage(Object e) {
    log(e.toString(), name: 'AuthRepoImpl');
    return e.toString().replaceFirst('Exception: ', '');
  }
}
