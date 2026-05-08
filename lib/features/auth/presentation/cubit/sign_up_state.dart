sealed class SignUpState {
  const SignUpState();
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

final class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

final class SignUpFieldFailure extends SignUpState {
  const SignUpFieldFailure({
    this.nameError,
    this.emailError,
    this.passwordError,
  });

  final String? nameError;
  final String? emailError;
  final String? passwordError;
}

final class SignUpSuccess extends SignUpState {
  const SignUpSuccess();
}

final class SignUpFailure extends SignUpState {
  const SignUpFailure(this.message);
  final String message;
}
