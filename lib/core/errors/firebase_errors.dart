class FirebaseErrors {
  final String message;

  const FirebaseErrors({required this.message});

  factory FirebaseErrors.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return const FirebaseErrors(message: 'This email is already in use.');
      case 'invalid-email':
        return const FirebaseErrors(message: 'The email address is invalid.');
      case 'operation-not-allowed':
        return const FirebaseErrors(
          message: 'Operation not allowed. Contact support.',
        );
      case 'weak-password':
        return const FirebaseErrors(message: 'The password is too weak.');
      case 'user-disabled':
        return const FirebaseErrors(message: 'This user has been disabled.');
      case 'user-not-found':
        return const FirebaseErrors(message: 'No user found with this email.');
      case 'wrong-password':
        return const FirebaseErrors(message: 'Incorrect password.');
      case 'too-many-requests':
        return const FirebaseErrors(
          message: 'Too many attempts. Try again later.',
        );
      case 'requires-recent-login':
        return const FirebaseErrors(
          message: 'Please login again to perform this action.',
        );
      default:
        return const FirebaseErrors(message: 'An unknown error occurred.');
    }
  }
}
