import 'package:fit_flow/features/auth/data/model/auth_user.dart';

abstract class AuthService {
  Future<AuthUser> signIn({required String email, required String password});
  Future<AuthUser> signUp({required String email, required String password});
  Future<AuthUser> signInWithGoogle();
  Future<void> sendPasswordResetEmail({required String email});
}
