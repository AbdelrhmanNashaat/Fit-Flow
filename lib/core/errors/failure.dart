class Failure {
  const Failure(this.message);

  final String message;
}

enum FailureField { email, password, name, general }

enum AuthErrorCode {
  invalidEmail,
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse,
  operationNotAllowed,
  userDisabled,
  tooManyRequests,
  networkRequestFailed,
  requiresRecentLogin,
  googleConfiguration,
  cancelled,
  invalidCredential,
  unknown,
}

class AuthFailure extends Failure {
  const AuthFailure({required String message, required this.code, this.field})
    : super(message);

  final AuthErrorCode code;
  final FailureField? field;

  bool get isFieldError => field != null && field != FailureField.general;
}

class ReauthRequiredFailure extends Failure {
  const ReauthRequiredFailure(this.provider)
    : super('Re-authentication required');

  /// Firebase sign-in provider id: 'password' or 'google.com'
  final String provider;
}
