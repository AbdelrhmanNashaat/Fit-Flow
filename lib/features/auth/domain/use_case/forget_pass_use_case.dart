import 'package:dartz/dartz.dart';

import 'package:fit_flow/core/errors/firebase_errors.dart';
import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';

class ResetPasswordUseCase {
  ResetPasswordUseCase({required this.repository});
  final FireBaseAuthRepo repository;

  Future<Either<FirebaseErrors, void>> call({required String email}) async {
    if (email.isEmpty) {
      return const Left(FirebaseErrors(message: 'Email cannot be empty.'));
    }
    return repository.resetPassword(email);
  }
}
