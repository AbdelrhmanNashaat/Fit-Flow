import 'package:fit_flow/features/auth/data/model/auth_user.dart';

sealed class SignInState {
  const SignInState();
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SignInLoading extends SignInState {
  const SignInLoading({this.isGoogle = false});

  final bool isGoogle;
}

class SignInFieldFailure extends SignInState {
  const SignInFieldFailure({this.emailError, this.passwordError});

  final String? emailError;
  final String? passwordError;
}

class SignInSuccess extends SignInState {
  const SignInSuccess(this.user);

  final AuthUser user;
}

class SignInFailure extends SignInState {
  const SignInFailure(this.message);

  final String message;
}
