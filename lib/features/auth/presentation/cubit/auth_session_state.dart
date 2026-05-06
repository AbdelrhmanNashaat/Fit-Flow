import 'package:fit_flow/features/auth/data/model/auth_user.dart';

sealed class AuthSessionState {
  const AuthSessionState();
}

class AuthSessionInitial extends AuthSessionState {
  const AuthSessionInitial();
}

class AuthSessionChecking extends AuthSessionState {
  const AuthSessionChecking();
}

class AuthSessionAuthenticated extends AuthSessionState {
  const AuthSessionAuthenticated(this.user);

  final AuthUser user;
}

// Sibling of AuthSessionAuthenticated, NOT a subclass.
// Prevents the global listener in FitFlow from navigating to home during sign-out.
class AuthSessionSigningOut extends AuthSessionState {
  const AuthSessionSigningOut(this.user);

  final AuthUser user;
}

class AuthSessionUnauthenticated extends AuthSessionState {
  const AuthSessionUnauthenticated();
}

class AuthSessionFailure extends AuthSessionState {
  const AuthSessionFailure(this.message, {this.user});

  final String message;
  final AuthUser? user;
}
