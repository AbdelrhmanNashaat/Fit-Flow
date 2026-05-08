import 'package:fit_flow/core/errors/failure.dart';
import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepo) : super(const SignInInitial());

  final AuthRepo _authRepo;

  Future<void> signIn(String email, String password) async {
    emit(const SignInLoading());
    final result = await _authRepo.signIn(email.trim(), password);
    result.fold(_emitFailure, (user) => emit(SignInSuccess(user)));
  }

  void clearError() => emit(const SignInInitial());

  Future<void> signInWithGoogle() async {
    emit(const SignInLoading(isGoogle: true));
    final result = await _authRepo.signInWithGoogle();
    result.fold(_emitFailure, (user) => emit(SignInSuccess(user)));
  }

  void _emitFailure(Failure failure) {
    if (failure case AuthFailure(code: AuthErrorCode.cancelled)) {
      emit(const SignInInitial());
      return;
    }

    if (failure case AuthFailure(field: FailureField.email, :final message)) {
      emit(SignInFieldFailure(emailError: message));
      return;
    }

    if (failure case AuthFailure(
      field: FailureField.password,
      :final message,
    )) {
      emit(SignInFieldFailure(passwordError: message));
      return;
    }

    emit(SignInFailure(failure.message));
  }
}
