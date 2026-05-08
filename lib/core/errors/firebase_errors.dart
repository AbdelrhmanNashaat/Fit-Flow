import 'package:fit_flow/core/errors/failure.dart';

class FirebaseErrors {
  static AuthFailure fromCode(String code) {
    return switch (code) {
      'email-already-in-use' => const AuthFailure(
        message: 'This email is already in use.',
        code: AuthErrorCode.emailAlreadyInUse,
        field: FailureField.email,
      ),
      'invalid-email' => const AuthFailure(
        message: 'The email address is invalid.',
        code: AuthErrorCode.invalidEmail,
        field: FailureField.email,
      ),
      'operation-not-allowed' => const AuthFailure(
        message: 'Operation not allowed. Contact support.',
        code: AuthErrorCode.operationNotAllowed,
        field: FailureField.general,
      ),
      'weak-password' => const AuthFailure(
        message: 'The password is too weak.',
        code: AuthErrorCode.weakPassword,
        field: FailureField.password,
      ),
      'user-disabled' => const AuthFailure(
        message: 'This user has been disabled.',
        code: AuthErrorCode.userDisabled,
        field: FailureField.general,
      ),
      'user-not-found' => const AuthFailure(
        message: 'No user found with this email.',
        code: AuthErrorCode.userNotFound,
        field: FailureField.email,
      ),
      'wrong-password' => const AuthFailure(
        message: 'Incorrect password.',
        code: AuthErrorCode.wrongPassword,
        field: FailureField.password,
      ),
      'invalid-credential' => const AuthFailure(
        message: 'Incorrect email or password.',
        code: AuthErrorCode.invalidCredential,
        field: FailureField.general,
      ),
      'too-many-requests' => const AuthFailure(
        message: 'Too many attempts. Try again later.',
        code: AuthErrorCode.tooManyRequests,
        field: FailureField.general,
      ),
      'network-request-failed' => const AuthFailure(
        message: 'Network error. Check your connection and try again.',
        code: AuthErrorCode.networkRequestFailed,
        field: FailureField.general,
      ),
      'requires-recent-login' => const AuthFailure(
        message: 'Please sign in again to continue.',
        code: AuthErrorCode.requiresRecentLogin,
        field: FailureField.general,
      ),
      _ => const AuthFailure(
        message: 'An unknown authentication error occurred.',
        code: AuthErrorCode.unknown,
        field: FailureField.general,
      ),
    };
  }
}
