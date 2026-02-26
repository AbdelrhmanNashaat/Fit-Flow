import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/errors/firebase_errors.dart';
import '../../data/repo/auth_repo.dart';

class SignInUseCase {
  final FireBaseAuthRepo repository;
  SignInUseCase({required this.repository});

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
