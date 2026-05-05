import 'package:fit_flow/features/auth/data/repo/auth_repo.dart';
import 'package:fit_flow/features/auth/presentation/cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._authRepo) : super(SignUpInitial());

  final AuthRepo _authRepo;
  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());
    final result = await _authRepo.signUp(email, password);
    result.fold(
      (failure) => emit(SignUpFailure(failure.message)),
      (user) => emit(SignUpSuccess(user)),
    );
  }

  Future<void> signUpWithGoogle() async {
    emit(SignUpLoading());
    final result = await _authRepo.signInWithGoogle();
    result.fold(
      (failure) => emit(SignUpFailure(failure.message)),
      (user) => emit(SignUpSuccess(user)),
    );
  }
}
