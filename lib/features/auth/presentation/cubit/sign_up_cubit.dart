import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepo) : super(const SignUpInitial());

  final AuthRepo _authRepo;

  Future<void> signUp(String name, String email, String password) async {
    emit(const SignUpLoading());
    final result = await _authRepo.signUp(name.trim(), email.trim(), password);
    result.fold(_emitFailure, (user) => emit(SignUpSuccess(user)));
  }

  void clearError() => emit(const SignUpInitial());

  Future<void> signUpWithGoogle() async {
    emit(const SignUpLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(_emitFailure, (user) => emit(SignUpSuccess(user)));
  }

  void _emitFailure(Failure failure) {
    if (failure case AuthFailure(code: AuthErrorCode.cancelled)) {
      emit(const SignUpInitial());
      return;
    }

    if (failure case AuthFailure(field: FailureField.email, :final message)) {
      emit(SignUpFieldFailure(emailError: message));
      return;
    }

    if (failure case AuthFailure(
      field: FailureField.password,
      :final message,
    )) {
      emit(SignUpFieldFailure(passwordError: message));
      return;
    }

    emit(SignUpFailure(failure.message));
  }
}
