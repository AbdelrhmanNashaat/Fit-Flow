class Failure {
  const Failure(this.message);

  final String message;
}

class ReauthRequiredFailure extends Failure {
  const ReauthRequiredFailure(this.provider)
      : super('Re-authentication required');

  /// Firebase sign-in provider id: 'password' or 'google.com'
  final String provider;
}
