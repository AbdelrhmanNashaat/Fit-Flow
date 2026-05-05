import 'package:fit_flow/features/auth/data/model/auth_user.dart';

sealed class SignInState {}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  SignInSuccess(this.user);
  final AuthUser user;
}

class SignInFailure extends SignInState {
  SignInFailure(this.message);
  final String message;
}
