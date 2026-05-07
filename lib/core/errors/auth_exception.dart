class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
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
