import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/errors/firebase_errors.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';

class SignInUseCase {
  SignInUseCase({required this.repository});
  final FireBaseAuthRepo repository;

  Future<Either<FirebaseErrors, User>> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left(
        FirebaseErrors(message: 'Email and password cannot be empty.'),
      );
    }
    return repository.signIn(email, password);
  }
}
