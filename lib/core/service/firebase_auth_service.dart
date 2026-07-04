import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_flow/core/errors/auth_exception.dart';
import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/core/errors/firebase_errors.dart';
import 'package:fit_flow/core/service/auth_service.dart';
import 'package:fit_flow/core/service/cache_helper.dart';
import 'package:fit_flow/features/auth/data/model/auth_user.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthService {
  const FirebaseAuthService({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required CacheHelper cacheHelper,
  }) : _auth = auth,
       _googleSignIn = googleSignIn,
       _cacheHelper = cacheHelper;

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  final CacheHelper _cacheHelper;

  Future<void> _ensureLanguageCode() {
    return _auth.setLanguageCode(
      WidgetsBinding.instance.platformDispatcher.locale.languageCode,
    );
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _auth.authStateChanges().map(_mapNullableUser);
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    try {
      await _ensureLanguageCode();
      final currentUser = _auth.currentUser;
      if (currentUser == null) {
        await _cacheHelper.clearAuthData();
        return null;
      }

      await currentUser.reload();
      final user = _mapNullableUser(_auth.currentUser);
      if (user != null) await _cacheHelper.cacheUserJson(user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      if (_isInvalidSessionCode(e.code)) {
        await signOut();
        return null;
      }
      throw AuthException(FirebaseErrors.fromCode(e.code));
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
      final user = _mapUser(credential.user);
      await _cacheHelper.cacheUserJson(user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(FirebaseErrors.fromCode(e.code));
    }
  }

  @override
  Future<AuthUser> signUp({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      await _ensureLanguageCode();
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;
      if (user == null) {
        throw const AuthException(
          AuthFailure(
            message: 'Authentication failed: user is null.',
            code: AuthErrorCode.unknown,
            field: FailureField.general,
          ),
        );
      }

      if (displayName.trim().isNotEmpty) {
        await user.updateDisplayName(displayName.trim());
        await user.reload();
      }

      final authUser = _mapUser(_auth.currentUser ?? user);
      await _cacheHelper.cacheUserJson(authUser.toJson());
      return authUser;
    } on FirebaseAuthException catch (e) {
      throw AuthException(FirebaseErrors.fromCode(e.code));
    }
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    try {
      await _ensureLanguageCode();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(
          AuthFailure(
            message: 'Google sign-in was cancelled.',
            code: AuthErrorCode.cancelled,
            field: FailureField.general,
          ),
        );
      }

      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken == null) {
        throw const AuthException(
          AuthFailure(
            message: 'Google sign-in is not configured correctly.',
            code: AuthErrorCode.googleConfiguration,
            field: FailureField.general,
          ),
        );
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = _mapUser(userCredential.user);
      await _cacheHelper.cacheUserJson(user.toJson());
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(FirebaseErrors.fromCode(e.code));
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
      throw AuthException(FirebaseErrors.fromCode(e.code));
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _cacheHelper.clearAuthData();
    } on FirebaseAuthException catch (e) {
      throw AuthException(FirebaseErrors.fromCode(e.code));
    } finally {
      try {
        await _googleSignIn.signOut();
      } catch (_) {}
    }
  }

  @override
  Future<void> deleteAccount({String? password}) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw const AuthException(
        AuthFailure(
          message: 'No authenticated user.',
          code: AuthErrorCode.unknown,
          field: FailureField.general,
        ),
      );
    }

    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        await _reauthAndDelete(user, password);
      } else {
        throw AuthException(FirebaseErrors.fromCode(e.code));
      }
    }

    await _cacheHelper.clearAuthData();

    try {
      await _googleSignIn.signOut();
    } catch (_) {}
  }

  Future<void> _reauthAndDelete(User user, String? password) async {
    final provider = user.providerData.isNotEmpty
        ? user.providerData.first.providerId
        : 'password';

    if (provider == 'google.com') {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw const AuthException(
          AuthFailure(
            message: 'Re-authentication was cancelled.',
            code: AuthErrorCode.cancelled,
            field: FailureField.general,
          ),
        );
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await user.reauthenticateWithCredential(credential);
      await user.delete();
    } else {
      // Email/password — needs explicit password from the user
      if (password == null) throw ReauthRequiredException(provider);
      final credential = EmailAuthProvider.credential(
        email: user.email ?? '',
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      await user.delete();
    }
  }

  AuthUser _mapUser(User? user) {
    if (user == null) {
      throw const AuthException(
        AuthFailure(
          message: 'Authentication failed: user is null.',
          code: AuthErrorCode.unknown,
          field: FailureField.general,
        ),
      );
    }

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
