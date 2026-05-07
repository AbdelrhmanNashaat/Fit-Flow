import 'package:fit_flow/features/auth/data/model/auth_user.dart';

abstract class AuthService {
  Future<AuthUser?> getCurrentUser();
  Future<AuthUser> signIn({required String email, required String password});
  Future<AuthUser> signUp({required String email, required String password});
  Future<AuthUser> signInWithGoogle();
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> signOut();

  /// Permanently deletes the current Firebase Auth account.
  ///
  /// Handles re-authentication automatically for Google accounts.
  /// For email/password accounts, [password] must be supplied if Firebase
  /// throws [requires-recent-login]; otherwise throws [ReauthRequiredException].
  Future<void> deleteAccount({String? password});
}
