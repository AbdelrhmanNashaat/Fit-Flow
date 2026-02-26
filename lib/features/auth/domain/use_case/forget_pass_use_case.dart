import 'package:dartz/dartz.dart';

import '../../../../core/errors/firebase_errors.dart';
import '../../data/repo/auth_repo.dart';

class ResetPasswordUseCase {
  final FireBaseAuthRepo repository;
  ResetPasswordUseCase({required this.repository});

  Future<Either<FirebaseErrors, void>> call({required String email}) async {
    if (email.isEmpty) {
      return const Left(FirebaseErrors(message: 'Email cannot be empty.'));
    }
    return repository.resetPassword(email);
  }
}
