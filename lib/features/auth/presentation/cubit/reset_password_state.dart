sealed class ResetPasswordState {
  const ResetPasswordState();
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

class ResetPasswordFieldFailure extends ResetPasswordState {
  const ResetPasswordFieldFailure({this.emailError});

  final String? emailError;
}

class ResetPasswordSuccess extends ResetPasswordState {
  const ResetPasswordSuccess();
}

class ResetPasswordFailure extends ResetPasswordState {
  const ResetPasswordFailure(this.message);
  final String message;
}
