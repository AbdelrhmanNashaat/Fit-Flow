import 'package:fit_flow/features/auth/data/model/auth_user.dart';

sealed class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  SignUpSuccess(this.user);
  final AuthUser user;
}

class SignUpFailure extends SignUpState {
  SignUpFailure(this.message);
  final String message;
}
