import 'package:fit_flow/core/errors/failure.dart';

class AuthException implements Exception {
  const AuthException(this.failure);

  final Failure failure;

  @override
  String toString() => failure.message;
}

/// Thrown by [FirebaseAuthService.deleteAccount] when Firebase requires
/// a recent sign-in before the destructive operation can proceed.
class ReauthRequiredException implements Exception {
  const ReauthRequiredException(this.provider);

  /// Firebase provider id: 'password' or 'google.com'
  final String provider;

  @override
  String toString() => 'Re-authentication required for provider: $provider';
}
