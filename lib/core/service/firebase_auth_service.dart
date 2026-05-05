import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/errors/firebase_errors.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  const FirebaseAuthService({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  }) : _auth = auth,
       _googleSignIn = googleSignIn;

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  Future<void> _ensureLanguageCode() {
    return _auth.setLanguageCode(
      WidgetsBinding.instance.platformDispatcher.locale.languageCode,
    );
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      await _ensureLanguageCode();
      final currentUser = _auth.currentUser;
      if (currentUser == null) return null;

      await currentUser.reload();
      return _mapNullableUser(_auth.currentUser);
    } on FirebaseAuthException catch (e) {
      if (_isInvalidSessionCode(e.code)) {
        await signOut();
        return null;
      }

      throw Exception(FirebaseErrors.fromCode(e.code).message);
    }
  }

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _ensureLanguageCode();
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(credential.user);
    } on FirebaseAuthException catch (e) {
      throw Exception(FirebaseErrors.fromCode(e.code).message);
    }
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _ensureLanguageCode();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapUser(credential.user);
    } on FirebaseAuthException catch (e) {
      throw Exception(FirebaseErrors.fromCode(e.code).message);
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    try {
      await _ensureLanguageCode();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) throw Exception('Google sign-in was cancelled.');

      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null) {
        throw Exception(
          'Google sign-in failed: missing ID token. Check the server client ID configuration.',
        );
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      return _mapUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      throw Exception(FirebaseErrors.fromCode(e.code).message);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _ensureLanguageCode();
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(FirebaseErrors.fromCode(e.code).message);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(FirebaseErrors.fromCode(e.code).message);
    } finally {
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
    }
  }

  AuthUser _mapUser(User? user) {
    if (user == null) throw Exception('Authentication failed: user is null.');
    return AuthUser(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
    );
  }

  AuthUser? _mapNullableUser(User? user) {
    return user == null ? null : _mapUser(user);
  }

  bool _isInvalidSessionCode(String code) {
    return code == 'user-token-expired' ||
        code == 'invalid-user-token' ||
        code == 'user-disabled' ||
        code == 'user-not-found';
  }
}
