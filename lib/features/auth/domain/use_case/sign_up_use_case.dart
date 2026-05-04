import 'package:dartz/dartz.dart';
import 'package:fit_flow/core/errors/firebase_errors.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';

class SignUpUseCase {
  SignUpUseCase({required this.repository});
  final FireBaseAuthRepo repository;

  Future<Either<FirebaseErrors, void>> call({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return const Left(
        FirebaseErrors(message: 'Email and password cannot be empty.'),
      );
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return const Left(FirebaseErrors(message: 'Invalid email format.'));
    }
    return repository.signUp(email, password);
  }
}
