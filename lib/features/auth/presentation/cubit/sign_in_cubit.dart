import 'package:fit_flow/features/auth/domain/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._authRepo) : super(SignInInitial());

  final AuthRepo _authRepo;

  Future<void> signIn(String email, String password) async {
    emit(const SignInLoading());
    final result = await _authRepo.signIn(email.trim(), password);
    result.fold(
      (failure) => emit(SignInFailure(failure.message)),
      (user) => emit(SignInSuccess(user)),
    );
  }

  void clearError() => emit(SignInInitial());

  Future<void> signInWithGoogle() async {
    emit(const SignInLoading(isGoogle: true));
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SignInFailure(failure.message)),
      (user) => emit(SignInSuccess(user)),
    );
  }
}
